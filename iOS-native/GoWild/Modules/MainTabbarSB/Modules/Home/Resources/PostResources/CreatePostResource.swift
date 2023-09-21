//
//  CreatePostResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct CreatePostResource{
    
    private let endPoint : String = "api/v1/post-feed"
    
    func createPostWith(request: CreatePostRequest,completion: @escaping (_ response : CreatePostResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: CreatePostResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}
