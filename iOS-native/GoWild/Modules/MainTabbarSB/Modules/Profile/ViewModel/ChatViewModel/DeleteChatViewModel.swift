//
//  DeleteChatViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol DeleteChatViewModelDelegates: BaseProtocol{
    func didGetDeleteChat(response: DeleteChatResponse)
    func didGetDeleteChatResponseWith(error: String)
}

final class DeleteChatViewModel{
    
    weak var delegates : DeleteChatViewModelDelegates?
    private let validator = DeleteChatValidations()
    private let resource = DeleteChatResource()
    
    func deleteChhatOf(friendID: String){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.deleteChatOf(friendID: friendID) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetDeleteChatResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetDeleteChatResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetDeleteChatResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetDeleteChat(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetDeleteChatResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
