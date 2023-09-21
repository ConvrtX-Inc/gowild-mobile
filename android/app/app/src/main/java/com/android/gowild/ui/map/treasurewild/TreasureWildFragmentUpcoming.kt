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
import com.android.gowild.databinding.FragmentTreasureWildUpcomingBinding
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.ewaiver.EWaiverFragment
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.utils.constant.NameConst
import com.google.gson.Gson
import dagger.hilt.android.AndroidEntryPoint
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale
import javax.inject.Inject

@AndroidEntryPoint
class TreasureWildFragmentUpcoming : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() =
            TreasureWildFragment()
    }

    @Inject
    lateinit var treasureWildAdapterUpcoming: TreasureWildAdapter

    private lateinit var binding: FragmentTreasureWildUpcomingBinding
    private val treasureWildListingVM by viewModels<TreasureWildListingVM>()
    private lateinit var treasureWildData: PagingData<TreasureWildResponse.TreasureWildListingData>

    //    val sdf = SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS", Locale.ENGLISH)
    val sdf = SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH)

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentTreasureWildUpcomingBinding.inflate(layoutInflater)
        init()
        return binding
    }

    override fun onResume() {
        super.onResume()
        treasureWildAdapterUpcoming.notifyDataSetChanged()
    }

    fun init() {
        binding.rcViewUpcoming.adapter = null
        val c = Calendar.getInstance()
        val currentTime = sdf.format(c.time)

        lifecycleScope.launchWhenResumed {
            treasureWildListingVM.treasureWildListUpcoming.collect { it ->
//                treasureWildData = it
                treasureWildAdapterUpcoming.submitData(it.filter { sdf.parse(it.eventDate.split("T")[0])!! > sdf.parse(currentTime) })
//                    treasureWildAdapterUpcoming.submitData(it)
            }
        }

        lifecycleScope.launchWhenCreated {
            treasureWildListingVM.treasureWildListUpcoming.collect { it ->
//                treasureWildData = it
                treasureWildAdapterUpcoming.submitData(it.filter { sdf.parse(it.eventDate.split("T")[0])!! > sdf.parse(currentTime) })
//                    treasureWildAdapterUpcoming.submitData(it)
            }
        }

        treasureWildAdapterUpcoming.setOnRegisterClickListener {
            if (it.current_user_hunt == null)
                activity?.let { it1 ->
                    MapActivity.replaceFragment(
                        it1,
                        EWaiverFragment.newInstance(
                            type = NameConst.HUNT_E_WAIVER,
                            huntId = it.id,
                            huntPic = it.picture.toString(),
                            huntName = it.title,
                            email = "",
                            password = ""
                        )
                    )
                }
        }

        treasureWildAdapterUpcoming.setOnStartClickListener {

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

        binding.rcViewUpcoming.apply {
            layoutManager = LinearLayoutManager(requireContext(), HORIZONTAL, false)
            adapter = treasureWildAdapterUpcoming
            isNestedScrollingEnabled = true
        }
        binding.rcViewUpcoming.adapter = treasureWildAdapterUpcoming

        treasureWildAdapterUpcoming.addLoadStateListener { loadState ->
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