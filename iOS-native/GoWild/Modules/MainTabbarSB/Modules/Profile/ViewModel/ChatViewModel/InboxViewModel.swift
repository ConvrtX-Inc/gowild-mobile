//
//  InboxViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 02/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol InboxViewModelDelegates: BaseProtocol{
    func didGetInboxList(response: InboxResponse)
    func didGetInboxListResponseWith(error: String)
}

final class InboxViewModel{
    
    weak var delegates : InboxViewModelDelegates?
    private let validator = InboxValidations()
    private let resource = InboxResource()
    
    func getInboxList(currentPage: Int){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.getInboxLists(pageNmb: currentPage) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetInboxListResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetInboxListResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetInboxListResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetInboxList(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetInboxListResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
