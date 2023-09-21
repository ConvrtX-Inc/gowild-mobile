//
//  RegisterResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 23/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RegisterResource{
    
    private let endPoint : String = "api/v1/auth/register"
    
    func registerUserWith(request: RegisterRequest, completion: @escaping (_ response: RegisterBaseResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            var params = try request.asDictionary()
            
            if !Constants.fcmToken.isEmpty{
                params[.fcmToken] = Constants.fcmToken
            }
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: RegisterBaseResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil, nil)
        }

    }
    
}
