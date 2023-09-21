//
//  SendFriendRequestViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 09/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol SendFriendRequestViewModelDelegates: BaseProtocol{
    func didSendFriendRequest(response: SendFriendRequestResponse,index: Int)
    func didSendFriendRequestResponseWith(error: String)
}

final class SendFriendRequestViewModel{
    
    weak var delegates : SendFriendRequestViewModelDelegates?
    private let validator = SendFriendRequestValidation()
    private let resource = SendFriendRequestResource()
    
    func sendFriendRequestWith(request: SendFriendRequest,index: Int){
        
        let validationResult = validator.validate(request: request)
        
        if validationResult.success{
            
            resource.sendFriendRequest(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didSendFriendRequestResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didSendFriendRequestResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didSendFriendRequestResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didSendFriendRequest(response: result,index: index)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didSendFriendRequestResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
