//
//  MessagesResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 02/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct MessagesResource{
    
    private let endPoint : String = "api/v1/messages/"
    
    func getMessagesOf(roomID: String,pageNmb: Int,completion: @escaping (_ response : MessagesResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: "\(endPoint)\(roomID)?page=\(pageNmb)", dataModel: MessagesResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
