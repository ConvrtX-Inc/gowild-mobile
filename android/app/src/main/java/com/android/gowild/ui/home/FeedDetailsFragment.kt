package com.android.gowild.ui.home

import android.app.Activity
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.activity.result.contract.ActivityResultContracts
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.adapters.HomeAdapter
import com.android.gowild.data.model.feeds.FeedsDataModel
import com.android.gowild.data.model.feeds.LikeFeedRequest
import com.android.gowild.databinding.FragmentFeedDetailsBinding
import com.android.gowild.interfaces.HomeCallback
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.shareText
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.android.gowild.utils.local.UserPrefs
import timber.log.Timber

class FeedDetailsFragment : BaseFragment() {

    lateinit var binding: FragmentFeedDetailsBinding
    val feedDetailsViewModel: FeedDetailsVM by viewModels()

    private var homeDataList: ArrayList<Any> = ArrayList()
    var homeFeeds: ArrayList<FeedsDataModel> = ArrayList()
    private lateinit var homeAdapter: HomeAdapter
    private lateinit var homeCallback: HomeCallback

    var commentsResultLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        if (result.resultCode == Activity.RESULT_OK && result.data != null && result.data!!.extras != null) {
            val commentsCount = result.data!!.extras!!.getInt("count")
            val postPosition = result.data!!.extras!!.getInt("position")
            Timber.tag("COMMENTS").wtf("commentsResultHome count?${commentsCount}")
            Timber.tag("COMMENTS").wtf("commentsResultHome position?${postPosition}")
            (homeDataList[postPosition] as FeedsDataModel).comments = commentsCount
            homeAdapter.notifyItemChanged(postPosition, HomeAdapter.HomePayLoads.PAYLOAD_FEED_UPDATE_COMMENTS)
        }
    }

    companion object {
        @JvmStatic
        fun newInstance() = FeedDetailsFragment()
    }

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentFeedDetailsBinding.inflate(layoutInflater)
        init()
        return binding
    }

    fun init() {
        setAdapter()
        observeNetworkResponses()
        observeFeedDetailsResponse()
        getFeedDetails()
        setCallbacks()
    }

    private fun observeNetworkResponses() {
        observeLikeFeed()
        observeViewFeed()
        observeFeedDetailsResponse()
    }

    private fun setCallbacks() {
        binding.ivBack.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun getFeedDetails() {
        if (arguments != null) {
            val feedID = requireArguments().getString("postID")
            Timber.tag("GW_INTENT").wtf("getFeedDetails() $feedID")
            feedDetailsViewModel.getFeedDetails(feedID.toString())
        } else {
            toast("Feed not found")
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun observeFeedDetailsResponse() {
        feedDetailsViewModel.feedDetailsResponse.observe(this) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    homeFeeds.clear()
                    homeFeeds.add(response.data!!.data)
                    homeDataList.clear()
                    homeDataList.add(response.data!!.data)
                    homeAdapter.notifyDataSetChanged()
                    hideProgress()
                }
                is NetworkResult.Failure -> {
                    hideProgress()
                    response.junkError?.let { junkErrors ->
                        ErrorDialog(mContext, junkErrors.errors!![0].map { it.value }).show()
                    } ?: kotlin.run {
                        binding.root.showBar(response.message ?: "Failure")
                    }
                }
                is NetworkResult.Loading -> {
                    showProgress()
                }
                is NetworkResult.Error -> {
                    when (response.error) {
                        is Errors.Error -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                        is Errors.NetworkError -> {
                            hideProgress()
                            binding.root.showBar("Internet connection unavailable")
                        }
                        is Errors.ServerError -> {
                            hideProgress()
                            binding.root.showBar("Server error")
                        }
                        is Errors.TimeOutError -> {
                            hideProgress()
                            binding.root.showBar("Network time out")
                        }
                        null -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                    }
                }
            }
        }
    }

    private fun observeLikeFeed() {
        feedDetailsViewModel.likeFeedResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    homeDataList[response.extra as Int] = response.data!!.data
                    homeAdapter.notifyItemChanged(response.extra as Int, HomeAdapter.HomePayLoads.PAYLOAD_FEED_UPDATE_LIKES)
                    hideProgress()
                }
                is NetworkResult.Failure -> {
                    hideProgress()
                    response.junkError?.let { junkErrors ->
                        ErrorDialog(mContext, junkErrors.errors!![0].map { it.value }).show()
                    } ?: kotlin.run {
                        binding.root.showBar(response.message ?: "Failure")
                    }
                }
                is NetworkResult.Loading -> {
                    showProgress()
                }
                is NetworkResult.Error -> {
                    when (response.error) {
                        is Errors.Error -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                        is Errors.NetworkError -> {
                            hideProgress()
                            binding.root.showBar("Internet connection unavailable")
                        }
                        is Errors.ServerError -> {
                            hideProgress()
                            binding.root.showBar("Server error")
                        }
                        is Errors.TimeOutError -> {
                            hideProgress()
                            binding.root.showBar("Network time out")
                        }
                        null -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                    }
                }
            }
        }
    }

    private fun observeViewFeed() {
        feedDetailsViewModel.viewFeedResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    (homeDataList[response.extra as Int] as FeedsDataModel).views = response.data!!.data.views
                    homeAdapter.notifyItemChanged(response.extra as Int, HomeAdapter.HomePayLoads.PAYLOAD_FEED_UPDATE_VIEWS)
                    hideProgress()
                }
                is NetworkResult.Failure -> {
                    hideProgress()
                    response.junkError?.let { junkErrors ->
                        ErrorDialog(mContext, junkErrors.errors!![0].map { it.value }).show()
                    } ?: kotlin.run {
                        binding.root.showBar(response.message ?: "Failure")
                    }
                }
                is NetworkResult.Loading -> {
                    showProgress()
                }
                is NetworkResult.Error -> {
                    when (response.error) {
                        is Errors.Error -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                        is Errors.NetworkError -> {
                            hideProgress()
                            binding.root.showBar("Internet connection unavailable")
                        }
                        is Errors.ServerError -> {
                            hideProgress()
                            binding.root.showBar("Server error")
                        }
                        is Errors.TimeOutError -> {
                            hideProgress()
                            binding.root.showBar("Network time out")
                        }
                        null -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                    }
                }
            }
        }
    }

    private fun setAdapter() {
        homeCallback = object : HomeCallback {
            override fun onClickComment(postID: String, position: Int) {
                Timber.tag("COMMENTS").wtf("commentsOnClick position?${position}")
                commentsResultLauncher.launch(MapActivity.start(requireActivity(), "CommentsFragment", postID = postID, position = position))
            }

            override fun onSharePost(postID: String, position: Int) {
                shareText(desc = "Check out this post at Go-Wild-History\n https://gowild.appscorridor.com/feed?feedID=$postID")
            }

            override fun onLikePost(postID: String, position: Int) {
                feedDetailsViewModel.likeFeed(LikeFeedRequest(postID), position)
            }

            override fun onViewPost(postID: String, position: Int) {
                feedDetailsViewModel.viewFeed(postID, position)
            }
        }

        homeAdapter = HomeAdapter(homeDataList, homeCallback, UserPrefs(requireContext()).getUser()!!.id!!)

        binding.rvFeedDetail.itemAnimator = null
        binding.rvFeedDetail.adapter = homeAdapter
    }
}