//
//  LogoutResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 29/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct LogoutResource{
    
    private let endPoint : String = "api/v1/auth/logout"
    
    func didLogoutUser(completion: @escaping (_ response : LogoutResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint, dataModel: LogoutResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
