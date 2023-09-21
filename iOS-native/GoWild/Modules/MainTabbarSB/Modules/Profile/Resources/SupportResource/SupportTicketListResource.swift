//
//  SupportTicketListResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 04/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct SupportTicketListResource{
    
    private let endPoint : String = "api/v1/ticket/users/\(UserManager.shared.id ?? "")"
    
    func getTicketLists(completion: @escaping (_ response : SupportTicketListResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint, dataModel: SupportTicketListResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
