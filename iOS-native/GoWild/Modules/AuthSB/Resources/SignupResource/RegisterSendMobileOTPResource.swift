//
//  RegisterSendMobileOTPResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RegisterSendMobileOTPResource{
    
    private let endPoint : String = "api/v1/verify/mobile/send"
    
    func sendOTP(request: RegisterSendMobileOTPRequest, completion: @escaping (_ response: RegisterSendMobileOTPResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: RegisterSendMobileOTPResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil, nil)
        }

    }
    
}
