//
//  RetrievePostResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RetrievePostResource{
    
    private let endPoint : String = "api/v1/post-feed"
    
    func retrievePosts(completion: @escaping (_ response : RetrievePostResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint, dataModel: RetrievePostResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
