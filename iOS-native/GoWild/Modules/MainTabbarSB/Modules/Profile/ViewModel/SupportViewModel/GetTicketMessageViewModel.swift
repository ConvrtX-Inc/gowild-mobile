//
//  GetTicketMessageViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

enum TicketMessageRole: String{
    case user
    case admin
}

protocol GetTicketMessageViewModelDelegates: BaseProtocol{
    func didGetTicketMessages(response: GetTicketMessageResponse)
    func didGetTicketMessagesResponseWith(error: String)
}

final class GetTicketMessageViewModel{
    
    weak var delegates : GetTicketMessageViewModelDelegates?
    private let validator = GetTicketMessageValidations()
    private let resource = GetTicketMessageResource()
    
    func getTicketMessages(ticketID: String,pageNmb: Int){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            let currentPage = pageNmb + 1
            resource.getTicketMessagesWith(ticketID: ticketID,pageNmb: currentPage) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetTicketMessagesResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetTicketMessagesResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetTicketMessagesResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetTicketMessages(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetTicketMessagesResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
