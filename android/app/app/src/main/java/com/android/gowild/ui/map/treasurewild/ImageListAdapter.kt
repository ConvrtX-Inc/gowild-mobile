package com.android.gowild.ui.map.treasurewild

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import androidx.recyclerview.widget.RecyclerView
import com.android.gowild.BuildConfig
import com.android.gowild.R
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.utils.extension.loadImage


class ImageListAdapter(private val mList: List<TreasureWildResponse.TreasureWildListingData.TreasureWildHunts>, val context: Context) :
    RecyclerView.Adapter<ImageListAdapter.ViewHolder>() {

    // create new views
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        // inflates the card_view_design view
        // that is used to hold list item
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_image_list, parent, false)

        return ViewHolder(view)
    }

    // binds the list items to a view
    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.imageView.loadImage(BuildConfig.BASE_URL + mList[position].user.picture)
    }

    // return the number of the items in the list
    override fun getItemCount(): Int {
        if (mList.size >= 5) {
            return 5
        } else {
            return mList.size
        }
    }

    // Holds the views for adding it to image and text
    class ViewHolder(ItemView: View) : RecyclerView.ViewHolder(ItemView) {
        val imageView: ImageView = itemView.findViewById(R.id.user_img)
    }
}