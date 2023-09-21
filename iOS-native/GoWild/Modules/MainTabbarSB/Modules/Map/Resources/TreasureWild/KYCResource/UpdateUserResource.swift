//
//  UpdateUserResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct UpdateUserResource{
    
    private let endPoint : String = "api/v1/users/update"
    
    func updateUser(request: UpdateUserRequest,phoneNmb: String,completion: @escaping (_ response : UpdateUserResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            var params = try request.asDictionary()
            
            if !phoneNmb.isEmpty{
                params[.phoneNmb] = phoneNmb
            }
            
            NetworkManager.patchRequest(endPoint: endPoint, params: params, dataModel: UpdateUserResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}

extension String{
    static let phoneNmb : String = "phoneNo"
}
