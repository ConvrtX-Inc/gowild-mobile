package com.android.gowild.ui.map.treasurewild

import android.annotation.SuppressLint
import android.content.Context
import android.text.method.ScrollingMovementMethod
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.paging.PagingDataAdapter
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.android.gowild.BuildConfig
import com.android.gowild.R
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.databinding.TreasureWildCardDesignBinding
import com.android.gowild.utils.TIME_FORMAT_TIME_STAMP
import com.android.gowild.utils.changeDateFormat
import com.android.gowild.utils.extension.loadImage
import com.android.gowild.utils.extension.loadSmallImage
import java.text.SimpleDateFormat
import java.util.*
import javax.inject.Inject

class TreasureWildAdapter @Inject constructor() :
    PagingDataAdapter<TreasureWildResponse.TreasureWildListingData, TreasureWildAdapter.ViewHolder>(differCallback) {

    private lateinit var binding: TreasureWildCardDesignBinding
    private lateinit var context: Context

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        binding = TreasureWildCardDesignBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        context = parent.context
        return ViewHolder()
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(getItem(position)!!)
        holder.setIsRecyclable(false)
    }

    inner class ViewHolder : RecyclerView.ViewHolder(binding.root) {

        val sdf = SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH)
        val c = Calendar.getInstance()
        val currentTime = sdf.format(c.time)

        init {
            binding.registerBtn.setOnClickListener {
                onRegisterItemClickListener?.let {
                    it(getItem(bindingAdapterPosition)!!)
                }
            }

            binding.startBtn.setOnClickListener {
                onStartItemClickListener?.let {
                    it(getItem(bindingAdapterPosition)!!)
                }
            }
        }

        @SuppressLint("SetTextI18n")
        fun bind(item: TreasureWildResponse.TreasureWildListingData) {
            binding.apply {

                binding.ivImage.loadImage(BuildConfig.BASE_URL + item.picture, R.drawable.image_placeholder)
                if (item.treasureWildSponsors.isNotEmpty())
                    img.loadSmallImage(BuildConfig.BASE_URL + item.treasureWildSponsors[0].img, R.drawable.image_placeholder)

                tvUsername.text = item.title
                tvDescription.text = item.description
                registeredMembers.text =
                    (item.no_of_participants.toInt() - item.treasureHunts.size).toString() + "/" + item.no_of_participants + " left"

//                static let TreasureWildFeedDateFormat : String = "MM/dd/yyyy"
//                static let TreasureWildFeedTimeFormat : String = "HH:mm"
                eventTime.text = item.eventTime.changeDateFormat(TIME_FORMAT_TIME_STAMP, "HH:mm")
                date.text = item.eventDate.changeDateFormat(TIME_FORMAT_TIME_STAMP, "MM/dd/yyyy")
//                date.text = item.eventDate.split("T")[0].replace("-", "/")


                binding.tvDescription.movementMethod = ScrollingMovementMethod()

                if (item.treasureHunts.size == 0) {
                    recyclerview.visibility = View.GONE
                    totalViews.visibility = View.GONE
                } else {
                    recyclerview.visibility = View.VISIBLE
                    if (item.treasureHunts.size > 5) {
                        totalViews.visibility = View.VISIBLE
                        totalViews.setText("+" + (item.treasureHunts.size - 5).toString())
                    }
                }
                recyclerview.layoutManager = LinearLayoutManager(
                    context, LinearLayoutManager.HORIZONTAL,
                    false
                )
                val adapter = ImageListAdapter(item.treasureHunts, context)
                recyclerview.adapter = adapter


                if (sdf.parse(item.eventDate.split("T")[0])!! > sdf.parse(currentTime)) {

                    // current_user_hunt == null show register
                    // current_user_hunt.status == "pending" show waiting for approval
                    // current_user_hunt.status == "approved" show start button

                    notRegisteredBtn.visibility = View.GONE
                    if (item.winnerId != null && item.winnerId != "") {
                        registerBtn.visibility = View.GONE
                        waitingForApproval.visibility = View.VISIBLE
                        startBtn.visibility = View.GONE
                        waitingForApproval.text = "Completed"
                    } else if (item.current_user_hunt == null) {
                        registerBtn.visibility = View.VISIBLE
                        waitingForApproval.visibility = View.GONE
                        startBtn.visibility = View.GONE
                    } else if (item.current_user_hunt.status.equals("pending", true)) {
                        registerBtn.visibility = View.GONE
                        waitingForApproval.visibility = View.VISIBLE
                        startBtn.visibility = View.GONE
                    } else if (item.current_user_hunt.status.equals("approved", true) || item.current_user_hunt.status.equals("processing", true)) {
                        registerBtn.visibility = View.GONE
                        waitingForApproval.visibility = View.GONE
                        startBtn.visibility = View.VISIBLE
                    }

                } else {

                    if (item.current_user_hunt == null) {
                        waitingForApproval.visibility = View.GONE
                        notRegisteredBtn.visibility = View.VISIBLE
                    } else if (item.current_user_hunt.status.equals("pending")) {
                        notRegisteredBtn.visibility = View.GONE
                        waitingForApproval.visibility = View.VISIBLE
                    } else if (item.current_user_hunt.status.equals("approved")) {
                        waitingForApproval.visibility = View.GONE
                        notRegisteredBtn.visibility = View.GONE
                        startBtn.visibility = View.VISIBLE
                    } else if (item.current_user_hunt.status.equals("processing")) {
                        waitingForApproval.visibility = View.GONE
                        notRegisteredBtn.visibility = View.GONE
                        startBtn.visibility = View.VISIBLE
                    }
                    registerBtn.visibility = View.GONE
                }


            }
        }
    }

    private var onRegisterItemClickListener: ((TreasureWildResponse.TreasureWildListingData) -> Unit)? = null

    private var onStartItemClickListener: ((TreasureWildResponse.TreasureWildListingData) -> Unit)? = null

    fun setOnRegisterClickListener(listener: (TreasureWildResponse.TreasureWildListingData) -> Unit) {
        onRegisterItemClickListener = listener
    }

    fun setOnStartClickListener(listener: (TreasureWildResponse.TreasureWildListingData) -> Unit) {
        onStartItemClickListener = listener
    }


    companion object {
        val differCallback = object : DiffUtil.ItemCallback<TreasureWildResponse.TreasureWildListingData>() {
            override fun areItemsTheSame(
                oldItem: TreasureWildResponse.TreasureWildListingData,
                newItem: TreasureWildResponse.TreasureWildListingData
            ): Boolean {
                return oldItem.id == oldItem.id
            }

            override fun areContentsTheSame(
                oldItem: TreasureWildResponse.TreasureWildListingData,
                newItem: TreasureWildResponse.TreasureWildListingData
            ): Boolean {
                return oldItem == newItem
            }
        }
    }

}