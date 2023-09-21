//
//  FriendRequestResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct FriendRequestResource{
    
    private let endPoint : String = "api/v1/friends/received"
    
    func friendsRequest(completion: @escaping (_ response : FriendRequestResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint, dataModel: FriendRequestResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
