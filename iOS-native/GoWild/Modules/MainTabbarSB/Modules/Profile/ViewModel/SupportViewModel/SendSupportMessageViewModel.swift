//
//  SendSupportMessageViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol SendSupportMessageViewModelDelegates: BaseProtocol{
    func didGetSendTicketMessage(response: SendSupportMessageResponse)
    func didGetSendTicketMessageResponseWith(error: String)
}

final class SendSupportMessageViewModel{
    
    weak var delegates : SendSupportMessageViewModelDelegates?
    private let validator = SendSupportMessageValidations()
    private let resource = SendSupportMessageResource()
    
    func sendSupportMessage(request: SendSupportMessageRequest,ticketID: String){
        
        let validationResult = validator.validate(request: request)
        
        if validationResult.success{
            
            resource.sendTicketMessage(ticketID: ticketID,request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetSendTicketMessageResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetSendTicketMessageResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetSendTicketMessageResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetSendTicketMessage(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetSendTicketMessageResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
