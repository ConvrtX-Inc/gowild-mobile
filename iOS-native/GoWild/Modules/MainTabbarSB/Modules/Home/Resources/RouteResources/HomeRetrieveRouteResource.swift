//
//  HomeRetrieveRouteResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct HomeRetrieveRouteResource{
    
    private let endPoint : String = "api/v1/route/approved"
    
    func retrieveAdminRoutes(currentPage: Int,completion: @escaping (_ response : HomeRetrieveRouteResponse?,_ statusCode: Int?) -> Void){
        
        let newEndPoint = "\(endPoint)?lat=\(LocationManager.shared.lat)&long=\(LocationManager.shared.long)&page=\(currentPage)"
        
        NetworkManager.getRequest(endPoint: newEndPoint, dataModel: HomeRetrieveRouteResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
