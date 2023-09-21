//
//  UpdateTicketAttachmentViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 04/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol UpdateTicketAttachmentViewModelDelegates: BaseProtocol{
    func didUpdateTicketAttachments(response: UpdateTicketAttachmentResponse)
    func didUpdateTicketAttachmentsResponseWith(error: String)
}

final class UpdateTicketAttachmentViewModel{
    
    weak var delegates : UpdateTicketAttachmentViewModelDelegates?
    private let validator = UpdateTicketAttachmentValidations()
    private let resource = UpdateTicketAttachmentResource()
    
    func updateTicket(id: String,images: [Data],request: UpdateTicketAttachmentRequest){
        
        let validationResult = validator.validate(images: images)
        
        if validationResult.success{
            
            resource.updateTicketAttachmentWith(id: id,images: images,request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didUpdateTicketAttachmentsResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didUpdateTicketAttachmentsResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didUpdateTicketAttachmentsResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didUpdateTicketAttachments(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didUpdateTicketAttachmentsResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
