//
//  LoginResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 23/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct LoginResource{
    
    private let endPoint : String = "api/v1/auth/login"
    
    func getLogin(request: LoginRequest,completion: @escaping (_ response : LoginBaseResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            var params = try request.asDictionary()
            
            if !Constants.fcmToken.isEmpty{
                params[.fcmToken] = Constants.fcmToken
            }
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: LoginBaseResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}


extension String{
    static let fcmToken = "fcm_token"
}
