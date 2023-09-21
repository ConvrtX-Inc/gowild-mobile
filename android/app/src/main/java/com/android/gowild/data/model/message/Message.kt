package com.android.gowild.data.model.message


class Message private constructor() {
    var type = 0
    var message: String? = null
    var username: String? = null
    var userId: String? = null
    var userImage: String? = null

    class Builder(private val mType: Int) {
        private var mUserId: String? = null
        private var mUsername: String? = null
        private var mMessage: String? = null
        private var mUserImage: String? = null

        fun userId(userId: String?): Builder {
            mUserId = userId
            return this
        }

        fun userImage(userImage: String?): Builder {
            mUserImage = userImage
            return this
        }

        fun username(username: String?): Builder {
            mUsername = username
            return this
        }

        fun message(message: String?): Builder {
            mMessage = message
            return this
        }

        fun build(): Message {
            val message = Message()
            message.type = mType
            message.username = mUsername
            message.userId = mUserId
            message.message = mMessage
            message.userImage = mUserImage
            return message
        }
    }

    companion object {
        const val TYPE_MESSAGE = 0
        const val TYPE_LOG = 1
        const val TYPE_ACTION = 2
    }
}
