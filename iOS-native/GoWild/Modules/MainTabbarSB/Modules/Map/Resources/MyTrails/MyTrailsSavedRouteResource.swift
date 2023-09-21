//
//  MyTrailsSavedRouteResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 18/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct MyTrailsSavedRouteResource{
    
    private let endPoint : String = "api/v1/route/save?page="
    
    func getSavedRoutesOf(pageNmb: Int,completion: @escaping (_ response : MyTrailsSavedRouteResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint + String(pageNmb), dataModel: MyTrailsSavedRouteResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
