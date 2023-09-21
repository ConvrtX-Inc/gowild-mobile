//
//  SupportTicketListViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 04/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

enum TicketStatusEnum: String{
  case completed
  case pending
  case onhold
}

protocol SupportTicketListViewModelDelegates: BaseProtocol{
    func didGetTicketList(response: SupportTicketListResponse)
    func didGetTicketListResponseWith(error: String)
}

final class SupportTicketListViewModel{
    
    weak var delegates : SupportTicketListViewModelDelegates?
    private let validator = SupportTicketListValidations()
    private let resource = SupportTicketListResource()
    
    func getTicketsList(){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.getTicketLists { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetTicketListResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetTicketListResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetTicketListResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetTicketList(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetTicketListResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
