//
//  FriendRequestViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol FriendRequestViewModelDelegates: BaseProtocol{
    func didGetFriendsRequest(response: FriendRequestResponse)
    func didGetFriendsRequestResponseWith(error: String)
}

final class FriendRequestViewModel{
    
    weak var delegates : FriendRequestViewModelDelegates?
    private let validator = FriendRequestValidation()
    private let resource = FriendRequestResource()
    
    func getAllFriendsRequest(){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.friendsRequest { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetFriendsRequestResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetFriendsRequestResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetFriendsRequestResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetFriendsRequest(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetFriendsRequestResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
