package com.android.gowild.ui.base

import android.util.Log
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.annotation.LayoutRes
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.recyclerview.widget.RecyclerView
import com.android.gowild.BR

/**
 * this is a generic adapter which can accommodate any kind of data
 * the only thing we need to do for every recyclerview is to make the list item layout and data binding will handle the rest
 * not recommended for very complex lists
 */
class BindingRecyclerAdapter<T, L>(
    @LayoutRes val layout: Int,
    var data: ArrayList<T>,
    var options: Any? = null,
    private val listener: L? = null
) : RecyclerView.Adapter<BindingRecyclerAdapter.ViewHolder>() {

    class ViewHolder(val binding: ViewDataBinding) : RecyclerView.ViewHolder(binding.root)

    private var started: Long = 0

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        started = System.currentTimeMillis()
        return ViewHolder(
            DataBindingUtil.inflate(
                LayoutInflater.from(parent.context),
                layout,
                parent,
                false
            ) as ViewDataBinding
        )
    }

    override fun getItemCount(): Int {
        return data.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val bindTime = System.currentTimeMillis()
        with(holder) {
            binding.setVariable(BR.item, data.getOrNull(position))
            binding.setVariable(BR.listener, listener)
            binding.setVariable(BR.position, position)
            binding.setVariable(BR.options, options)
        }
        Log.wtf("BindTime                  ", "$position ${System.currentTimeMillis() - bindTime}")
        Log.wtf("TimeSinceViewHolderCreated", "$position ${System.currentTimeMillis() - started}")
    }


}
