//
//  LikePostResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct LikePostResource{
    
    private let endPoint : String = "api/v1/like"
    
    func didLikePostWith(request: LikePostRequest,completion: @escaping (_ response : LikePostResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: LikePostResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil,nil)
        }
        
    }
    
}
