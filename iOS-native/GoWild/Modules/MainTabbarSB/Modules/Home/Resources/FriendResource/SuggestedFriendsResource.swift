//
//  SuggestedFriendsResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct SuggestedFriendsResource{
    
    private let endPoint : String = "api/v1/friends/suggested-friends"
    
    func suggestedFriends(completion: @escaping (_ response : SuggestedFriendsResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint, dataModel: SuggestedFriendsResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
