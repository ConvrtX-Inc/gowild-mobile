//
//  UpdateRouteResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct UpdateRouteResource{
    
    private let endPoint : String = "api/v1/route/"
    
    func didUpdateRouteOf(routeID: String,request: CreateNewRouteRequest,completion: @escaping (_ response : CreateNewRouteResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.patchRequest(endPoint: "\(endPoint)\(routeID)", params: params, dataModel: CreateNewRouteResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}
