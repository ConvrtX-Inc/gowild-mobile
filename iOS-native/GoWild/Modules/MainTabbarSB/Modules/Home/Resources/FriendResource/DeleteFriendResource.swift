//
//  DeleteFriendResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 09/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct DeleteFriendResource{
    
    private let endPoint : String = "api/v1/friends/"
    
    func deleteFriend(friendID: String,completion: @escaping (_ response : DeleteFriendResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.deleteRequest(endPoint: endPoint + friendID, params: nil, dataModel: DeleteFriendResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
