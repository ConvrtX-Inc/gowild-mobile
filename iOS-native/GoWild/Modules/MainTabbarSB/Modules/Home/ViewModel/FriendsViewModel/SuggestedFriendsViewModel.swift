//
//  SuggestedFriendsViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol SuggestedFriendsViewModelDelegates: BaseProtocol{
    func didGetSuggestedFriends(response: SuggestedFriendsResponse)
    func didGetSuggestedFriendsResponseWith(error: String)
}

final class SuggestedFriendsViewModel{
    
    weak var delegates : SuggestedFriendsViewModelDelegates?
    private let validator = SuggestedFriendsValidation()
    private let resource = SuggestedFriendsResource()
    
    func getSuggestedFriends(){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.suggestedFriends { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetSuggestedFriendsResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetSuggestedFriendsResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetSuggestedFriendsResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetSuggestedFriends(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetSuggestedFriendsResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
