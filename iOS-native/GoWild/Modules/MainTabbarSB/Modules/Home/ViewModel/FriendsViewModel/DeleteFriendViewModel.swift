//
//  DeleteFriendViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 09/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol DeleteFriendViewModelDelegates: BaseProtocol{
    func didDeleteFriend(response: DeleteFriendResponse,friendID: String)
    func didDeleteFriendResponseWith(error: String)
}

final class DeleteFriendViewModel{
    
    weak var delegates : DeleteFriendViewModelDelegates?
    private let validator = DeleteFriendValidation()
    private let resource = DeleteFriendResource()
    
    func deleteFriendWith(friendID: String){
        
        let validationResult = validator.validate(friendID: friendID)
        
        if validationResult.success{
            
            resource.deleteFriend(friendID: friendID) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didDeleteFriendResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didDeleteFriendResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didDeleteFriendResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didDeleteFriend(response: result,friendID: friendID)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didDeleteFriendResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
