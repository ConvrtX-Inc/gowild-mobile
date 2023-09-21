//
//  CurrentUserViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol CurrentUserViewModelDelegates: BaseProtocol{
    func didGetCurrentUser(response: CurrentUserResponse)
    func didGetCurrentUserResponseWith(error: String)
}

final class CurrentUserViewModel{
    
    weak var delegates : CurrentUserViewModelDelegates?
    private let validator = CurrentUserValidation()
    private let resource = GetCurrentUserResource()
    
    func getCurrentUser(){
        
        let validationResult = validator.validate()
        
        if validationResult.success{
            
            resource.getCurrentUser { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetCurrentUserResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            self.delegates?.didGetCurrentUserResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                        }else{
                            self.delegates?.didGetCurrentUser(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetCurrentUserResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
