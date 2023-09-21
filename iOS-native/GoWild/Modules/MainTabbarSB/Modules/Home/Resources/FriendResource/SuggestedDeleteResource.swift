//
//  SuggestedDeleteResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 21/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct SuggestedDeleteResource{
    
    private let endPoint : String = "api/v1/friends/suggested/remove/"
    
    func deleteSuggestedFriendOf(id: String,completion: @escaping (_ response : SuggestedDeleteResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint + id, dataModel: SuggestedDeleteResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
