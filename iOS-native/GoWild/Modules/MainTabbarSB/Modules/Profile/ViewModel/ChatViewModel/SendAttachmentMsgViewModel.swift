//
//  SendAttachmentMsgViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol SendAttachmentMsgViewModelDelegates: BaseProtocol{
    func didSendAttachmentMessages(response: SendAttachmentMsgResponse)
    func didSendAttachmentMessagesResponseWith(error: String)
}

final class SendAttachmentMsgViewModel{
    
    weak var delegates : SendAttachmentMsgViewModelDelegates?
    private let validator = SendAttachmentMsgValidations()
    private let resource = SendAttachmentMsgResource()
    
    func sendAttachmentOf(friendID: String,attachmentData: Data,type: String){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.sendAttachment(friendID: friendID,imageData: attachmentData,type: type) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didSendAttachmentMessagesResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didSendAttachmentMessagesResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didSendAttachmentMessagesResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didSendAttachmentMessages(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didSendAttachmentMessagesResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
