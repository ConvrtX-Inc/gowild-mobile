//
//  SaveRouteResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct SaveRouteResource{
    
    private let endPoint : String = "api/v1/route/save"
    
    func didSaveOrUnSaveRoute(request: SaveRouteRequest,completion: @escaping (_ response : SaveRouteResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: SaveRouteResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}
