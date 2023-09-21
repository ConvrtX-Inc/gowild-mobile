//
//  SendSupportMessageResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct SendSupportMessageResource{
    
    private let endPoint : String = "api/v1/ticket-messages/"
    
    func sendTicketMessage(ticketID: String,request: SendSupportMessageRequest,completion: @escaping (_ response : SendSupportMessageResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint + ticketID, params: params, dataModel: SendSupportMessageResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil, nil)
        }
        
    }
    
}
