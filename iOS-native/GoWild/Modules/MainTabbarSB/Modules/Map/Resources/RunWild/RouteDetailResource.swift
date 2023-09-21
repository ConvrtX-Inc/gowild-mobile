//
//  RouteDetailResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 20/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import CoreLocation

struct RouteDetailResource{
    
    private let endPoint : String = "api/v1/route/"
    
    func getRouteDetail(routeID: String,completion: @escaping (_ response : RouteDetailResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: "\(endPoint)\(routeID)", dataModel: RouteDetailResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
    func fetchTileData(for coordinate: CLLocationCoordinate2D, radious: Int, limit: Int, completion: @escaping (_ results: TileQueryResponse?, _ statusCode: Int?) -> Void) {
        let baseUrl = "https://api.mapbox.com/v4/mapbox.mapbox-terrain-v2/tilequery/"
            let endPoint = "\(coordinate.longitude),\(coordinate.latitude).json?radius=\(radious)&limit=\(limit)&dedupe&access_token=\(ConfigurationManager.shared.getMapBoxAccessToken())"

        NetworkManager.getRequestForTileSet(endPoint: baseUrl + endPoint, dataModel: TileQueryResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
    }
}
