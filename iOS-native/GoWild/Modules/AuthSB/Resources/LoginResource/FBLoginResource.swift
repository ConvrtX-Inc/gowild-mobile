//
//  FBLoginResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct FBLoginResource{
    
    private let endPoint : String = "api/v1/auth/facebook/login"
    
    func didFBLoginWith(request: FBLoginRequest,completion: @escaping (_ response : FBLoginBaseResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            var params = try request.asDictionary()
            
            if !Constants.fcmToken.isEmpty{
                params[.fcmToken] = Constants.fcmToken
            }
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: FBLoginBaseResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}
