//
//  RegisterTreasureHuntResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 22/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RegisterTreasureHuntResource{
    
    private let endPoint : String = "api/v1/treasure-wild/register"
    
    func registerTreasureHunt(request: RegisterTreasureHuntRequest,completion: @escaping (_ response : RegisterTreasureHuntResponse?,_ statusCode: Int?) -> Void){
        
        do{
           
            let param = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: param, dataModel: RegisterTreasureHuntResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil, nil)
        }
        
    }
    
}
