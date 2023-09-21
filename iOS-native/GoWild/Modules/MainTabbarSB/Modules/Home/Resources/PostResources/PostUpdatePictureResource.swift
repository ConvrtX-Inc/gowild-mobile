//
//  PostUpdatePictureResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct PostUpdatePictureResource{
    
    func updatePostImage(postID: String,imageData: Data?,attachmentData: Data?,completion: @escaping (_ response : PostUpdatePictureResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.postMultipartRequest(endPoint: "api/v1/post-feed/\(postID)/update-picture", data: imageData, attachmentData: attachmentData, params: [:], dataModel: PostUpdatePictureResponse.self) { result, statusCode in
            completion(result, statusCode)
        }
        
    }
    
}
