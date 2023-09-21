package com.android.gowild.interfaces

import android.os.Parcelable
import com.android.gowild.adapters.HomeAdapter
import com.android.gowild.data.model.friends.FriendsDataModel
import com.android.gowild.data.model.friends.MyFriendsDataModel
import com.android.gowild.data.model.homeModels.HomeHeaderModel
import com.android.gowild.data.model.routes.RouteDataModel
import com.google.android.gms.maps.GoogleMap

interface HomeCallback {
    fun onClickHeader(headerData: HomeHeaderModel, position: Int) {}
    fun onMapReady(googleMap: GoogleMap) {}
    fun onNearbyScroll(position: Parcelable?) {}
    fun onAddSuggestFriend(data: FriendsDataModel, position: Int) {}
    fun onDelSuggestFriend(data: FriendsDataModel, position: Int) {}
    fun onClickMessage(data: MyFriendsDataModel, position: Int) {}
    fun onFeedTabSelected(data: HomeAdapter.HomeFeedSelectedTab, position: Int) {}
    fun onSeeAllFriends() {}
    fun onPreviousRoutes() {}
    fun onNextRoutes() {}
    fun onPostFeed(description: String, position: Int) {}
    fun onSelectImage(position: Int) {}
    fun onRemoveImage(position: Int) {}
    fun onRemovePDF(position: Int) {}
    fun onSelectRoute(position: Int) {}
    fun onClickComment(postID: String, position: Int) {}
    fun onClickPostImage(imageURL: String) {}
    fun parentShouldHandleTouch(handleTouch: Boolean) {}

    fun onTryRoute(routeDataModel: RouteDataModel, position: Int) {}

    fun onRouteDetail(routeDataModel: RouteDataModel) {}

    fun onSaveUnSaveRoute(routeDataModel: RouteDataModel, position: Int) {}

    fun onSelectMapOverlay(mapType: String) {}

    fun onSharePost(postID: String, position: Int) {}

    fun onLikePost(postID: String, position: Int) {}

    fun onViewPost(postID: String, position: Int) {}
    fun onSelectAttachment(position: Int) {}
    fun onClickPDF(attachment: String) {}
    fun onMapClick(route: RouteDataModel) {}
}