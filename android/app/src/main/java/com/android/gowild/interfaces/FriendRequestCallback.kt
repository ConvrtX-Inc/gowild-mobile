package com.android.gowild.interfaces

import com.android.gowild.data.model.friends.FriendsDataModel


interface FriendRequestCallback {
    fun onAdd(friendsDataModel: FriendsDataModel, position: Int)
    fun onDelete(friendsDataModel: FriendsDataModel, position: Int)
}