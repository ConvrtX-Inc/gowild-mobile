package com.android.gowild.ui.home

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity.RESULT_OK
import android.content.Context
import android.content.Intent
import android.content.IntentSender
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Parcelable
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Toast
import androidx.activity.result.IntentSenderRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import androidx.core.widget.doAfterTextChanged
import androidx.fragment.app.viewModels
import androidx.lifecycle.distinctUntilChanged
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.adapters.HomeAdapter
import com.android.gowild.data.model.feeds.CreateFeedPostRequestModel
import com.android.gowild.data.model.feeds.FeedsDataModel
import com.android.gowild.data.model.feeds.LikeFeedRequest
import com.android.gowild.data.model.friends.FriendsDataModel
import com.android.gowild.data.model.friends.MyFriendsDataModel
import com.android.gowild.data.model.homeModels.*
import com.android.gowild.data.model.myTrail.SaveRoutesLeaderboardModel
import com.android.gowild.data.model.myTrail.UnSaveRouteRequestModel
import com.android.gowild.data.model.routes.ApprovedRoutesResponse
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.data.model.settings.MyAchievementsDataModel
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.data.model.user.User
import com.android.gowild.databinding.FragmentHomeNewBinding
import com.android.gowild.dialogs.MapDialog
import com.android.gowild.interfaces.HomeCallback
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.ui.map.TryRouteActivityNew
import com.android.gowild.ui.messages.MessageActivity
import com.android.gowild.ui.setting.SettingsActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.RouteSelectorHelper
import com.android.gowild.utils.constant.MAP_TYPE
import com.android.gowild.utils.constant.isProfileDataUpdated
import com.android.gowild.utils.extension.*
import com.android.gowild.utils.local.UserPrefs
import com.anggrayudi.storage.SimpleStorageHelper
import com.anggrayudi.storage.file.openInputStream
import com.github.drjacky.imagepicker.ImagePicker
import com.github.drjacky.imagepicker.constant.ImageProvider
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.common.api.ResolvableApiException
import com.google.android.gms.location.*
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.MapsInitializer
import com.google.android.gms.tasks.CancellationTokenSource
import com.google.android.gms.tasks.Task
import com.google.gson.Gson
import com.permissionx.guolindev.PermissionX
import com.squareup.picasso.Picasso
import com.stfalcon.imageviewer.StfalconImageViewer
import dagger.hilt.android.AndroidEntryPoint
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody.Companion.asRequestBody
import okhttp3.RequestBody.Companion.toRequestBody
import timber.log.Timber
import java.io.File
import java.io.InputStream
import java.util.*


@AndroidEntryPoint
class HomeFragmentNew : BaseFragment() {

    // FIXME: outsource operations outside fragment

    companion object {
        @JvmStatic
        fun newInstance() = HomeFragmentNew()
    }

    private lateinit var binding: FragmentHomeNewBinding
    val homeViewModel: HomeFragmentVM by viewModels()

    private var homeDataList: ArrayList<Any> = ArrayList()
    private lateinit var homeAdapter: HomeAdapter
    private lateinit var homeCallback: HomeCallback

    /**
     * HomeAdapter Objects and arrays
     */

    var routes: ArrayList<RouteDataModel> = ArrayList()
    var homeMapModel = HomeMapModel()

    var adventures: ArrayList<TreasureWildResponse.TreasureWildListingData> = ArrayList()
    var homeAdventuresModel = HomeNearbyAdventureListModel(adventures)

    var homeFeedTabsModel: HomeFeedTabsModel = HomeFeedTabsModel()
    var homeFeedCreatePostModel: HomeFeedCreatePostModel = HomeFeedCreatePostModel()
    var homeFeeds: ArrayList<FeedsDataModel> = ArrayList()
    var tempHomeFeeds: ArrayList<FeedsDataModel> = ArrayList()
    var suggestedFriends: ArrayList<FriendsDataModel> = ArrayList()
    var messagesInbox: ArrayList<MyFriendsDataModel> = ArrayList()

    var mapPosition = -1
    var nearbyPosition = -1
    var suggestedFriendsPosition = -1
    var feedsPosition = -1
    var messagesInboxPosition = -1
    var createFeedPosition = -1

    var headerMapPosition = 0
    var headerAdventuresPosition = 1
    var headerFeedsPosition = 2

    var userLat: Double = 0.0
    var userLng: Double = 0.0

    lateinit var googleMap: GoogleMap
    private val fusedLocationClient: FusedLocationProviderClient by lazy {
        LocationServices.getFusedLocationProviderClient(requireActivity())
    }
    private var cancellationTokenSource = CancellationTokenSource()
    private var isGPS: Boolean = false

    private val storageHelper = SimpleStorageHelper(this)

    private var routeSelectorHelper: RouteSelectorHelper = RouteSelectorHelper()

    /**
     * HomeAdapter Objects and arrays
     */

    private val imagePickerLauncher =
        registerForActivityResult(ActivityResultContracts.StartActivityForResult()) {
            if (it.resultCode == RESULT_OK) {
                Timber.tag("HOME_POSITIONS").wtf(createFeedPosition.toString())
                homeFeedCreatePostModel.selectedImageUri = it.data!!.data
                Timber.tag("HOME_POSITIONS").wtf("SelectedImageUri = ${it.data!!.data}")
                homeAdapter.notifyItemChanged(createFeedPosition, HomeAdapter.HomePayLoads.PAYLOAD_FEED_CREATE_IMAGE_UPDATED)
            }
        }

    var commentsResultLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        if (result.resultCode == RESULT_OK && result.data != null && result.data!!.extras != null) {
            val commentsCount = result.data!!.extras!!.getInt("count")
            val postPosition = result.data!!.extras!!.getInt("position")
            Timber.tag("COMMENTS").wtf("commentsResultHome count?${commentsCount}")
            Timber.tag("COMMENTS").wtf("commentsResultHome position?${postPosition}")
            (homeDataList[postPosition] as FeedsDataModel).comments = commentsCount
            homeAdapter.notifyItemChanged(postPosition, HomeAdapter.HomePayLoads.PAYLOAD_FEED_UPDATE_COMMENTS)
        }
    }

    var mapOverlayLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        if (result.resultCode == RESULT_OK && result.data != null && result.data!!.extras != null) {
            val mapType = result.data!!.extras!!.getString("map_type")
            Timber.tag("MAP_OVERLAY").wtf("mapOverLayResultHome mapType?${mapType}")
            (homeDataList[mapPosition] as HomeMapModel).mapType = mapType!!
            homeAdapter.notifyItemChanged(mapPosition, HomeAdapter.HomePayLoads.PAYLOAD_MAP_TYPE_UPDATED)
        }
    }

    var tryRouteResultLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        if (mapPosition != -1 && result.resultCode == RESULT_OK && result.data != null) {
            val routeCompleted: MyAchievementsDataModel =
                Gson().fromJson(result.data!!.getStringExtra("route_leader_board"), MyAchievementsDataModel::class.java)
            val routePosition = result.data!!.getIntExtra("route_position", 0)
            val saveRoutesLeaderBoardResponse = SaveRoutesLeaderboardModel(
                routeCompleted.route_id,
                userPrefs.getUser()!!.picture,
                userPrefs.getUser()!!.firstName + " " + userPrefs.getUser()!!.lastName,
                userPrefs.getUser()!!.id!!
            )
            // TODO: send payload with route position check how to do this
            homeMapModel.routes[routePosition].crr_user_leaderboard = saveRoutesLeaderBoardResponse
            homeAdapter.notifyItemChanged(mapPosition, arrayOf(HomeAdapter.HomePayLoads.PAYLOAD_MAP_ROUTE_LEADERBOARD_UPDATED, routePosition))
        }
    }

    private val notificationPermissionLauncher = registerForActivityResult(ActivityResultContracts.RequestPermission()) { isGranted: Boolean ->
        if (isGranted) {
            toast("Launcher Granted")
        } else {
            toast("Launcher Please grant sufficient permission to receive important notifications from Go Wild")
        }
    }

    private fun askNotificationPermission() {
        // This is only necessary for API level >= 33 (TIRAMISU)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            if (ContextCompat.checkSelfPermission(requireContext(), Manifest.permission.POST_NOTIFICATIONS) == PackageManager.PERMISSION_GRANTED) {
                toast("Granted")
            } else if (shouldShowRequestPermissionRationale(Manifest.permission.POST_NOTIFICATIONS)) {
                // TODO: display an educational UI explaining to the user the features that will be enabled
                //       by them granting the POST_NOTIFICATION permission. This UI should provide the user
                //       "OK" and "No thanks" buttons. If the user selects "OK," directly request the permission.
                //       If the user selects "No thanks," allow the user to continue without notifications.
                toast("Please give permission to receive important notifications from Go Wild")
            } else {
                toast("Else")
                // Directly ask for the permission
                notificationPermissionLauncher.launch(Manifest.permission.POST_NOTIFICATIONS)
            }
        }
    }

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentHomeNewBinding.inflate(layoutInflater)
        init()
        return binding
    }

    private fun init() {
        initGoogleMaps()
        setCallbacks()
        setAdapters()
        setObservers()
        setUserData()
//        askNotificationPermission()
    }

    private fun initGoogleMaps() {
        MapsInitializer.initialize(requireContext(), MapsInitializer.Renderer.LATEST) { p0 ->
            Timber.tag("MAP_SDK_ISSUE").wtf(p0.name)
        }
        requestPermissionsX()
    }

    private fun setObservers() {
        observeFeeds()
        observeSuggestedFriends()
        observeMessageInbox()
        observeCreateFeed()
        observeUpdateFeedImage()
        observeUpdateAttachmentImage()
        observeDeleteSuggestedFriend()
        observeSendFriendRequest()
        observeTreasureWilds()
        observeApprovedRoutes()
        observeFeedsAndSuggestedFriends()
        observeSaveUnSaveRoute()
        observeLikeFeed()
        observeViewFeed()
    }

    private fun observeViewFeed() {
        homeViewModel.viewFeedResponse.observe(viewLifecycleOwner) { response ->
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

    private fun observeLikeFeed() {
        homeViewModel.likeFeedResponse.observe(viewLifecycleOwner) { response ->
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

    private fun observeSaveUnSaveRoute() {
        homeViewModel.saveUnSaveRouteResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    homeMapModel.routes[response.extra as Int].saved = response.data!!.data
                    if (mapPosition != -1) {
                        homeAdapter.notifyItemChanged(mapPosition)
                    }
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

    private fun observeFeedsAndSuggestedFriends() {
        homeViewModel.feedsAndFriendsChainedResponse.distinctUntilChanged()
            .observe(viewLifecycleOwner) { chainedResponse ->
                when {
                    chainedResponse.first is NetworkResult.Success && chainedResponse.second is NetworkResult.Success -> {
                        hideProgress()
                        Timber.tag("CHAINED")
                            .wtf("feeds = ${chainedResponse.first.data!!.data.size} friends = ${chainedResponse.second.data!!.data.size}")

                        homeFeeds.clear()
                        homeFeeds.addAll(chainedResponse.first.data!!.data)

                        tempHomeFeeds.clear()
                        tempHomeFeeds.addAll(chainedResponse.first.data!!.data)

                        suggestedFriends.clear()
                        suggestedFriends.addAll(chainedResponse.second.data!!.data)

                        homeDataList.add(homeFeedTabsModel)
                        homeDataList.add(homeFeedCreatePostModel)
                        createFeedPosition = homeDataList.lastIndex
                        if (suggestedFriends.isNotEmpty()) {
                            suggestedFriendsPosition = homeDataList.lastIndex + 1
                            homeDataList.addAll(suggestedFriends.subList(0, 2))
                        } else {
                            suggestedFriendsPosition = -1
                        }
                        if (homeFeeds.isNotEmpty()) {
                            feedsPosition = homeDataList.lastIndex + 1
                        } else {
                            feedsPosition = -1
                        }
                        homeDataList.addAll(homeFeeds)
                        homeAdapter.notifyItemRangeInserted(headerFeedsPosition + 1, homeDataList.size - 1)
                    }

                    chainedResponse.first is NetworkResult.Loading && chainedResponse.second is NetworkResult.Loading -> {
                        showProgress()
                        Timber.tag("CHAINED").wtf("loading")
                    }

                    chainedResponse.first is NetworkResult.Error && chainedResponse.second is NetworkResult.Error -> {
                        when (chainedResponse.first.error) {
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
                        when (chainedResponse.second.error) {
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

                    chainedResponse.first is NetworkResult.Failure && chainedResponse.second is NetworkResult.Failure -> {
                        hideProgress()
                        Timber.tag("CHAINED").wtf("failure")
                    }

                    else -> {
                        Timber.tag("CHAINED").wtf("else")
                    }
                }
            }
    }

    private fun observeApprovedRoutes() {
        homeViewModel.approvedRoutesResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    if (response.data!!.count != 0) {
                        if (response.data.currentPage == 1) {
                            routeSelectorHelper.setupHelper(homeMapModel, response.data, homeAdapter) {
                                homeViewModel.getApprovedRoutes(userLat, userLng, homeMapModel.apiCurrentPage + 1)
                            }
                        } else {
                            routeSelectorHelper.addMoreRoutes(response.data)
                        }
                        if ((homeDataList[headerMapPosition] as HomeHeaderModel).isActive && mapPosition == -1) {
                            homeDataList.add(headerMapPosition + 1, homeMapModel)
                            homeAdapter.notifyItemInserted(headerMapPosition + 1)
                            mapPosition = headerMapPosition + 1
                        }
                    } else {
                        toast("No routes available")
                    }
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

    private fun observeTreasureWilds() {
        homeViewModel.treasureWildListingResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    adventures.clear()
                    adventures.addAll(response.data!!.data)
                    homeAdventuresModel.nearbyAdventures = adventures

                    homeDataList.add(headerAdventuresPosition + 1, homeAdventuresModel)
                    homeAdapter.notifyItemInserted(headerAdventuresPosition + 1)
                    nearbyPosition = headerAdventuresPosition + 1

                    (homeDataList[headerAdventuresPosition] as HomeHeaderModel).count = adventures.size
                    homeAdapter.notifyItemChanged(headerAdventuresPosition, HomeAdapter.HomePayLoads.PAYLOAD_HEADER_COUNT)

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

    private fun observeCreateFeed() {
        homeViewModel.createFeedsResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    if (feedsPosition != -1) {
                        if (homeFeedCreatePostModel.selectedImageUri == null && homeFeedCreatePostModel.selectedAttachmentUri == null) {
                            homeDataList.add(feedsPosition, response.data!!.data)
                            homeAdapter.notifyItemInserted(feedsPosition)
                            Timber.tag("BINDTIME").wtf("feedsPosition?$feedsPosition")
                            toast("Post created successfully")
                        } else {
                            if (homeFeedCreatePostModel.selectedImageUri != null) {
                                val file = File(homeFeedCreatePostModel.selectedImageUri!!.path!!)
                                homeViewModel.updateFeedImage(
                                    response.data!!.data.id,
                                    MultipartBody.Part.createFormData(
                                        "file", file.name, file.asRequestBody("image/*".toMediaType())
                                    )
                                )
                            } else {
                                val inputStream: InputStream =
                                    homeFeedCreatePostModel.selectedAttachmentUri!!.openInputStream(requireContext())!!

                                homeViewModel.updateFeedAttachment(
                                    response.data!!.data.id,
                                    MultipartBody.Part.createFormData(
                                        "attachment",
                                        "pdf.pdf",
                                        inputStream.readBytes().toRequestBody(contentType = "application/plain".toMediaType())
                                    )
                                )
                                inputStream.close()
                            }
                        }
                    }
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

    private fun observeUpdateFeedImage() {
        homeViewModel.updateFeedImageResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    if (feedsPosition != -1) {
                        if (homeFeedCreatePostModel.selectedAttachmentUri == null) {
                            toast("Post created successfully")
                            homeDataList.add(feedsPosition, response.data!!.data)
                            homeAdapter.notifyItemInserted(feedsPosition)
                            homeFeedCreatePostModel.selectedImageUri = null
                            homeAdapter.notifyItemChanged(createFeedPosition, HomeAdapter.HomePayLoads.PAYLOAD_FEED_CREATE_IMAGE_UPDATED)
                            Timber.tag("BINDTIME").wtf("feedsPosition?$feedsPosition")
                        } else {
                            val inputStream: InputStream =
                                homeFeedCreatePostModel.selectedAttachmentUri!!.openInputStream(requireContext())!!

                            homeViewModel.updateFeedAttachment(
                                response.data!!.data.id,
                                MultipartBody.Part.createFormData(
                                    "attachment", "pdf.pdf", inputStream.readBytes().toRequestBody(contentType = "application/plain".toMediaType())
                                )
                            )
                            inputStream.close()
                        }
                    }
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

    private fun observeUpdateAttachmentImage() {
        homeViewModel.updateFeedAttachmentResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    if (feedsPosition != -1) {
                        toast("Post created successfully")
                        homeDataList.add(feedsPosition, response.data!!.data)
                        homeAdapter.notifyItemInserted(feedsPosition)
                        homeFeedCreatePostModel.selectedImageUri = null
                        homeFeedCreatePostModel.selectedAttachmentUri = null
                        homeAdapter.notifyItemChanged(createFeedPosition, HomeAdapter.HomePayLoads.PAYLOAD_FEED_CREATE_ATTACHMENT_UPDATED)
                        Timber.tag("BINDTIME").wtf("feedsPosition?$feedsPosition")
                    }
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

    private fun observeMessageInbox() {
        homeViewModel.myFriendsResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    messagesInbox.clear()
                    messagesInbox.addAll(response.data!!.data)

                    homeDataList.subList(headerFeedsPosition + 1, homeDataList.size).clear()
                    homeAdapter.notifyItemRangeRemoved(headerFeedsPosition + 1, homeDataList.size - 1)

                    suggestedFriendsPosition = -1
                    feedsPosition = -1
                    createFeedPosition = -1

                    if (messagesInbox.isNotEmpty()) {
                        messagesInboxPosition = homeDataList.lastIndex + 1
                    } else {
                        messagesInboxPosition = -1
                    }
                    homeDataList.add(homeFeedTabsModel)
                    homeDataList.addAll(messagesInbox)
                    homeAdapter.notifyItemRangeInserted(headerFeedsPosition + 1, homeDataList.size - 1)
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

    private fun observeSuggestedFriends() {
        homeViewModel.suggestedFriendsResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    suggestedFriends.clear()
                    suggestedFriends.addAll(response.data!!.data)
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

    private fun observeFeeds() {
        homeViewModel.feedsResponse.observe(this) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    homeFeeds.clear()
                    tempHomeFeeds.clear()
                    homeFeeds.addAll(response.data!!.data)
                    tempHomeFeeds.addAll(response.data.data)
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

    private fun observeDeleteSuggestedFriend() {
        homeViewModel.deleteSuggestedFriendResponse.observe(this) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    homeDataList[suggestedFriendsPosition] = suggestedFriends[0]
                    homeDataList[suggestedFriendsPosition + 1] = suggestedFriends[1]
                    homeAdapter.notifyItemRangeChanged(suggestedFriendsPosition, 2)
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

    private fun observeSendFriendRequest() {
        homeViewModel.sendFriendRequestResponse.observe(this) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    homeDataList[suggestedFriendsPosition] = suggestedFriends[0]
                    homeDataList[suggestedFriendsPosition + 1] = suggestedFriends[1]
                    homeAdapter.notifyItemRangeChanged(suggestedFriendsPosition, 2)
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

    private fun setAdapters() {
        homeCallback = object : HomeCallback {
            override fun onClickPostImage(imageURL: String) {
                StfalconImageViewer.Builder(context, mutableListOf(imageURL)) { view, image_URL ->
                    Picasso.get().load(image_URL).into(view)
                }.show()
            }

            override fun onClickPDF(attachment: String) {
                val i = Intent(Intent.ACTION_VIEW)
                i.data = Uri.parse(attachment)
                startActivity(i)
            }

            override fun onClickComment(postID: String, position: Int) {
                Timber.tag("COMMENTS").wtf("commentsOnClick position?${position}")
                commentsResultLauncher.launch(MapActivity.start(requireActivity(), "CommentsFragment", postID = postID, position = position))
            }

            override fun onClickHeader(headerData: HomeHeaderModel, position: Int) {
                Timber.tag("HomeAdapter").wtf("onClickHeader pos=$position ${headerData.title} ${headerData.isActive} ")
                when (headerData.title.lowercase()) {
                    getString(R.string.routes).lowercase() -> {
                        headerMapPosition = position
                        (homeDataList[position] as HomeHeaderModel).isActive = !headerData.isActive
                        homeAdapter.notifyItemChanged(
                            position,
                            HomeAdapter.HomePayLoads.PAYLOAD_HEADER_ACTIVE
                        )
                        if (headerData.isActive) {
                            resetMapRoutes()
                            homeViewModel.getApprovedRoutes(userLat, userLng, 1)
                        } else {
                            if (mapPosition != -1) {
                                homeDataList.removeAt(position + 1)
                                homeAdapter.notifyItemRemoved(position + 1)
                                mapPosition = -1
                            }
                        }
                    }

                    getString(R.string.nearby_adventures).lowercase() -> {
                        headerAdventuresPosition = position
                        (homeDataList[position] as HomeHeaderModel).isActive = !headerData.isActive
                        homeAdapter.notifyItemChanged(
                            position,
                            HomeAdapter.HomePayLoads.PAYLOAD_HEADER_ACTIVE
                        )
                        if (headerData.isActive) {
                            homeViewModel.getTreasureWildListing(1)
                        } else {
                            if (homeDataList[position + 1] is HomeNearbyAdventureListModel) {
                                homeDataList.removeAt(position + 1)
                                homeAdapter.notifyItemRemoved(position + 1)
                                nearbyPosition = -1
                            }
                        }
                    }

                    getString(R.string.go_wild_feed).lowercase() -> {
                        headerFeedsPosition = position
                        (homeDataList[position] as HomeHeaderModel).isActive = !headerData.isActive
                        homeAdapter.notifyItemChanged(
                            position,
                            HomeAdapter.HomePayLoads.PAYLOAD_HEADER_ACTIVE
                        )
                        if (headerData.isActive) {
                            when (homeFeedTabsModel.selectedTab) {
                                HomeAdapter.HomeFeedSelectedTab.MY_FEED -> {
                                    homeViewModel.getFeedsAndFriendsChainedResponse()
                                }

                                HomeAdapter.HomeFeedSelectedTab.MY_FRIENDS_MESSAGES -> {
                                    homeViewModel.getFriends()
                                }
                            }
                        } else {
                            homeDataList.subList(position + 1, homeDataList.size).clear()
                            suggestedFriendsPosition = -1
                            feedsPosition = -1
                            messagesInboxPosition = -1
                            homeAdapter.notifyItemRangeRemoved(position + 1, suggestedFriends.size - 1)
                        }
                    }
                }
            }

            override fun onMapReady(googleMap: GoogleMap) {
                this@HomeFragmentNew.googleMap = googleMap
                googleMap.uiSettings.isZoomControlsEnabled = false
                googleMap.uiSettings.isMyLocationButtonEnabled = true
            }

            override fun parentShouldHandleTouch(handleTouch: Boolean) {
                binding.rvHome.requestDisallowInterceptTouchEvent(handleTouch)
                Timber.tag("HomeAdapter").wtf("handleTouch?$handleTouch")
            }

            override fun onNearbyScroll(position: Parcelable?) {
                homeAdventuresModel.scrollPosition = position
            }

            // FIXME: remove position not needed
            override fun onAddSuggestFriend(data: FriendsDataModel, position: Int) {
                homeViewModel.sendFriendRequest(data.email!!)
                suggestedFriends.remove(data)
            }

            // FIXME: remove position not needed
            override fun onDelSuggestFriend(data: FriendsDataModel, position: Int) {
                homeViewModel.deleteSuggestedFriend(data.id!!)
                suggestedFriends.remove(data)
            }

            override fun onClickMessage(data: MyFriendsDataModel, position: Int) {
                // TODO: change different params and send the model instead
                MessageActivity.start(
                    requireActivity(),
                    "",
                    data.to_user_id,
                    data.to_user.firstName + " " + data.to_user.lastName,
                    data.to_user.picture.toString()
                )
            }

            override fun onFeedTabSelected(data: HomeAdapter.HomeFeedSelectedTab, position: Int) {
                (homeDataList[position] as HomeFeedTabsModel).selectedTab = data
                homeAdapter.notifyItemChanged(
                    position,
                    HomeAdapter.HomePayLoads.PAYLOAD_FEED_ACTIVE_TAB
                )
                when (data) {
                    HomeAdapter.HomeFeedSelectedTab.MY_FEED -> {
                        homeDataList.subList(position + 1, homeDataList.size).clear()
                        homeAdapter.notifyItemRangeRemoved(position + 1, suggestedFriends.size - 1)

                        messagesInboxPosition = -1

                        homeDataList.add(homeFeedCreatePostModel)

                        createFeedPosition = homeDataList.lastIndex

                        if (suggestedFriends.isNotEmpty()) {
                            suggestedFriendsPosition = homeDataList.lastIndex + 1
                            homeDataList.addAll(suggestedFriends.subList(0, 2))
                        } else {
                            suggestedFriendsPosition = -1
                        }

                        if (homeFeeds.isNotEmpty()) {
                            feedsPosition = homeDataList.lastIndex + 1
                        } else {
                            feedsPosition = -1
                        }

                        homeDataList.addAll(homeFeeds)
                        homeAdapter.notifyItemRangeInserted(position + 1, homeDataList.size - 1)
                    }

                    HomeAdapter.HomeFeedSelectedTab.MY_FRIENDS_MESSAGES -> {
                        if (messagesInbox.isNotEmpty()) {
                            homeDataList.subList(position + 1, homeDataList.size).clear()
                            homeAdapter.notifyItemRangeRemoved(position + 1, homeDataList.size - 1)

                            suggestedFriendsPosition = -1
                            feedsPosition = -1
                            createFeedPosition = -1

                            if (messagesInbox.isNotEmpty()) {
                                messagesInboxPosition = homeDataList.lastIndex + 1
                            } else {
                                messagesInboxPosition = -1
                            }
//                            homeDataList.add(homeFeedTabsModel)
                            homeDataList.addAll(messagesInbox)
                            homeAdapter.notifyItemRangeInserted(position + 1, homeDataList.size - 1)
                        } else {
                            homeViewModel.getFriends()
                        }
                    }
                }
            }

            override fun onSeeAllFriends() {
                requireActivity().startActivity(MapActivity.start(requireActivity(), "friendRequestFragment"))
            }

            override fun onPreviousRoutes() {
                routeSelectorHelper.selectPrevious()
            }

            override fun onNextRoutes() {
                routeSelectorHelper.selectNext()
            }

            override fun onPostFeed(description: String, position: Int) {
                if (description != "")
                    homeViewModel.createFeed(
                        CreateFeedPostRequestModel(
                            description,
                            UserPrefs(requireContext()).getUser()!!.firstName + " " + UserPrefs(requireContext()).getUser()!!.lastName
                        )
                    )
                else
                    binding.root.showBar("Please enter post description!")
            }

            override fun onSelectImage(position: Int) {
                Timber.tag("HOME_POSITION").wtf("onSelectImage position$position")
                ImagePicker.with(requireActivity()).crop().maxResultSize(1000, 1000)
                    .provider(ImageProvider.BOTH).createIntentFromDialog { intent ->
                        val bundle: Bundle? = intent.extras
                        bundle!!.putInt("POSITION", position)
                        intent.putExtras(bundle)
                        imagePickerLauncher.launch(intent)
                    }
            }

            override fun onSelectAttachment(position: Int) {
                storageHelper.openFilePicker(101, filterMimeTypes = arrayOf("application/pdf"))

                storageHelper.onFileSelected = { requestCode, files ->
                    homeFeedCreatePostModel.selectedAttachmentUri = files.first()
                    Timber.tag("HOME_POSITIONS").wtf(createFeedPosition.toString())
                    homeAdapter.notifyItemChanged(createFeedPosition, HomeAdapter.HomePayLoads.PAYLOAD_FEED_CREATE_ATTACHMENT_UPDATED)
                }
            }

            override fun onRemoveImage(position: Int) {
                homeFeedCreatePostModel.selectedImageUri = null
                homeAdapter.notifyItemChanged(createFeedPosition, HomeAdapter.HomePayLoads.PAYLOAD_FEED_CREATE_IMAGE_UPDATED)
            }

            override fun onRemovePDF(position: Int) {
                homeFeedCreatePostModel.selectedAttachmentUri = null
                homeAdapter.notifyItemChanged(createFeedPosition, HomeAdapter.HomePayLoads.PAYLOAD_FEED_CREATE_ATTACHMENT_UPDATED)
            }

            override fun onSelectRoute(position: Int) {
                Timber.tag("ROUTE_POSITION").wtf("HomeFragment $position")
                routeSelectorHelper.updateSelectedRoute(position)
                if (mapPosition != -1) {
                    homeAdapter.notifyItemChanged(mapPosition)
                }
            }

            override fun onMapClick(route: RouteDataModel) {
                val mapDialog = MapDialog(route)
                mapDialog.show(childFragmentManager, "")
            }

            override fun onTryRoute(routeDataModel: RouteDataModel, position: Int) {
//                val intent = Intent(requireContext(), TryRouteActivityNew::class.java)
//                startActivity(intent)
//                if (routeDataModel.crr_user_leaderboard == null) {
                if (routeDataModel.polyline != null && routeDataModel.polyline != "") {
                    val intent = Intent(requireContext(), TryRouteActivityNew::class.java)
                    intent.putExtra("route", Gson().toJson(routeDataModel))
                    intent.putExtra("position", position)
                    tryRouteResultLauncher.launch(intent)
                } else {
                    toast("Route unavailable")
                }
//                } else {
//                    toast("Route tried already")
//                }
            }

            override fun onSaveUnSaveRoute(routeDataModel: RouteDataModel, position: Int) {
                Timber.tag("SAVE ROUTE POSITION").wtf("$position ${routeDataModel.title}")
                homeViewModel.saveUnSaveRoute(UnSaveRouteRequestModel(routeDataModel.id), position)
            }

            override fun onRouteDetail(routeDataModel: RouteDataModel) {
                requireActivity().startActivity(MapActivity.start(requireActivity(), "RouteDetails", route_id = routeDataModel.id))
            }

            override fun onSelectMapOverlay(mapType: String) {
                mapOverlayLauncher.launch(MapActivity.start(requireActivity(), "MapOverlay"))
            }

            override fun onSharePost(postID: String, position: Int) {
                shareText(desc = "Check out this post at Go-Wild-History\n https://gowild.appscorridor.com/feed?feedID=$postID")
            }

            override fun onLikePost(postID: String, position: Int) {
                homeViewModel.likeFeed(LikeFeedRequest(postID), position)
            }

            override fun onViewPost(postID: String, position: Int) {
                homeViewModel.viewFeed(postID, position)
            }
        }

        homeAdapter = HomeAdapter(homeDataList, homeCallback, UserPrefs(requireContext()).getUser()!!.id!!)

        homeDataList.add(HomeHeaderModel(getString(R.string.routes).titleCase()))
        homeDataList.add(HomeHeaderModel(getString(R.string.nearby_adventures).titleCase()))
        homeDataList.add(HomeHeaderModel(getString(R.string.go_wild_feed).titleCase()))

        homeFeedCreatePostModel.user = UserPrefs(requireContext()).getUser()!!

        binding.rvHome.itemAnimator = null
        binding.rvHome.adapter = homeAdapter
    }

    // TODO: move these route paging related functions inside home adapter or maybe routes adapter ?
    private fun setInitialRoutesPages(data: ApprovedRoutesResponse) {
        homeMapModel.apiCurrentPage = data.currentPage
        homeMapModel.apiTotalPages = data.totalPage
        homeMapModel.apiTotalCount = data.count
        if (routes.size < 4) {
            homeMapModel.routes.addAll(routes)
            homeMapModel.routes.forEachIndexed { index, routeDataModel -> routeDataModel.isSelected = homeMapModel.selectedItemIndex == index }
            homeAdapter.notifyItemChanged(mapPosition)
        } else {
            getNextRoutes()
        }
    }

    private fun resetMapRoutes() {
        homeMapModel.routes.clear()
        homeMapModel.apiCurrentPage = 1
        homeMapModel.apiTotalCount = 0
        homeMapModel.apiTotalPages = 0
        homeMapModel.routesIndex = -1
        homeMapModel.selectedItemIndex = 0
        homeMapModel.lat = 0.0
        homeMapModel.lng = 0.0
        homeMapModel.routes = ArrayList()
        homeMapModel.zoom = 14f
        homeMapModel.mapType = MAP_TYPE
    }

    private fun getNextRoutes() {
        if (routes.isNotEmpty() && routes.size > 3 && homeMapModel.apiCurrentPage <= homeMapModel.apiTotalPages) {
            if (routes.getOrNull(homeMapModel.routesIndex + 3) != null) {
                homeMapModel.routes.clear()
                val start = homeMapModel.routesIndex + 1
                val end = homeMapModel.routesIndex + 3
                Timber.tag("ROUTES_PAGINATION").wtf("getNextRoutes start = $start end = $end routes = ${routes.size}")
                homeMapModel.routes.addAll(routes.slice(start..end))
                homeMapModel.routes.forEachIndexed { index, routeDataModel -> routeDataModel.isSelected = homeMapModel.selectedItemIndex == index }
                homeAdapter.notifyItemChanged(mapPosition)
                homeMapModel.routesIndex++
            } else {
                homeViewModel.getApprovedRoutes(userLat, userLng, homeMapModel.apiCurrentPage + 1)
            }
        }
    }

    private fun getPreviousRoutes() {
        if (routes.isNotEmpty() && routes.size > 3 && homeMapModel.routesIndex != 0) {
            homeMapModel.routes.clear()
            val start = homeMapModel.routesIndex - 1
            val end = homeMapModel.routesIndex - 1 + 2
            homeMapModel.routes.addAll(routes.slice(start..end))
            Timber.tag("ROUTES_PAGINATION").wtf("getPrevRoutes start = $start end = $end routes = ${routes.size}")
            homeMapModel.routes.forEachIndexed { index, routeDataModel -> routeDataModel.isSelected = homeMapModel.selectedItemIndex == index }
            homeAdapter.notifyItemChanged(mapPosition)
            homeMapModel.routesIndex--
        }
    }

    private fun setCallbacks() {
        binding.imageCard.setOnClickListener {
            activity?.let {
                SettingsActivity.start(it)
            }

        }
        binding.etSearch.doAfterTextChanged { text ->
            if (homeFeedTabsModel.selectedTab == HomeAdapter.HomeFeedSelectedTab.MY_FEED && feedsPosition != -1) {
                homeDataList.subList(feedsPosition, homeDataList.size).clear()
                homeAdapter.notifyItemRangeRemoved(feedsPosition, homeFeeds.size)
                homeFeeds.clear()
                homeFeeds.addAll(tempHomeFeeds.filter {
                    it.user!!.firstName!!.lowercase().contains(text.toString().lowercase()) || it.user!!.lastName!!.lowercase()
                        .contains(text.toString().lowercase())
                            || (it.user!!.firstName!!.lowercase() + " " + it.user!!.lastName!!.lowercase()).contains(text.toString().lowercase())
                })
                homeDataList.addAll(homeFeeds)
                homeAdapter.notifyItemRangeInserted(feedsPosition, homeFeeds.size)
                Timber.tag("SEARCH").wtf("-----------------------")
                Timber.tag("SEARCH").wtf("$text  =  homeDataList = ${homeDataList.size}")
                Timber.tag("SEARCH").wtf("$text  =  homeFeeds = ${homeFeeds.size}")
                Timber.tag("SEARCH").wtf("$text  =  tempHomeFeeds = ${tempHomeFeeds.size}")
                Timber.tag("SEARCH").wtf("$text  =  feedsPosition = $feedsPosition")
                Timber.tag("SEARCH").wtf("-----------------------")
            }
        }
    }

    private fun setUserData() {
        val user: User = UserPrefs(requireContext()).getUser()!!
        binding.tvName.text = "${user.firstName} ${user.lastName} ${getString(R.string.emoji_hands)}"
        binding.userImage.loadUserImage(user)
        setGreetings()
    }

    private fun setGreetings() {
        when (Calendar.getInstance().get(Calendar.HOUR_OF_DAY)) {
            in 0.rangeTo(11) -> binding.tvGreetings.text = "Good Morning,"
            in 12.rangeTo(17) -> binding.tvGreetings.text = "Good Afternoon,"
            in 18.rangeTo(23) -> binding.tvGreetings.text = "Good Evening,"
        }
    }

    @SuppressLint("MissingPermission")
    private fun requestPermissionsX() {
        val permissions: List<String> = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            listOf(Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.POST_NOTIFICATIONS)
        } else {
            listOf(Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION)
        }

        PermissionX.init(this)
            .permissions(permissions)
            .onExplainRequestReason { scope, deniedList ->
                scope.showRequestReasonDialog(deniedList, "Go Wild needs permissions to work properly", "OK", "Cancel")
            }.onForwardToSettings { scope, deniedList ->
                scope.showForwardToSettingsDialog(deniedList, "You need to allow necessary permissions in Settings manually", "OK", "Cancel")
            }.request { allGranted, grantedList, deniedList ->
                if (grantedList.contains(Manifest.permission.ACCESS_COARSE_LOCATION) && grantedList.contains(Manifest.permission.ACCESS_FINE_LOCATION)) {
                    turnGPSOn()
                }
            }
    }

    private fun turnGPSOn() {
        val mLocationSettingsRequest: LocationSettingsRequest

        val mSettingsClient: SettingsClient = LocationServices.getSettingsClient(requireActivity())

        val locationManager: LocationManager = requireActivity().getSystemService(Context.LOCATION_SERVICE) as LocationManager
        val locationRequest: LocationRequest = LocationRequest.Builder(1000).build()

        val builder = LocationSettingsRequest.Builder().addLocationRequest(locationRequest)
        mLocationSettingsRequest = builder.build()

        builder.setAlwaysShow(true)

        if (locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            requestCurrentLocation()
        } else {
            mSettingsClient.checkLocationSettings(mLocationSettingsRequest).addOnSuccessListener(requireActivity()) {
                toast("Location Setting ON")
                requestCurrentLocation()
            }.addOnFailureListener(requireActivity()) { e ->
                when ((e as ApiException).statusCode) {
                    LocationSettingsStatusCodes.RESOLUTION_REQUIRED -> {
                        try {
                            settingsLauncher.launch(IntentSenderRequest.Builder((e as ResolvableApiException).resolution).build())
                        } catch (cce: ClassCastException) {
                            val status: com.google.android.gms.common.api.Status = e.status

                            val resolvable = ResolvableApiException(status)
                            settingsLauncher.launch(IntentSenderRequest.Builder(resolvable.resolution).build())
                            toast("Location Failure ${cce.message}", Toast.LENGTH_LONG)
                        } catch (sie: IntentSender.SendIntentException) {
                            toast("Unable to turn on settings.")
                        }
                    }

                    LocationSettingsStatusCodes.SETTINGS_CHANGE_UNAVAILABLE -> {
                        val errorMessage = "Location settings are inadequate, and cannot be fixed here. Fix in Settings."
                        toast(errorMessage)
                    }
                }
            }
        }
    }

    @SuppressLint("MissingPermission")
    private fun requestCurrentLocation() {
        val currentLocationTask: Task<Location> = fusedLocationClient.getCurrentLocation(
            Priority.PRIORITY_HIGH_ACCURACY, cancellationTokenSource.token
        )
        currentLocationTask.addOnCompleteListener { task: Task<Location> ->
            if (task.isSuccessful && task.result != null) {
                val result: Location = task.result
                Timber.tag("LOCATION_UPDATED").wtf("${result.latitude} ${result.longitude}")
                if (::googleMap.isInitialized) {
                    googleMap.isMyLocationEnabled = true
                }
                userLat = result.latitude
                userLng = result.longitude
            } else {
                val exception = task.exception
            }
        }
    }

    var settingsLauncher = registerForActivityResult(ActivityResultContracts.StartIntentSenderForResult()) { result ->
        if (result.resultCode == RESULT_OK) {
            isGPS = true
            requestCurrentLocation()
        } else {
            isGPS = false
            toast("Please turn on location services for accurate results")
        }
    }

    override fun onResume() {
        super.onResume()
        hideKeyboard()
        updateUserData()
        updateRoutesData()
    }

    private fun updateRoutesData() {

    }

    private fun updateUserData() {
        Timber.tag("IMAGE_ISSUE").wtf("isProfileDataUpdated = $isProfileDataUpdated")
        if (isProfileDataUpdated) {
            isProfileDataUpdated = false
            setUserData()
            updateCreateFeedData()
            updateUserImagesInFeed()
        }
    }

    private fun updateCreateFeedData() {
        if (createFeedPosition != -1) {
            (homeDataList[createFeedPosition] as HomeFeedCreatePostModel).user = userPrefs.getUser()!!
            homeAdapter.notifyItemChanged(createFeedPosition, HomeAdapter.HomePayLoads.PAYLOAD_FEED_CREATE_USER_IMAGE_UPDATED)
        } else {
            homeFeedCreatePostModel.user = userPrefs.getUser()!!
        }
    }

    private fun updateUserImagesInFeed() {
        if (feedsPosition != -1) {
            homeDataList.forEachIndexed { index, data ->
                if (data is FeedsDataModel) {
                    val feedsDataModel: FeedsDataModel = data
                    if (feedsDataModel.user!!.id == userPrefs.getUser()!!.id) {
                        data.user = userPrefs.getUser()!!
                        homeAdapter.notifyItemChanged(index, HomeAdapter.HomePayLoads.PAYLOAD_FEED_UPDATE_USER_IMAGE)
                    }
                }
            }
        }
    }

    // FIXME: remove or replace this
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        // Mandatory for direct subclasses of android.app.Activity,
        // but not for subclasses of androidx.fragment.app.Fragment, androidx.activity.ComponentActivity, androidx.appcompat.app.AppCompatActivity
        storageHelper.storage.onActivityResult(requestCode, resultCode, data)
        Timber.tag("SELECTED_PDF").wtf("storageHelper ${data!!.data}")
    }


}