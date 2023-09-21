//
//  FriendRequestAcceptResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct FriendRequestAcceptResource{
    
    private let endPoint : String = "api/v1/friends/confirm"
    
    func acceptFriend(request: FriendRequestAcceptRequest,completion: @escaping (_ response : FriendRequestAcceptResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: FriendRequestAcceptResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}
