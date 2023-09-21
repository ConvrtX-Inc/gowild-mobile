//
//  CreateTicketViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 04/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol CreateTicketViewModelDelegates: BaseProtocol{
    func didCreateTicket(response: CreateTicketResponse)
    func didCreateTicketResponseWith(error: String)
}

final class CreateTicketViewModel{
    
    weak var delegates : CreateTicketViewModelDelegates?
    private let validator = CreateTicketValidations()
    private let resource = CreateTicketResource()
    
    func createTicketWith(request: CreateTicketRequest){
        
        let validationResult = validator.validate(request: request)
        
        if validationResult.success{
            
            resource.createTicketWith(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didCreateTicketResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didCreateTicketResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didCreateTicketResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didCreateTicket(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didCreateTicketResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
