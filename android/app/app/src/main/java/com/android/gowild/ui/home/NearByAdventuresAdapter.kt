package com.android.gowild.ui.home

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.android.gowild.BuildConfig
import com.android.gowild.R
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.databinding.TreasureWildCardDesignBinding
import com.android.gowild.ui.map.treasurewild.ImageListAdapter
import com.android.gowild.utils.TIME_FORMAT_TIME_STAMP
import com.android.gowild.utils.changeDateFormat
import com.android.gowild.utils.extension.gone
import com.android.gowild.utils.extension.loadImage
import com.android.gowild.utils.extension.loadSmallImage

class NearByAdventuresAdapter(var nearbyData: ArrayList<TreasureWildResponse.TreasureWildListingData>) :
    RecyclerView.Adapter<NearByAdventuresAdapter.ViewHolder>() {

    inner class ViewHolder(val binding: TreasureWildCardDesignBinding) : RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding = TreasureWildCardDesignBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.binding.apply {

            val item = nearbyData[position]

            ivImage.loadImage(BuildConfig.BASE_URL + item.picture, R.drawable.image_placeholder)

            if (item.treasureWildSponsors.isNotEmpty())
                img.loadSmallImage(BuildConfig.BASE_URL + item.treasureWildSponsors[0].img, R.drawable.image_placeholder)

            tvUsername.text = item.title
            tvDescription.text = item.description
            registeredMembers.text =
                (item.no_of_participants.toInt() - item.treasureHunts.size).toString() + "/" + item.no_of_participants + " left"
            eventTime.text = item.eventTime.changeDateFormat(TIME_FORMAT_TIME_STAMP,"HH:mm")
            date.text = item.eventDate.changeDateFormat(TIME_FORMAT_TIME_STAMP,"MM/dd/yyyy")

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
                recyclerview.context, LinearLayoutManager.HORIZONTAL,
                false
            )
            val adapter = ImageListAdapter(item.treasureHunts, recyclerview.context)
            recyclerview.adapter = adapter

            startBtn.gone()
            notRegisteredBtn.gone()
            registerBtn.gone()
            waitingForApproval.gone()

        }
    }

    override fun getItemCount(): Int {
        return nearbyData.size
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }
}