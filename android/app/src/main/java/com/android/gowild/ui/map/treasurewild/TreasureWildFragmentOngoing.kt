package com.android.gowild.ui.map.treasurewild

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.paging.LoadState
import androidx.paging.PagingData
import androidx.paging.filter
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView.HORIZONTAL
import androidx.viewbinding.ViewBinding
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.databinding.FragmentTreasureWildOngoingBinding
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.map.MapActivity
import com.google.gson.Gson
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.launch
import java.text.SimpleDateFormat
import java.util.*
import javax.inject.Inject

@AndroidEntryPoint
class TreasureWildFragmentOngoing : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() =
            TreasureWildFragment()
    }

    @Inject
    lateinit var treasureWildAdapterOngoing: TreasureWildAdapter

    private lateinit var binding: FragmentTreasureWildOngoingBinding
    private val treasureWildListingVM by viewModels<TreasureWildListingVM>()
    private lateinit var treasureWildData: PagingData<TreasureWildResponse.TreasureWildListingData>

    //    val sdf = SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS", Locale.ENGLISH)
    val sdf = SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH)

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentTreasureWildOngoingBinding.inflate(layoutInflater)
//        init()
        return binding
    }

    override fun onResume() {
        super.onResume()
        init()
    }


    fun init() {


        val c = Calendar.getInstance()
        val currentTime = sdf.format(c.time)

        viewLifecycleOwner.lifecycleScope.launch {
            treasureWildListingVM.treasureWildListOngoing.collect { it ->
//                treasureWildData = it
                treasureWildAdapterOngoing.submitData(it.filter { sdf.parse(it.eventDate.split("T")[0])!! == sdf.parse(currentTime) })
            }
        }

        treasureWildAdapterOngoing.setOnStartClickListener {
//            if (it.current_user_hunt?.status.equals("processing")) {
//                activity?.let { it1 ->
//                    MapActivity.replaceFragment(it1, VerifyRegistrationFragment.newInstance(huntId = it.id))
//                }
//            } else if (it.current_user_hunt?.status.equals("approved")) {
//
//            }
            if (it.winnerId != null && it.winnerId != "") {

            } else {
                activity?.let { it1 ->
                    MapActivity.replaceFragment(it1, VerifyRegistrationFragment.newInstance(huntId = it.id, Gson().toJson(it)))
                }
            }
        }

        binding.rcViewOngoing.apply {
            layoutManager = LinearLayoutManager(requireContext(), HORIZONTAL, false)
            adapter = treasureWildAdapterOngoing
        }
        binding.rcViewOngoing.adapter = treasureWildAdapterOngoing


        treasureWildAdapterOngoing.addLoadStateListener { loadState ->
            when (val state = loadState.source.refresh) {
                is LoadState.NotLoading -> {
                    hideProgress()
                }
                is LoadState.Loading -> {
                    showProgress()
                    /**
                     * Setting up the views as per your requirement
                     */
                }
                is LoadState.Error -> {
                    hideProgress()
                }
            }
        }
    }

}