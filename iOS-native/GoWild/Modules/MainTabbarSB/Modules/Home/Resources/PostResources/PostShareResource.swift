//
//  PostShareResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct PostShareResource{
    
    private let endPoint : String = "api/v1/post-feed/share/"
    
    func sharePostWith(postId: String,completion: @escaping (_ response : PostShareResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint + "\(postId)", dataModel: PostShareResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
