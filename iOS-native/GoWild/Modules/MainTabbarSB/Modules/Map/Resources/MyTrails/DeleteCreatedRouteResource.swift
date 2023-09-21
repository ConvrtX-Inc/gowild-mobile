//
//  DeleteCreatedRouteResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct DeleteCreatedRouteResource{
    
    private let endPoint : String = "api/v1/route/"
    
    func deleteCreatedRoute(routeID: String,completion: @escaping (_ response : DeleteCreatedRouteResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.deleteRequest(endPoint: endPoint + routeID, params: nil, dataModel: DeleteCreatedRouteResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
