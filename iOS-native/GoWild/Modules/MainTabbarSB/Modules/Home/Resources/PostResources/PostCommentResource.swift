//
//  PostCommentResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct PostCommentResource{
    
    private let endPoint : String = "api/v1/comment"
    
    func didAddNewCommentOnPostWith(request: PostAddCommentRequest,completion: @escaping (_ response : PostAddCommentResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: PostAddCommentResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}
