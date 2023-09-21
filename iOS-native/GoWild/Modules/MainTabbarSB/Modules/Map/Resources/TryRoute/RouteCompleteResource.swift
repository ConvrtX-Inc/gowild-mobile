//
//  RouteCompleteResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct RouteCompleteResource{
    
    private let endPoint : String = "api/v1/leaderboard"
    
    func didCompleteRoute(request: RouteCompleteRequest,completion: @escaping (_ response : RouteCompleteResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: RouteCompleteResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}
