//
//  ForgotPasswordResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct ForgotPasswordResource{
    
    private let endPoint : String = "api/v1/auth/forgot/password"
    
    func didForgotPasswordWith(request: ForgotPasswordRequest, completion: @escaping (_ response: ForgotPasswordResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: ForgotPasswordResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil, nil)
        }

    }
    
}
