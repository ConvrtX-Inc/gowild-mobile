//
//  CreateTicketResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 04/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct CreateTicketResource{
    
    private let endPoint : String = "api/v1/ticket"
    
    func createTicketWith(request: CreateTicketRequest,completion: @escaping (_ response : CreateTicketResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: params, dataModel: CreateTicketResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil, nil)
        }
        
    }
    
}
