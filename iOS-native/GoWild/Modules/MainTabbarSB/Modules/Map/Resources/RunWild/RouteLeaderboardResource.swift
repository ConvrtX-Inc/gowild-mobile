//
//  RouteLeaderboardResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct RouteLeaderboardResource{
    
    private let endPoint : String = "api/v1/leaderboard/"
    
    func getRouteLeaderboard(currentPage: Int,routeID: String,completion: @escaping (_ response : RouteLeaderboardResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: "\(endPoint)\(routeID)?pageNmb=\(currentPage)", dataModel: RouteLeaderboardResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
