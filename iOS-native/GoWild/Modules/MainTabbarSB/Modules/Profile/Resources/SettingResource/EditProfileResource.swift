//
//  EditProfileResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 12/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct EditProfileResource{
    
    private let endPoint : String = "api/v1/users/update"
    
    func editUser(request: EditProfileRequest,username: String,completion: @escaping (_ response : EditProfileResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            var params = try request.asDictionary()
            
            if !username.isEmpty{
                params[.username] = username
            }
            
            NetworkManager.patchRequest(endPoint: endPoint, params: params, dataModel: EditProfileResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}


extension String{
    static let username : String = "username"
}
