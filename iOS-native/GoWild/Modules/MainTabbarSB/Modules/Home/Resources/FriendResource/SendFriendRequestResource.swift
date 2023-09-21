//
//  SendFriendRequestResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 09/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct SendFriendRequestResource{
    
    private let endPoint : String = "api/v1/friends/send-friend-request"
    
    func sendFriendRequest(request: SendFriendRequest,completion: @escaping (_ response : SendFriendRequestResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: SendFriendRequestResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}
