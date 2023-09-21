//
//  SendAttachmentMsgResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct SendAttachmentMsgResource{
    
    private let endPoint : String = "api/v1/messages/"
    
    func sendAttachment(friendID: String,imageData: Data,type: String,completion: @escaping (_ response : SendAttachmentMsgResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.postMultipartRequestToSendAttachmentMsg(endPoint: "\(endPoint)\(friendID)/update-image", data: imageData, type: type, dataModel: SendAttachmentMsgResponse.self) { result, statusCode in
            completion(result, statusCode)
        }
        
    }
    
}
