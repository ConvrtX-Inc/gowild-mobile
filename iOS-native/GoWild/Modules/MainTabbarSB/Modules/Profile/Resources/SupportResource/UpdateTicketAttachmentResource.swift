//
//  UpdateTicketAttachmentResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 04/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct UpdateTicketAttachmentResource{
    
    private let endPoint : String = "/api/v1/ticket/"
    
    func updateTicketAttachmentWith(id: String,images: [Data],request: UpdateTicketAttachmentRequest,completion: @escaping (_ response : UpdateTicketAttachmentResponse?,_ statusCode: Int?) -> Void){
        
        do{
            
            let params = try request.asDictionary()
            
            let newEndPoint = endPoint + "\(id)" + "/update-image"
            
            NetworkManager.updateTicketImages(endPoint: newEndPoint, data: images,params: params, dataModel: UpdateTicketAttachmentResponse.self) { result, statusCode in
                completion(result, statusCode)
            }
            
        }catch{
            completion(nil, nil)
        }
        
    }
    
}
