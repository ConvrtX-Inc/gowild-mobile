//
//  GetCurrentUserResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct GetCurrentUserResource{
    
    private let endPoint : String = "api/v1/auth/me"
    
    func getCurrentUser(completion: @escaping (_ response : CurrentUserResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint, dataModel: CurrentUserResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
