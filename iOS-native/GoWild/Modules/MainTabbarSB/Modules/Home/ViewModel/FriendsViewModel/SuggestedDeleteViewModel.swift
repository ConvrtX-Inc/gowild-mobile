//
//  SuggestedDeleteViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 21/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol SuggestedDeleteViewModelDelegates: BaseProtocol{
    func didDeleteSuggestedFriend(response: SuggestedDeleteResponse,friendID: String)
    func didDeleteSuggestedFriendResponseWith(error: String)
}

final class SuggestedDeleteViewModel{
    
    weak var delegates : SuggestedDeleteViewModelDelegates?
    private let validator = SuggestedDeleteValidations()
    private let resource = SuggestedDeleteResource()
    
    func deleteSuggestedFriendOf(id: String){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.deleteSuggestedFriendOf(id: id) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didDeleteSuggestedFriendResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didDeleteSuggestedFriendResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didDeleteSuggestedFriendResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didDeleteSuggestedFriend(response: result, friendID: id)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didDeleteSuggestedFriendResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
