//
//  SetNewPasswordResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct SetNewPasswordResource{
    
    private let endPoint : String = "api/v1/auth/reset/password"
    
    func didSetNewPasswordWith(request: SetNewPasswordRequest, completion: @escaping (_ response: SetNewPasswordResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: SetNewPasswordResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil, nil)
        }

    }
    
}
