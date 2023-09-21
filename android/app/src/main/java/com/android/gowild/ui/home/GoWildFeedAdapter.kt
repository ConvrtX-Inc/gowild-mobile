package com.android.gowild.ui.home

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.android.gowild.databinding.HomeItemDesignBinding

class GoWildFeedAdapter: RecyclerView.Adapter<GoWildFeedAdapter.ViewHolder>() {
    inner class ViewHolder (val binding: HomeItemDesignBinding): RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding = HomeItemDesignBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {

    }

    override fun getItemCount(): Int {
        return 5
    }
}