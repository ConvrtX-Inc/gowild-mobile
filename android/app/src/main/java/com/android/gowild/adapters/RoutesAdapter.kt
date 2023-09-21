package com.android.gowild.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.android.gowild.BuildConfig
import com.android.gowild.R
import com.android.gowild.data.model.homeModels.HomeMapModel
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.databinding.ListItemRoutesCompletedBinding
import com.android.gowild.databinding.ListItemRoutesNewBinding
import com.android.gowild.interfaces.RoutesCallback
import com.android.gowild.ui.base.roundValue
import com.android.gowild.utils.extension.dp
import com.android.gowild.utils.extension.getAsColor
import com.android.gowild.utils.extension.getAsDrawable
import com.android.gowild.utils.extension.gone
import com.android.gowild.utils.extension.loadImage
import com.android.gowild.utils.extension.setRecyclerViewAdapter
import com.android.gowild.utils.extension.visible
import timber.log.Timber

class RoutesAdapter(var data: ArrayList<RouteDataModel>, var routesCallback: RoutesCallback, var userID: String) :
    RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    private enum class ViewTypes(val value: Int) {
        TYPE_COMPLETED(1),
        TYPE_IN_COMPLETED(2);
    }

    enum class RoutesPayLoads {
        ROUTE_LEADERBOARD_UPDATED;
    }

    override fun getItemCount(): Int {
        return data.size
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        val layoutInflater = LayoutInflater.from(parent.context)
        return RoutesViewHolder(ListItemRoutesNewBinding.inflate(layoutInflater, parent, false))
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        val startTime = System.currentTimeMillis()
        when (holder) {
            is RoutesViewHolder -> {
                holder.bind(data[position], position)
            }
        }
        Timber.tag("HomeAdapter").wtf("BINDTIME Routes pos=$position time=${(System.currentTimeMillis() - startTime)}")
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int, payloads: MutableList<Any>) {
        if (payloads.isNotEmpty()) {
            if (payloads[0] == RoutesPayLoads.ROUTE_LEADERBOARD_UPDATED) {
                (holder as RoutesViewHolder).bindLeaderboard(data[position])
            }
        } else {
            super.onBindViewHolder(holder, position, payloads)
        }
    }

    inner class RoutesViewHolder(var binding: ListItemRoutesNewBinding) : RecyclerView.ViewHolder(binding.root) {

        init {
            itemView.setOnClickListener {
                Timber.tag("ROUTE_POSITION").wtf("RoutesAdapter bindingAdapterPosition $bindingAdapterPosition")
                routesCallback.onRouteSelected(data[bindingAdapterPosition], bindingAdapterPosition)
            }

            binding.tvTryRoute.setOnClickListener {
                routesCallback.onTryRoute(data[bindingAdapterPosition], bindingAdapterPosition)
            }

            binding.tvSave.setOnClickListener {
                routesCallback.onSaveUnSaveRoute(data[bindingAdapterPosition], bindingAdapterPosition)
            }

            binding.tvDetails.setOnClickListener {
                routesCallback.onRouteDetail(data[bindingAdapterPosition])
            }

        }

        fun bind(data: RouteDataModel, position: Int) {
            binding.tvRouteName.text = data.title
            roundValue(binding.tvDistance, data.distance_miles)
            binding.tvDuration.text = data.estimate_time

            binding.tvMeters.text = "${data.distance_meters} m"

            bindLeaderboard(data)

            if (data.picture != null && data.picture != "") {
                binding.ivMap.loadImage(BuildConfig.BASE_URL + data.picture, R.drawable.image_placeholder)
            } else {
                binding.ivMap.setImageDrawable(binding.ivMap.context.getAsDrawable(R.drawable.map))
            }

            if (data.isSelected) {
                binding.view.background = itemView.context.getAsDrawable(R.drawable.routes_borders_selected)
                binding.tvTryRoute.visible()
                binding.tvSave.visible()
                binding.tvDetails.visible()
                if (data.saved) {
                    binding.tvSave.text = "Unsave"
                    binding.tvSave.background = binding.tvSave.context.getAsDrawable(R.drawable.post_btn_bg)
                    binding.tvSave.setTextColor(binding.tvSave.context.getAsColor(R.color.white))
                } else {
                    binding.tvSave.text = "Save"
                    binding.tvSave.background = binding.tvSave.context.getAsDrawable(R.drawable.new_try_route_bg)
                    binding.tvSave.setTextColor(binding.tvSave.context.getAsColor(R.color.orange_light))
                }
            } else {
                binding.view.background = itemView.context.getAsDrawable(R.drawable.routes_borders)
                binding.tvTryRoute.gone()
                binding.tvSave.gone()
                binding.tvDetails.gone()
            }
        }

        fun bindLeaderboard(data: RouteDataModel) {
            if (data.isSelected) {
                if (data.leaderboard != null && data.leaderboard!!.isNotEmpty()) {
                    binding.rvLeaderBoard.setRecyclerViewAdapter(
                        R.layout.list_item_leader_board_new,
                        data.leaderboard!!,
                        userID,
                        null
                    )
                    binding.cvMap.layoutParams.width = 50.dp
                } else {
                    binding.rvLeaderBoard.adapter = null
                    binding.cvMap.layoutParams.width = 100.dp
                }
            } else {
                binding.rvLeaderBoard.adapter = null
                binding.cvMap.layoutParams.width = 100.dp
            }
        }
    }

    inner class RoutesCompletedViewHolder(var binding: ListItemRoutesCompletedBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(data: HomeMapModel, position: Int) {

        }
    }
}
