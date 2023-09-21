//
//  FriendRequestAcceptViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol FriendRequestAcceptViewModelDelegates: BaseProtocol{
    func didAcceptFriendRequest(response: FriendRequestAcceptResponse,userID: String)
    func didAcceptFriendRequestResponseWith(error: String)
}

final class FriendRequestAcceptViewModel{
    
    weak var delegates : FriendRequestAcceptViewModelDelegates?
    private let validator = FriendRequestAcceptValidation()
    private let resource = FriendRequestAcceptResource()
    
    func getAllFriendsRequest(request: FriendRequestAcceptRequest,userID: String){
        
        let validationResult = validator.validate(request: request)
        
        if validationResult.success{
            
            resource.acceptFriend(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didAcceptFriendRequestResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didAcceptFriendRequestResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didAcceptFriendRequestResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didAcceptFriendRequest(response: result,userID: userID)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didAcceptFriendRequestResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
