//
//  RegisterVerifyMobileResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RegisterVerifyMobileResource{
    
    private let endPoint : String = "api/v1/auth/verify/mobile"
    
    func verifyOTP(request: RegisterVerifyMobileRequest, completion: @escaping (_ response: RegisterVerifyMobileResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: RegisterVerifyMobileResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil, nil)
        }

    }
    
}
