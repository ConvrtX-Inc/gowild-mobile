package com.android.gowild.interfaces

import com.android.gowild.data.model.friendRequestReceived.RecievedModel

interface FriendRequestReceivedCallback {
    fun onAdd(recieved: RecievedModel, position: Int)
    fun onDelete(recieved: RecievedModel, position: Int)
}