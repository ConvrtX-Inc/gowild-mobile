package com.android.gowild.data.model.homeModels

import android.os.Parcelable
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import java.util.ArrayList

data class HomeNearbyAdventureListModel(
    var nearbyAdventures: ArrayList<TreasureWildResponse.TreasureWildListingData>,
    var isActive: Boolean = true,
    var scrollPosition: Parcelable? = null
)
