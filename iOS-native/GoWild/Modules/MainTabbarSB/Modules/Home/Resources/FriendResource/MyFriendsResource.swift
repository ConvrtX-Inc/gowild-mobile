//
//  MyFriendsResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct MyFriendsResource{
    
    private let endPoint : String = "api/v1/friends/my"
    
    func getAllMyFriends(completion: @escaping (_ response : MyFriendsResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint, dataModel: MyFriendsResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
