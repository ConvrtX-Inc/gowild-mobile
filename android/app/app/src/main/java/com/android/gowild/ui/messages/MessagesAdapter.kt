package com.android.gowild.ui.messages

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.android.gowild.R
import com.android.gowild.data.model.message.MessageApiResponse
import com.android.gowild.utils.extension.loadUserImage
import com.android.gowild.utils.local.UserPrefs
import com.bumptech.glide.Glide
import com.bumptech.glide.signature.ObjectKey
import de.hdodenhof.circleimageview.CircleImageView

private const val VIEW_TYPE_MY_MESSAGE = 1
private const val VIEW_TYPE_OTHER_MESSAGE = 2

class MessagesAdapter(
    private val messages: ArrayList<MessageApiResponse.MessageDetail>,
    private val userPrefs: UserPrefs,
    private val otherUserName: String,
    private val otherUserPic: String
) : RecyclerView.Adapter<MessageViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MessageViewHolder {
        return if (viewType == VIEW_TYPE_MY_MESSAGE) {
            MyMessageViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.item_my_message, parent, false))
        } else {
            OtherMessageViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.item_other_message, parent, false))
        }
    }

    override fun getItemCount(): Int {
        return messages.size
    }

    override fun getItemViewType(position: Int): Int {
        val message = messages.get(position)

        return if (message.user_id == userPrefs.getUser()?.id) {
            VIEW_TYPE_MY_MESSAGE
        } else {
            VIEW_TYPE_OTHER_MESSAGE
        }
    }

    override fun onBindViewHolder(holder: MessageViewHolder, position: Int) {
        val message = messages.get(position)
        holder.bind(message)
    }

    inner class MyMessageViewHolder(view: View) : MessageViewHolder(view) {
        private var messageText: TextView = view.findViewById(R.id.txtMyMessage)
        private var userImage: CircleImageView = view.findViewById(R.id.imgMyProfile)
        private var userLabel: TextView = view.findViewById(R.id.labelMyMessage)

        override fun bind(message: MessageApiResponse.MessageDetail) {
            messageText.text = message.message
            userImage.loadUserImage(userPrefs.getUser()!!)
            userLabel.text = "You"
        }
    }

    inner class OtherMessageViewHolder(view: View) : MessageViewHolder(view) {
        private var messageText: TextView = view.findViewById(R.id.txtOtherMessage)
        private var userImage: CircleImageView = view.findViewById(R.id.imgOtherProfile)
        private var userLabel: TextView = view.findViewById(R.id.labelOtherMessage)

        override fun bind(message: MessageApiResponse.MessageDetail) {
            messageText.text = message.message
            Glide
                .with(itemView.context)
                .load("https://api.gowild.appscorridor.com" + otherUserPic)
                .signature(ObjectKey(System.currentTimeMillis().toString()))
                .placeholder(R.drawable.user_placeholder)
                .error(R.drawable.user_placeholder)
                .into(userImage)
            userLabel.text = otherUserName

        }
    }
}

open class MessageViewHolder(view: View) : RecyclerView.ViewHolder(view) {
    open fun bind(message: MessageApiResponse.MessageDetail) {}
}