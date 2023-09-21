package com.android.gowild.ui.home

import android.app.Activity.RESULT_OK
import android.content.Intent
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.activity.addCallback
import androidx.core.os.bundleOf
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.data.model.feeds.AddCommentRequest
import com.android.gowild.data.model.feeds.CommentsModel
import com.android.gowild.databinding.FragmentCommentsBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.base.BindingRecyclerAdapter
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.showBar
import dagger.hilt.android.AndroidEntryPoint
import timber.log.Timber

@AndroidEntryPoint
class CommentsFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() =
            CommentsFragment()
    }

    lateinit var binding: FragmentCommentsBinding
    private val commentsViewModel: CommentsVM by viewModels()

    private lateinit var commentsAdapter: BindingRecyclerAdapter<CommentsModel, Nothing>
    private val commentsList: ArrayList<CommentsModel> = ArrayList()

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentCommentsBinding.inflate(layoutInflater)
        init()
        return binding
    }

    fun init() {
        setCallbacks()
        setObservers()
        setCommentsAdapter()
        commentsViewModel.getFeedComments(requireArguments().getString("postID")!!)
    }

    private fun setCommentsAdapter() {
        commentsAdapter = BindingRecyclerAdapter(
            R.layout.list_item_comments,
            commentsList
        )
        binding.rvComments.adapter = commentsAdapter
    }

    private fun setObservers() {
        observeCommentsResponse()
        observeAddCommentResponse()
    }

    private fun setCallbacks() {
        binding.ivBack.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }

        requireActivity().onBackPressedDispatcher.addCallback(owner = viewLifecycleOwner, enabled = true) {
            Timber.tag("COMMENTS").wtf("commentsResult count?${commentsList.size}")
            Timber.tag("COMMENTS").wtf("commentsResult position?${requireArguments().getInt("position")}")
            val intent = Intent()
            intent.putExtras(bundleOf(
                "count" to commentsList.size,
                "position" to requireArguments().getInt("position")
            ))
            (requireActivity() as MapActivity).setResult(RESULT_OK,intent)
            requireActivity().finish()
        }

        binding.sendButton.setOnClickListener {
            if (binding.messageInput.text.toString().isNotEmpty())
                commentsViewModel.addComment(AddCommentRequest(binding.messageInput.text.toString(), requireArguments().getString("postID")!!))
        }
    }

    private fun observeCommentsResponse() {
        commentsViewModel.commentsResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    commentsList.clear()
                    commentsList.addAll(response.data!!.data)
                    commentsAdapter.notifyDataSetChanged()
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

    private fun observeAddCommentResponse() {
        commentsViewModel.addCommentResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    binding.messageInput.setText("")
                    binding.messageInput.clearFocus()
                    commentsViewModel.getFeedComments(requireArguments().getString("postID")!!)
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
}