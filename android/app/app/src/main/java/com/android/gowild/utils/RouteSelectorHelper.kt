package com.android.gowild.utils

import com.android.gowild.adapters.HomeAdapter
import com.android.gowild.data.model.homeModels.HomeMapModel
import com.android.gowild.data.model.routes.ApprovedRoutesResponse
import com.android.gowild.data.model.routes.RouteDataModel
import timber.log.Timber

class RouteSelectorHelper {

    private var mapPosition: Int = 1
    lateinit var homeMapModel: HomeMapModel
    lateinit var homeAdapter: HomeAdapter
    lateinit var routesResponse: ApprovedRoutesResponse
    lateinit var routes: ArrayList<RouteDataModel>
    lateinit var routeSelectorInterface: () -> Unit

    fun setupHelper(
        homeMapModel: HomeMapModel,
        routesResponse: ApprovedRoutesResponse,
        homeAdapter: HomeAdapter,
        mapPosition: Int = 1,
        routeSelectorInterface: () -> Unit
    ) {
        this.homeMapModel = homeMapModel
        this.routesResponse = routesResponse
        this.routes = routesResponse.data
        this.homeAdapter = homeAdapter
        this.routeSelectorInterface = routeSelectorInterface
        this.mapPosition = mapPosition

        homeMapModel.apiCurrentPage = routesResponse.currentPage
        homeMapModel.apiTotalPages = routesResponse.totalPage
        homeMapModel.apiTotalCount = routesResponse.count
        homeMapModel.routesIndex = 0

        addFirstRoutes()
    }

    fun selectPrevious() {
        if (!::homeMapModel.isInitialized)
            return
        Timber.tag("RouteHelper").wtf("-----------------------")
        Timber.tag("RouteHelper").wtf("before")
        Timber.tag("RouteHelper").wtf("selectNext -> homeMapModel.selectedItemIndex == ${homeMapModel.selectedItemIndex}")
        Timber.tag("RouteHelper").wtf("selectNext -> homeMapModel.routesIndex == ${homeMapModel.routesIndex}")
        Timber.tag("RouteHelper").wtf("selectNext -> routes.indexOfFirst == ${homeMapModel.routes.indexOfFirst { it.isSelected }}")
        if (homeMapModel.selectedItemIndex != 0) {
            homeMapModel.selectedItemIndex--
            homeMapModel.routesIndex--
            homeMapModel.routes.forEachIndexed { index, routeDataModel -> routeDataModel.isSelected = homeMapModel.selectedItemIndex == index }
            homeAdapter.notifyItemChanged(mapPosition, HomeAdapter.HomePayLoads.PAYLOAD_MAP_ROUTE_SELECTED)
            Timber.wtf("RouteHelper", "")
        } else {
            if (homeMapModel.routesIndex != 0) {
                homeMapModel.routesIndex--
                homeMapModel.routes.clear()
                val start = homeMapModel.routesIndex
                val end = homeMapModel.routesIndex + 2
                homeMapModel.routes.addAll(routes.slice(start..end))
                homeMapModel.routes.forEachIndexed { index, routeDataModel -> routeDataModel.isSelected = homeMapModel.selectedItemIndex == index }
                homeAdapter.notifyItemChanged(mapPosition, HomeAdapter.HomePayLoads.PAYLOAD_SET_NEW_ROUTES)
            } else {
                // end of start
            }
        }
        Timber.tag("RouteHelper").wtf("after")
        Timber.tag("RouteHelper").wtf("selectNext -> homeMapModel.selectedItemIndex == ${homeMapModel.selectedItemIndex}")
        Timber.tag("RouteHelper").wtf("selectNext -> homeMapModel.routesIndex == ${homeMapModel.routesIndex}")
        Timber.tag("RouteHelper").wtf("selectNext -> routes.indexOfFirst == ${homeMapModel.routes.indexOfFirst { it.isSelected }}")
        Timber.tag("RouteHelper").wtf("-----------------------")
    }

    fun selectNext() {
        if (!::homeMapModel.isInitialized)
            return
        Timber.tag("RouteHelper").wtf("-----------------------")
        Timber.tag("RouteHelper").wtf("before")
        Timber.tag("RouteHelper").wtf("selectNext -> homeMapModel.selectedItemIndex == ${homeMapModel.selectedItemIndex}")
        Timber.tag("RouteHelper").wtf("selectNext -> homeMapModel.routesIndex == ${homeMapModel.routesIndex}")
        Timber.tag("RouteHelper").wtf("selectNext -> routes.indexOfFirst == ${homeMapModel.routes.indexOfFirst { it.isSelected }}")
        if (homeMapModel.selectedItemIndex != 2) {
            homeMapModel.selectedItemIndex++
            homeMapModel.routesIndex++
            homeMapModel.routes.forEachIndexed { index, routeDataModel -> routeDataModel.isSelected = homeMapModel.selectedItemIndex == index }
            homeAdapter.notifyItemChanged(mapPosition, HomeAdapter.HomePayLoads.PAYLOAD_MAP_ROUTE_SELECTED)
        } else {
            if (homeMapModel.routesIndex != routes.lastIndex) {
                homeMapModel.routesIndex++
                homeMapModel.routes.clear()
                val start = homeMapModel.routesIndex - 2
                val end = homeMapModel.routesIndex
                homeMapModel.routes.addAll(routes.slice(start..end))
                homeMapModel.routes.forEachIndexed { index, routeDataModel -> routeDataModel.isSelected = homeMapModel.selectedItemIndex == index }
                homeAdapter.notifyItemChanged(mapPosition, HomeAdapter.HomePayLoads.PAYLOAD_SET_NEW_ROUTES)
            } else {
                if (hasMoreRoutes()) {
                    fetchMoreRoutes()
                } else {
                    // end of end
                }
            }
        }
        Timber.tag("RouteHelper").wtf("after")
        Timber.tag("RouteHelper").wtf("selectNext -> homeMapModel.selectedItemIndex == ${homeMapModel.selectedItemIndex}")
        Timber.tag("RouteHelper").wtf("selectNext -> homeMapModel.routesIndex == ${homeMapModel.routesIndex}")
        Timber.tag("RouteHelper").wtf("selectNext -> routes.indexOfFirst == ${homeMapModel.routes.indexOfFirst { it.isSelected }}")
        Timber.tag("RouteHelper").wtf("-----------------------")

//        Timber.tag("RouteHelper").wtf("$homeMapModel")
    }

    fun fetchMoreRoutes() {
        routeSelectorInterface()
    }

    private fun hasMoreRoutes(): Boolean {
        return homeMapModel.apiCurrentPage != homeMapModel.apiTotalPages
    }

    private fun addFirstRoutes() {
        if (routes.size < 4) {
            homeMapModel.routes.clear()
            homeMapModel.routes.addAll(routes)
            homeMapModel.routes.forEachIndexed { index, routeDataModel -> routeDataModel.isSelected = homeMapModel.selectedItemIndex == index }
            homeAdapter.notifyItemChanged(mapPosition, HomeAdapter.HomePayLoads.PAYLOAD_MAP_ROUTE_SELECTED)
        } else {
            homeMapModel.routes.clear()
            homeMapModel.routes.addAll(routes.subList(0, 3))
            homeMapModel.routes.forEachIndexed { index, routeDataModel -> routeDataModel.isSelected = homeMapModel.selectedItemIndex == index }
            homeAdapter.notifyItemChanged(mapPosition, HomeAdapter.HomePayLoads.PAYLOAD_MAP_ROUTE_SELECTED)
        }
    }

    fun addMoreRoutes(routes: ApprovedRoutesResponse) {
        homeMapModel.apiCurrentPage = routes.currentPage
        this.routes.addAll(routes.data)
        selectNext()
    }

    fun updateSelectedRoute(position: Int) {
        homeMapModel.selectedItemIndex = position
        homeMapModel.routesIndex = routes.indexOf(homeMapModel.routes[homeMapModel.selectedItemIndex])
        homeMapModel.routes.forEachIndexed { index, routeDataModel -> routeDataModel.isSelected = homeMapModel.selectedItemIndex == index }
    }

}