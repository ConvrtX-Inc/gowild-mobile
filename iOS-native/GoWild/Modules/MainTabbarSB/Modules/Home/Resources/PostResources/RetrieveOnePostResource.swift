//
//  RetrieveOnePostResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 13/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RetrieveOnePostResource{
    
    private let endPoint : String = "api/v1/post-feed/"
    
    func didGetPostWith(postID: String,completion: @escaping (_ response : RetrieveOnePostResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint + postID, dataModel: RetrieveOnePostResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
