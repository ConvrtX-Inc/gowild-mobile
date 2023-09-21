//
//  GetTicketMessageResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct GetTicketMessageResource{
    
    private let endPointStr : String = "api/v1/ticket-messages/"
    
    func getTicketMessagesWith(ticketID: String,pageNmb: Int,completion: @escaping (_ response : GetTicketMessageResponse?,_ statusCode: Int?) -> Void){
        
        let endPoint = "\(endPointStr)\(ticketID)?page=\(pageNmb)"
        
        NetworkManager.getRequest(endPoint: endPoint, dataModel: GetTicketMessageResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
