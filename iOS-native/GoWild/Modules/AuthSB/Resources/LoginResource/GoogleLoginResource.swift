//
//  GoogleLoginResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 28/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct GoogleLoginResource{
    
    private let endPoint : String = "api/v1/auth/google/login"
    
    func didGoogleLoginWith(request: GoogleLoginRequest,completion: @escaping (_ response : GoogleLoginResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            var params = try request.asDictionary()
            
            if !Constants.fcmToken.isEmpty{
                params[.fcmToken] = Constants.fcmToken
            }
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: GoogleLoginResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}
