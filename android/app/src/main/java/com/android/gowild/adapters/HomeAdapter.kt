package com.android.gowild.adapters

import android.net.Uri
import android.view.LayoutInflater
import android.view.MotionEvent
import android.view.ViewGroup
import androidx.annotation.DrawableRes
import androidx.databinding.DataBindingUtil
import androidx.documentfile.provider.DocumentFile
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.android.gowild.BR
import com.android.gowild.BuildConfig
import com.android.gowild.R
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_FEED_ACTIVE_TAB
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_FEED_CREATE_ATTACHMENT_UPDATED
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_FEED_CREATE_IMAGE_UPDATED
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_FEED_CREATE_USER_IMAGE_UPDATED
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_FEED_UPDATE_COMMENTS
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_FEED_UPDATE_LIKES
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_FEED_UPDATE_USER_IMAGE
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_FEED_UPDATE_VIEWS
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_HEADER_ACTIVE
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_HEADER_COUNT
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_MAP_ROUTE_LEADERBOARD_UPDATED
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_MAP_ROUTE_SELECTED
import com.android.gowild.adapters.HomeAdapter.HomePayLoads.PAYLOAD_MAP_TYPE_UPDATED
import com.android.gowild.adapters.HomeAdapter.ViewTypes.TYPE_ERROR
import com.android.gowild.adapters.HomeAdapter.ViewTypes.TYPE_FEED_CREATE_POSTS
import com.android.gowild.adapters.HomeAdapter.ViewTypes.TYPE_FEED_ITEM
import com.android.gowild.adapters.HomeAdapter.ViewTypes.TYPE_FEED_TABS
import com.android.gowild.adapters.HomeAdapter.ViewTypes.TYPE_HEADER
import com.android.gowild.adapters.HomeAdapter.ViewTypes.TYPE_LOADING
import com.android.gowild.adapters.HomeAdapter.ViewTypes.TYPE_MAP
import com.android.gowild.adapters.HomeAdapter.ViewTypes.TYPE_MESSAGE_INBOX
import com.android.gowild.adapters.HomeAdapter.ViewTypes.TYPE_NEARBY_ADVENTURES
import com.android.gowild.adapters.HomeAdapter.ViewTypes.TYPE_SUGGESTED_FRIENDS
import com.android.gowild.data.model.feeds.FeedsDataModel
import com.android.gowild.data.model.friends.FriendsDataModel
import com.android.gowild.data.model.friends.MyFriendsDataModel
import com.android.gowild.data.model.friends.MyFriendsUserModel
import com.android.gowild.data.model.homeModels.HomeErrorModel
import com.android.gowild.data.model.homeModels.HomeFeedCreatePostModel
import com.android.gowild.data.model.homeModels.HomeFeedTabsModel
import com.android.gowild.data.model.homeModels.HomeHeaderModel
import com.android.gowild.data.model.homeModels.HomeLoadingModel
import com.android.gowild.data.model.homeModels.HomeMapModel
import com.android.gowild.data.model.homeModels.HomeNearbyAdventureListModel
import com.android.gowild.data.model.myTrail.HistoricalEvents
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.data.model.user.User
import com.android.gowild.databinding.ListItemFeedBinding
import com.android.gowild.databinding.ListItemFeedCreatePostBinding
import com.android.gowild.databinding.ListItemFeedTabsBinding
import com.android.gowild.databinding.ListItemFriendRequestBinding
import com.android.gowild.databinding.ListItemHeaderHomeBinding
import com.android.gowild.databinding.ListItemHomeLoaderBinding
import com.android.gowild.databinding.ListItemMapboxBinding
import com.android.gowild.databinding.ListItemMessagesInboxBinding
import com.android.gowild.databinding.ListItemNearbyAdventuresHomeBinding
import com.android.gowild.interfaces.FriendRequestCallback
import com.android.gowild.interfaces.HomeCallback
import com.android.gowild.interfaces.RoutesCallback
import com.android.gowild.ui.home.NearByAdventuresAdapter
import com.android.gowild.ui.map.TryRouteActivityNew
import com.android.gowild.utils.OverLapItemDecoration
import com.android.gowild.utils.constant.MAP_TYPE
import com.android.gowild.utils.extension.dp
import com.android.gowild.utils.extension.getAsColor
import com.android.gowild.utils.extension.getAsDrawable
import com.android.gowild.utils.extension.gone
import com.android.gowild.utils.extension.loadImage
import com.android.gowild.utils.extension.loadUserImage
import com.android.gowild.utils.extension.setRecyclerViewAdapter
import com.android.gowild.utils.extension.visible
import com.android.gowild.utils.getRelativeTimeString
import com.android.gowild.utils.helper.BitmapHelpers
import com.mapbox.core.constants.Constants
import com.mapbox.geojson.LineString
import com.mapbox.geojson.Point
import com.mapbox.geojson.utils.PolylineUtils
import com.mapbox.maps.CameraOptions
import com.mapbox.maps.EdgeInsets
import com.mapbox.maps.extension.style.layers.generated.lineLayer
import com.mapbox.maps.extension.style.layers.properties.generated.LineCap
import com.mapbox.maps.extension.style.layers.properties.generated.LineJoin
import com.mapbox.maps.extension.style.sources.generated.geoJsonSource
import com.mapbox.maps.extension.style.style
import com.mapbox.maps.plugin.animation.easeTo
import com.mapbox.maps.plugin.annotation.annotations
import com.mapbox.maps.plugin.annotation.generated.PointAnnotationOptions
import com.mapbox.maps.plugin.annotation.generated.createPointAnnotationManager
import com.mapbox.maps.plugin.gestures.addOnMapClickListener
import timber.log.Timber


class HomeAdapter(private var data: ArrayList<Any>, var homeCallback: HomeCallback, var userID: String) :
    RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    private enum class ViewTypes(val value: Int) {
        TYPE_HEADER(1),
        TYPE_MAP(2),
        TYPE_NEARBY_ADVENTURES(3),
        TYPE_FEED_TABS(4),
        TYPE_FEED_CREATE_POSTS(5),
        TYPE_FEED_ITEM(6),
        TYPE_LOADING(7),
        TYPE_ERROR(8),
        TYPE_SUGGESTED_FRIENDS(9),
        TYPE_MESSAGE_INBOX(10);

        companion object {
            fun get(value: Int): ViewTypes = ViewTypes.values().find { it.value == value }!!
        }
    }

    enum class HomePayLoads {
        PAYLOAD_HEADER_ACTIVE,
        PAYLOAD_HEADER_COUNT,
        PAYLOAD_FEED_ACTIVE_TAB,
        PAYLOAD_FEED_CREATE_IMAGE_UPDATED,
        PAYLOAD_FEED_CREATE_ATTACHMENT_UPDATED,
        PAYLOAD_FEED_CREATE_USER_IMAGE_UPDATED,
        PAYLOAD_MAP_TYPE_UPDATED,
        PAYLOAD_MAP_ROUTE_SELECTED,
        PAYLOAD_SET_NEW_ROUTES,
        PAYLOAD_MAP_ROUTE_LEADERBOARD_UPDATED,
        PAYLOAD_FEED_UPDATE_LIKES,
        PAYLOAD_FEED_UPDATE_VIEWS,
        PAYLOAD_FEED_UPDATE_COMMENTS,
        PAYLOAD_FEED_UPDATE_USER_IMAGE,
    }

    enum class HomeFeedSelectedTab {
        MY_FEED, MY_FRIENDS_MESSAGES
    }

    override fun getItemViewType(position: Int): Int {
        return when (data[position]) {
            is HomeHeaderModel -> {
                TYPE_HEADER.value
            }

            is HomeMapModel -> {
                TYPE_MAP.value
            }

            is HomeNearbyAdventureListModel -> {
                TYPE_NEARBY_ADVENTURES.value
            }

            is HomeFeedTabsModel -> {
                TYPE_FEED_TABS.value
            }

            is HomeFeedCreatePostModel -> {
                TYPE_FEED_CREATE_POSTS.value
            }

            is FeedsDataModel -> {
                TYPE_FEED_ITEM.value
            }

            is HomeLoadingModel -> {
                TYPE_LOADING.value
            }

            is HomeErrorModel -> {
                TYPE_ERROR.value
            }

            is FriendsDataModel -> {
                TYPE_SUGGESTED_FRIENDS.value
            }

            is MyFriendsDataModel -> {
                TYPE_MESSAGE_INBOX.value
            }

            else -> {
                TYPE_HEADER.value
            }
        }
    }

    override fun getItemCount(): Int {
        return data.size
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        val layoutInflater = LayoutInflater.from(parent.context)
        return when (ViewTypes.get(viewType)) {
            TYPE_HEADER -> {
                HeaderViewHolder(
                    ListItemHeaderHomeBinding.inflate(layoutInflater, parent, false)
                )
            }

            TYPE_MAP -> {
                MapBoxViewHolder(
                    ListItemMapboxBinding.inflate(layoutInflater, parent, false)
                )
//                MapViewHolder(
//                    ListItemMapContainerHomeBinding.inflate(layoutInflater, parent, false)
//                )
            }

            TYPE_NEARBY_ADVENTURES -> {
                NearbyAdventuresViewHolder(
                    ListItemNearbyAdventuresHomeBinding.inflate(layoutInflater, parent, false)
                )
            }

            TYPE_FEED_TABS -> {
                FeedTabsViewHolder(
                    ListItemFeedTabsBinding.inflate(layoutInflater, parent, false)
                )
            }

            TYPE_FEED_CREATE_POSTS -> {
                FeedCreatePostViewHolder(
                    ListItemFeedCreatePostBinding.inflate(layoutInflater, parent, false)
                )
            }

            TYPE_FEED_ITEM -> {
                FeedItemViewHolder(
                    ListItemFeedBinding.inflate(layoutInflater, parent, false)
                )
            }

            TYPE_LOADING -> {
                LoadingViewHolder(
                    ListItemHomeLoaderBinding.inflate(layoutInflater, parent, false)
                )
            }

            TYPE_ERROR -> {
                ErrorViewHolder(
                    ListItemHomeLoaderBinding.inflate(layoutInflater, parent, false)
                )
            }

            TYPE_SUGGESTED_FRIENDS -> {
                SuggestedFriendsViewHolder(
                    DataBindingUtil.inflate(
                        LayoutInflater.from(parent.context), R.layout.list_item_friend_request, parent, false
                    )
                )
            }

            TYPE_MESSAGE_INBOX -> {
                MessagesInboxViewHolder(
                    ListItemMessagesInboxBinding.inflate(layoutInflater, parent, false)
                )
            }
        }
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        val startTime = System.currentTimeMillis()
        when (ViewTypes.get(getItemViewType(position))) {
            TYPE_HEADER -> {
                (holder as HeaderViewHolder).bind(data[position] as HomeHeaderModel, position)
            }

            TYPE_MAP -> {
                (holder as MapBoxViewHolder).bind(data[position] as HomeMapModel, position)
            }

            TYPE_NEARBY_ADVENTURES -> {
                (holder as NearbyAdventuresViewHolder).bind(data[position] as HomeNearbyAdventureListModel, position)
            }

            TYPE_FEED_TABS -> {
                (holder as FeedTabsViewHolder).bind(data[position] as HomeFeedTabsModel, position)
            }

            TYPE_FEED_CREATE_POSTS -> {
                (holder as FeedCreatePostViewHolder).bind(data[position] as HomeFeedCreatePostModel, position)
            }

            TYPE_FEED_ITEM -> {
                Timber.tag("HomeAdapter").wtf("FeedImage : $position : ${BuildConfig.BASE_URL}${(data[position] as FeedsDataModel).picture}")
                (holder as FeedItemViewHolder).bind(data[position] as FeedsDataModel, position)
            }

            TYPE_SUGGESTED_FRIENDS -> {
                (holder as SuggestedFriendsViewHolder).bind(data[position] as FriendsDataModel, position)
            }

            TYPE_MESSAGE_INBOX -> {
                (holder as MessagesInboxViewHolder).bind(data[position] as MyFriendsDataModel, position)
            }

            TYPE_LOADING -> {

            }

            TYPE_ERROR -> {

            }
        }
        Timber.tag("HomeAdapter")
            .wtf("BINDTIME pos=$position view=${ViewTypes.get(getItemViewType(position))} time=${System.currentTimeMillis() - startTime}")
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int, payloads: MutableList<Any>) {
        Timber.tag("HomeAdapter").wtf("onBindViewHolder pos=$position")
        if (payloads.isNotEmpty()) {
            Timber.tag("HomeAdapter").wtf("onBindViewHolder payloads=${payloads.size}")
            val payload = payloads[0]
            Timber.tag("HomeAdapter").wtf("onBindViewHolder payload=$payload")
            when (ViewTypes.get(getItemViewType(position))) {
                TYPE_HEADER -> {
                    if (payload == PAYLOAD_HEADER_ACTIVE) {
                        (holder as HeaderViewHolder).bindHeaderActive((data[position] as HomeHeaderModel).isActive)
                    } else if (payload == PAYLOAD_HEADER_COUNT) {
                        (holder as HeaderViewHolder).bindHeaderCount((data[position] as HomeHeaderModel).count)
                    }
                }

                TYPE_FEED_TABS -> {
                    if (payload == PAYLOAD_FEED_ACTIVE_TAB) {
                        (holder as FeedTabsViewHolder).bindTabs((data[position] as HomeFeedTabsModel).selectedTab)
                    }
                }

                TYPE_FEED_CREATE_POSTS -> {
                    when (payload) {
                        PAYLOAD_FEED_CREATE_IMAGE_UPDATED -> {
                            (holder as FeedCreatePostViewHolder).bindSelectedImage((data[position] as HomeFeedCreatePostModel).selectedImageUri)
                        }

                        PAYLOAD_FEED_CREATE_ATTACHMENT_UPDATED -> {
                            (holder as FeedCreatePostViewHolder).bindSelectedPDF((data[position] as HomeFeedCreatePostModel).selectedAttachmentUri)
                        }

                        PAYLOAD_FEED_CREATE_USER_IMAGE_UPDATED -> {
                            (holder as FeedCreatePostViewHolder).bindUserImage((data[position] as HomeFeedCreatePostModel).user)
                        }
                    }
                }

                TYPE_MAP -> {
                    when (payload) {
                        PAYLOAD_MAP_TYPE_UPDATED -> {
                            (holder as MapBoxViewHolder).bindMapTypeWithRoute((data[position] as HomeMapModel))
                        }

                        PAYLOAD_MAP_ROUTE_LEADERBOARD_UPDATED -> {
//                            (holder as MapViewHolder).updateUserLeaderBoard(payloads[1] as Int)
                        }

                        PAYLOAD_MAP_ROUTE_SELECTED -> {
                            (holder as MapBoxViewHolder).selectRoute((data[position] as HomeMapModel).selectedItemIndex)
                        }

                        HomePayLoads.PAYLOAD_SET_NEW_ROUTES -> {
                            (holder as MapBoxViewHolder).bind((data[position] as HomeMapModel), position)
                        }
                    }
                }

                TYPE_FEED_ITEM -> {
                    when (payload) {
                        PAYLOAD_FEED_UPDATE_LIKES -> {
                            (holder as FeedItemViewHolder).bindLikes((data[position] as FeedsDataModel).likes)
                            holder.bindLikesImages((data[position] as FeedsDataModel).likes_images)
                        }

                        PAYLOAD_FEED_UPDATE_VIEWS -> {
                            (holder as FeedItemViewHolder).bindViews((data[position] as FeedsDataModel).views)
                        }

                        PAYLOAD_FEED_UPDATE_COMMENTS -> {
                            (holder as FeedItemViewHolder).bindComments((data[position] as FeedsDataModel).comments)
                        }

                        PAYLOAD_FEED_UPDATE_USER_IMAGE -> {
                            (holder as FeedItemViewHolder).bindUserPicture((data[position] as FeedsDataModel).user)
                        }
                    }
                }

                else -> {

                }
            }
        } else {
            super.onBindViewHolder(holder, position, payloads)
        }
    }

    inner class HeaderViewHolder(var binding: ListItemHeaderHomeBinding) : RecyclerView.ViewHolder(binding.root) {

        init {
            itemView.setOnClickListener {
                homeCallback.onClickHeader(data[bindingAdapterPosition] as HomeHeaderModel, bindingAdapterPosition)
            }
        }

        fun bind(data: HomeHeaderModel, position: Int) {
            binding.tvTitle.text = data.title
            bindHeaderActive(data.isActive)
            bindHeaderCount(data.count)
        }

        fun bindHeaderActive(isActive: Boolean) {
            if (isActive) {
                binding.ivArrow.setImageResource(R.drawable.ic_chevron_down)
            } else {
                binding.ivArrow.setImageResource(R.drawable.ic_chevron_right)
            }
        }

        fun bindHeaderCount(count: Int) {
            if (count == 0) {
                binding.tvSize.gone()
            } else {
                binding.tvSize.visible()
                binding.tvSize.text = count.toString()
            }
        }
    }

    inner class MapBoxViewHolder(var binding: ListItemMapboxBinding) : RecyclerView.ViewHolder(binding.root) {

        private val routesCallback = object : RoutesCallback {
            override fun onRouteSelected(data: RouteDataModel, position: Int) {
                Timber.tag("ROUTE_POSITION").wtf("HomeAdapter $position")
                homeCallback.onSelectRoute(position)
            }

            override fun onTryRoute(routeDataModel: RouteDataModel, position: Int) {
                homeCallback.onTryRoute(routeDataModel, position)
            }

            override fun onRouteDetail(routeDataModel: RouteDataModel) {
                homeCallback.onRouteDetail(routeDataModel)
            }

            override fun onSaveUnSaveRoute(routeDataModel: RouteDataModel, position: Int) {
                homeCallback.onSaveUnSaveRoute(routeDataModel, position)
            }
        }

        var routesList: ArrayList<RouteDataModel> = ArrayList()
        var routesAdapter: RoutesAdapter = RoutesAdapter(routesList, routesCallback, userID)
        private val pointAnnotationManager = binding.mapView.annotations.createPointAnnotationManager()

        init {
            val layoutManager = LinearLayoutManager(itemView.context)
            layoutManager.initialPrefetchItemCount = 3
            binding.rvRoutes.layoutManager = layoutManager
            binding.rvRoutes.adapter = routesAdapter
            bindMapType()


            binding.mapView.getMapboxMap().addOnMapClickListener {
                if (routesList.isNotEmpty())
                    homeCallback.onMapClick(routesList.first { it.isSelected })
                true
            }

            binding.mapView.getMapboxMap().addOnMapLoadedListener {
                routesList.firstOrNull() { it.isSelected }?.let { it1 -> animateToRoute(it1) }
            }

            binding.ivUp.setOnClickListener {
                homeCallback.onPreviousRoutes()
            }

            binding.ivDown.setOnClickListener {
                homeCallback.onNextRoutes()
            }
            binding.transparentImage.setOnTouchListener { v, event ->
                when (event.action) {
                    MotionEvent.ACTION_DOWN -> {
                        homeCallback.parentShouldHandleTouch(true)
                        false
                    }

                    MotionEvent.ACTION_UP -> {
                        homeCallback.parentShouldHandleTouch(false)
                        true
                    }

                    MotionEvent.ACTION_MOVE -> {
                        homeCallback.parentShouldHandleTouch(true)
                        false
                    }

                    else -> true
                }
            }

            binding.ivZoomPlus.setOnClickListener {
                updateZoom(++(data[bindingAdapterPosition] as HomeMapModel).zoom)
            }

            binding.ivZoomMinus.setOnClickListener {
                updateZoom(--(data[bindingAdapterPosition] as HomeMapModel).zoom)
            }

            binding.ivMapOverlay.setOnClickListener {
                homeCallback.onSelectMapOverlay((data[bindingAdapterPosition] as HomeMapModel).mapType)
            }
        }

        private fun updateZoom(zoom: Float) {
            binding.mapView.getMapboxMap().setCamera(
                CameraOptions.Builder()
                    .zoom(zoom.toDouble())
                    .build()
            )
        }

        fun bindMapType(mapType: String = MAP_TYPE) {
            binding.mapView.getMapboxMap().loadStyleUri(mapType)
        }

        fun bindMapTypeWithRoute(homeMapModel: HomeMapModel) {
            val lineStringJson =
                LineString.fromPolyline(homeMapModel.routes[homeMapModel.selectedItemIndex].polyline!!, Constants.PRECISION_6).toJson()
            val data = geoJsonSource(TryRouteActivityNew.GEOJSON_SOURCE_ID) {
                this.data(lineStringJson, TryRouteActivityNew.GEOJSON_SOURCE_ID)
            }

            binding.mapView.getMapboxMap().loadStyle(
                style(styleUri = homeMapModel.mapType) {
                    +data
                    +lineLayer("linelayer", TryRouteActivityNew.GEOJSON_SOURCE_ID) {
                        lineCap(LineCap.ROUND)
                        lineJoin(LineJoin.ROUND)
                        lineOpacity(1.0)
                        lineWidth(5.0)
                        lineColor("#E4572E")
                    }
                }
            )
        }

        private fun animateToRoute(routeData: RouteDataModel) {
            val cameraPosition = binding.mapView.getMapboxMap().cameraForCoordinates(
                PolylineUtils.decode(routeData.polyline!!, Constants.PRECISION_6),
                EdgeInsets(
                    150.0,
                    150.0,
                    150.0,
                    150.0,
                )
            )
            binding.mapView.getMapboxMap().easeTo(cameraPosition)
        }

        fun bind(data: HomeMapModel, position: Int) {
            bindRoutes(data.routes)
        }

        fun selectRoute(position: Int) {
            routesList.forEachIndexed { index, routeDataModel -> routeDataModel.isSelected = index == position }
            routesAdapter.notifyDataSetChanged()
        }

        private fun bindRoutes(data: ArrayList<RouteDataModel>) {
            routesList.clear()
            routesList.addAll(data)
            routesAdapter.notifyDataSetChanged()
            if (routesList.isNotEmpty())
                bindRoutesOnMap(routesList)
        }

        private fun bindRoutesOnMap(routesData: ArrayList<RouteDataModel>) {
            val route = routesData.firstOrNull() { it.isSelected }
            if (route != null) {
                removeMarkers()
                addPolyLine(route.polyline!!)
                setHistoricalMarkers(route.historicalEvents)
                setMarkers(
                    PolylineUtils.decode(route.polyline, Constants.PRECISION_6).first(),
                    PolylineUtils.decode(route.polyline, Constants.PRECISION_6).last()
                )
                animateToRoute(route)
            }
        }

        private fun setHistoricalMarkers(historicalEvents: ArrayList<HistoricalEvents>?) {
            if (!historicalEvents.isNullOrEmpty()) {
                historicalEvents.forEach {
                    addMarker(Point.fromLngLat(it.historical_event.longitude, it.historical_event.latitude), R.drawable.ic_historical_marker)
                }
            }
        }

        private fun setMarkers(startPoint: Point, endPoint: Point) {
            addMarker(startPoint, R.drawable.ic_end_marker_new)
            addMarker(endPoint, R.drawable.ic_start_marker_new)
        }

        private fun removeMarkers() {
            pointAnnotationManager.deleteAll()
        }

        private fun addMarker(point: Point, @DrawableRes resourceId: Int) {
            BitmapHelpers().bitmapFromDrawableRes(
                itemView.context,
                resourceId
            )?.let {
                val pointAnnotationOptions: PointAnnotationOptions = PointAnnotationOptions()
                    .withPoint(point)
                    .withIconImage(it)
                pointAnnotationManager.create(pointAnnotationOptions)
            }
        }

        private fun addPolyLine(points: MutableList<Point>) {
            val polylineString = PolylineUtils.encode(points, Constants.PRECISION_6)
            addPolyLine(polylineString)
        }

        private fun addPolyLine(polylineString: String) {
            val lineStringJson = LineString.fromPolyline(polylineString, Constants.PRECISION_6).toJson()
            val data = geoJsonSource(TryRouteActivityNew.GEOJSON_SOURCE_ID) {
                this.data(lineStringJson, TryRouteActivityNew.GEOJSON_SOURCE_ID)
            }

            binding.mapView.getMapboxMap().loadStyle(
                style(styleUri = MAP_TYPE) {
                    +data
                    +lineLayer("linelayer", TryRouteActivityNew.GEOJSON_SOURCE_ID) {
                        lineCap(LineCap.ROUND)
                        lineJoin(LineJoin.ROUND)
                        lineOpacity(1.0)
                        lineWidth(5.0)
                        lineColor("#E4572E")
                    }
                }
            )
        }
    }

    inner class NearbyAdventuresViewHolder(var binding: ListItemNearbyAdventuresHomeBinding) : RecyclerView.ViewHolder(binding.root) {

        var nearbyData: ArrayList<TreasureWildResponse.TreasureWildListingData> = ArrayList()
        var nearbyAdventuresAdapter: NearByAdventuresAdapter = NearByAdventuresAdapter(nearbyData)

        init {
            val layoutManager = LinearLayoutManager(itemView.context, LinearLayoutManager.HORIZONTAL, false)
            layoutManager.initialPrefetchItemCount = 5
            binding.rvNearbyAdventures.layoutManager = layoutManager
            binding.rvNearbyAdventures.adapter = nearbyAdventuresAdapter

            binding.rvNearbyAdventures.addOnScrollListener(object : RecyclerView.OnScrollListener() {
                override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                    super.onScrollStateChanged(recyclerView, newState)
                    homeCallback.onNearbyScroll(layoutManager.onSaveInstanceState())
                }
            })
        }

        fun bind(data: HomeNearbyAdventureListModel, position: Int) {
            nearbyData.clear()
            nearbyData.addAll(data.nearbyAdventures)
            nearbyAdventuresAdapter.notifyDataSetChanged()
            binding.rvNearbyAdventures.layoutManager?.onRestoreInstanceState(data.scrollPosition)
        }
    }

    inner class FeedTabsViewHolder(var binding: ListItemFeedTabsBinding) : RecyclerView.ViewHolder(binding.root) {

        init {
            binding.btnMyFeed.setOnClickListener {
                if ((data[bindingAdapterPosition] as HomeFeedTabsModel).selectedTab != HomeFeedSelectedTab.MY_FEED) homeCallback.onFeedTabSelected(
                    HomeFeedSelectedTab.MY_FEED, bindingAdapterPosition
                )
            }
            binding.btnMyFriend.setOnClickListener {
                if ((data[bindingAdapterPosition] as HomeFeedTabsModel).selectedTab != HomeFeedSelectedTab.MY_FRIENDS_MESSAGES) homeCallback.onFeedTabSelected(
                    HomeFeedSelectedTab.MY_FRIENDS_MESSAGES, bindingAdapterPosition
                )
            }
        }

        fun bind(data: HomeFeedTabsModel, position: Int) {
            bindTabs(data.selectedTab)
        }

        fun bindTabs(selectedTab: HomeFeedSelectedTab) {
            with(binding) {
                when (selectedTab) {
                    HomeFeedSelectedTab.MY_FEED -> {
                        btnMyFeed.background = btnMyFeed.context.getAsDrawable(R.drawable.tab_left_active_bg)
                        btnMyFeed.setTextColor(btnMyFeed.context.getAsColor(R.color.white))

                        btnMyFriend.background = btnMyFriend.context.getAsDrawable(R.drawable.tab_right_off_bg)
                        btnMyFriend.setTextColor(btnMyFriend.context.getAsColor(R.color.gold_orange))
                    }

                    HomeFeedSelectedTab.MY_FRIENDS_MESSAGES -> {
                        btnMyFeed.background = btnMyFeed.context.getAsDrawable(R.drawable.tab_left_off_bg)
                        btnMyFeed.setTextColor(btnMyFeed.context.getAsColor(R.color.gold_orange))

                        btnMyFriend.background = btnMyFriend.context.getAsDrawable(R.drawable.tab_right_active_bg)
                        btnMyFriend.setTextColor(btnMyFriend.context.getAsColor(R.color.white))
                    }
                }
            }
        }
    }

    // FIXME: names are becoming confusing, either use post or feed, not both
    inner class FeedCreatePostViewHolder(var binding: ListItemFeedCreatePostBinding) : RecyclerView.ViewHolder(binding.root) {

        init {
            binding.tvSeeAll.setOnClickListener {
                homeCallback.onSeeAllFriends()
            }
            binding.btnPost.setOnClickListener {
                homeCallback.onPostFeed(binding.etDescription.text.toString(), bindingAdapterPosition)
                if (binding.etDescription.text.toString() != "") {
                    binding.etDescription.setText("")
                }
            }

            binding.ivAttachImg.setOnClickListener {
                Timber.tag("HOME_POSITION").wtf("bindingAdapterPosition?$bindingAdapterPosition")
                homeCallback.onSelectImage(bindingAdapterPosition)
            }

            binding.ivAttachLinks.setOnClickListener {
                homeCallback.onSelectAttachment(bindingAdapterPosition)
            }

            binding.ivRemoveImage.setOnClickListener {
                homeCallback.onRemoveImage(bindingAdapterPosition)
            }

            binding.ivRemovePdf.setOnClickListener {
                homeCallback.onRemovePDF(bindingAdapterPosition)
            }
        }

        fun bind(data: HomeFeedCreatePostModel, position: Int) {
            bindUserImage(data.user)
            bindSelectedImage(data.selectedImageUri)
            bindSelectedPDF(data.selectedAttachmentUri)
        }

        fun bindUserImage(user: User?) {
            if (user!!.picture != null && user.picture != "") {
                binding.ivProfile.loadUserImage(user)
            } else {
                binding.ivProfile.setImageDrawable(binding.ivProfile.context.getAsDrawable(R.drawable.user_placeholder))
            }
        }

        fun bindSelectedImage(uri: Uri?) {
            if (uri != null) {
                binding.cvImage.visible()
                binding.ivRemoveImage.visible()
                binding.ivImage.setImageURI(uri)
            } else {
                binding.cvImage.gone()
                binding.ivRemoveImage.gone()
                binding.ivImage.setImageDrawable(null)
            }
        }

        fun bindSelectedPDF(file: DocumentFile?) {
            if (file != null) {
                binding.cvPdf.visible()
                binding.ivRemovePdf.visible()
            } else {
                binding.cvPdf.gone()
                binding.ivRemovePdf.gone()
            }
        }
    }

    inner class FeedItemViewHolder(var binding: ListItemFeedBinding) : RecyclerView.ViewHolder(binding.root) {

        init {
            binding.imgComment.setOnClickListener {
                homeCallback.onClickComment((data[bindingAdapterPosition] as FeedsDataModel).id, bindingAdapterPosition)
            }
            binding.ivImage.setOnClickListener {
                homeCallback.onClickPostImage(BuildConfig.BASE_URL + (data[bindingAdapterPosition] as FeedsDataModel).picture)
            }
            binding.imgForward.setOnClickListener {
                homeCallback.onSharePost((data[bindingAdapterPosition] as FeedsDataModel).id, bindingAdapterPosition)
            }
            binding.imgLike.setOnClickListener {
                homeCallback.onLikePost((data[bindingAdapterPosition] as FeedsDataModel).id, bindingAdapterPosition)
            }
            binding.imgEye.setOnClickListener {
                homeCallback.onViewPost((data[bindingAdapterPosition] as FeedsDataModel).id, bindingAdapterPosition)
            }
            binding.tvAttachment.setOnClickListener {
                if ((data[bindingAdapterPosition] as FeedsDataModel).attachment != null && (data[bindingAdapterPosition] as FeedsDataModel).attachment!!.isNotEmpty())
                    homeCallback.onClickPDF(BuildConfig.BASE_URL + (data[bindingAdapterPosition] as FeedsDataModel).attachment!![0].attachment)
            }
        }

        fun bind(data: FeedsDataModel, position: Int) {
            data.user?.let {
                binding.tvUsername.text = "${data.user!!.firstName} ${data.user!!.lastName}"
            } ?: run {
                binding.tvUsername.text = ""
            }

            if (data.description != null)
                binding.tvDescription.text = data.description
            else
                binding.tvDescription.text = ""

            binding.tvTime.text = data.createdDate.getRelativeTimeString()

            bindFeedPicture(data)
            bindUserPicture(data.user)

            if (data.attachment != null && data.attachment.isNotEmpty()) {
                binding.tvAttachment.text = BuildConfig.BASE_URL + data.attachment[0].attachment
                binding.tvAttachment.visible()
            } else {
                binding.tvAttachment.gone()
            }

            bindLikes(data.likes)
            bindLikesImages(data.likes_images)
            bindViews(data.views)
            bindComments(data.comments)

            if (data.share != null && data.share > 0) {
                binding.tvForward.text = data.share.toString()
            } else {
                binding.tvForward.text = "0"
            }
        }

        fun bindUserPicture(user: User?) {
            if (user?.picture != null && user.picture != "") {
                binding.ivProfile.loadUserImage(user)
            } else {
                binding.ivProfile.setImageDrawable(binding.ivProfile.context.getAsDrawable(R.drawable.user_placeholder))
            }
        }

        fun bindFeedPicture(data: FeedsDataModel) {
            if (data.picture != null && data.picture != "") {
                binding.ivImage.loadImage(BuildConfig.BASE_URL + data.picture, R.drawable.image_placeholder)
            } else {
                binding.ivImage.setImageDrawable(null)
            }
        }

        fun bindLikes(likes: Int?) {
            if (likes != null && likes > 0) {
                binding.tvLikes.text = likes.toString()
            } else {
                binding.tvLikes.text = "0"
            }
        }

        fun bindLikesImages(likes_images: ArrayList<String>?) {
            if (likes_images != null && likes_images.isNotEmpty()) {
                val likesImagesList: ArrayList<String> = ArrayList()
                if (likes_images.size > 3) {
                    likesImagesList.addAll(likes_images.subList(0, 2))
                    bindLikesImagesText(likes_images)
                } else {
                    likesImagesList.addAll(likes_images)
                    binding.tvLikesPlus.gone()
                }
                binding.rvLikes.setRecyclerViewAdapter(R.layout.list_item_likes, likesImagesList, null, null)
                binding.rvLikes.addItemDecoration(OverLapItemDecoration((-10).dp))
                binding.rvLikes.visible()

            } else {
                binding.rvLikes.gone()
                binding.tvLikesPlus.gone()
            }
        }

        fun bindLikesImagesText(likes_images: ArrayList<String>) {
            binding.tvLikesPlus.visible()
            binding.tvLikesPlus.text = "+${likes_images.size - 3} Likes"
        }

        fun bindViews(likes: Int?) {
            if (likes != null && likes > 0) {
                binding.tvViews.text = likes.toString()
            } else {
                binding.tvViews.text = "0"
            }
        }

        fun bindComments(comments: Int?) {
            if (comments != null && comments!! > 0) {
                binding.tvComment.text = comments.toString()
            } else {
                binding.tvComment.text = "0"
            }
        }
    }

    inner class SuggestedFriendsViewHolder(var binding: ListItemFriendRequestBinding) : RecyclerView.ViewHolder(binding.root) {

        val listener: FriendRequestCallback

        init {
            listener = object : FriendRequestCallback {
                override fun onAdd(friendsDataModel: FriendsDataModel, position: Int) {
                    homeCallback.onAddSuggestFriend(friendsDataModel, position)
                }

                override fun onDelete(friendsDataModel: FriendsDataModel, position: Int) {
                    homeCallback.onDelSuggestFriend(friendsDataModel, position)
                }

            }
            itemView.setBackgroundColor(itemView.context.getAsColor(R.color.black))
        }

        fun bind(data: FriendsDataModel, position: Int) {
            with(this) {
                binding.setVariable(BR.item, data)
                binding.setVariable(BR.listener, listener)
                binding.setVariable(BR.position, position)
                binding.setVariable(BR.options, null)
            }
        }
    }

    inner class MessagesInboxViewHolder(var binding: ListItemMessagesInboxBinding) : RecyclerView.ViewHolder(binding.root) {

        init {
            binding.cvMessage.setOnClickListener {
                homeCallback.onClickMessage(data[bindingAdapterPosition] as MyFriendsDataModel, bindingAdapterPosition)
            }
        }

        fun bind(data: MyFriendsDataModel, position: Int) {
            val user: MyFriendsUserModel = data.to_user
            binding.tvUserName.text = "${user.firstName} ${user.lastName}"

            if (user.picture != null && user.picture != "") {
                binding.ivProfile.loadImage(BuildConfig.BASE_URL + user.picture)
            } else {
                binding.ivProfile.setImageDrawable(binding.ivProfile.context.getAsDrawable(R.drawable.user_placeholder))
            }
        }
    }

    inner class LoadingViewHolder(var binding: ListItemHomeLoaderBinding) : RecyclerView.ViewHolder(binding.root)

    inner class ErrorViewHolder(var binding: ListItemHomeLoaderBinding) : RecyclerView.ViewHolder(binding.root)
}