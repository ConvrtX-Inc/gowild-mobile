//
//  MessagesViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 02/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol MessagesViewModelDelegates: BaseProtocol{
    func didGetMessages(response: MessagesResponse)
    func didGetMessagesResponseWith(error: String)
}

final class MessagesViewModel{
    
    weak var delegates : MessagesViewModelDelegates?
    private let validator = MessagesValidations()
    private let resource = MessagesResource()
    
    func getMessagesOf(roomID: String,currentPage: Int){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            let newPage = currentPage + 1
            
            resource.getMessagesOf(roomID: roomID,pageNmb: newPage) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetMessagesResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetMessagesResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetMessagesResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetMessages(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetMessagesResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
