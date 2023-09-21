//
//  InboxResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 02/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct InboxResource{
    
    private let endPoint : String = "api/v1/messages/inbox"
    
    func getInboxLists(pageNmb: Int,completion: @escaping (_ response : InboxResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint, dataModel: InboxResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
