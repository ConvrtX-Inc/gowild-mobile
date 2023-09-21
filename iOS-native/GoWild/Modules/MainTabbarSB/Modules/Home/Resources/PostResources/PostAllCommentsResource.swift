//
//  PostAllCommentsResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct PostAllCommentsResource{
    
    private let endPoint : String = "api/v1/comment/"
    
    func didGetAllCommentWith(request: PostAllCommentsRequest,completion: @escaping (_ response : PostAllCommentsResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint + request.postFeedId, dataModel: PostAllCommentsResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
