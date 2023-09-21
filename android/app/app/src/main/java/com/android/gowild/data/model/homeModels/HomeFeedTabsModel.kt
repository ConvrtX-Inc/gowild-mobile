package com.android.gowild.data.model.homeModels

import com.android.gowild.adapters.HomeAdapter.HomeFeedSelectedTab

data class HomeFeedTabsModel(
    var selectedTab: HomeFeedSelectedTab = HomeFeedSelectedTab.MY_FEED
)