//
//  MyTrailsCreatedRouteResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 18/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct MyTrailsCreatedRouteResource{
    
    private let endPoint : String = "api/v1/route/created-routes?page="
    
    func getCreatedRoutes(currentPage: Int,completion: @escaping (_ response : MyTrailsCreatedRouteResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: "\(endPoint)\(currentPage)", dataModel: MyTrailsCreatedRouteResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
