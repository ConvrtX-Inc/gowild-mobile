//
//  DeleteChatResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct DeleteChatResource{
    
    private let endPoint : String = "api/v1/messages/"
    
    func deleteChatOf(friendID: String,completion: @escaping (_ response : DeleteChatResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.postRequest(endPoint: "\(endPoint)\(friendID)", params: nil, dataModel: DeleteChatResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
