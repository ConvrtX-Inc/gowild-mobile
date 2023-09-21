//
//  ResetVerifyOTPResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 02/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct ResetVerifyOTPResource{
    
    private let endPoint : String = "api/v1/auth/reset/verify/mobile"
    
    func didVerifyOTPWith(request: ResetVerifyOTPRequest, completion: @escaping (_ response: ResetVerifyOTPResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: ResetVerifyOTPResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil, nil)
        }

    }
    
}
