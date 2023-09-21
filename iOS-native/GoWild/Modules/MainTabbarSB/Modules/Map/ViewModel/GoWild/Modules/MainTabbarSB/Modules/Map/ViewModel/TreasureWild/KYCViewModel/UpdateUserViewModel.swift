//
//  UpdateUserViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol UpdateUserViewModelDelegates: BaseProtocol{
    func didUpdateUser(response: UpdateUserResponse)
    func didUpdateUserResponseWith(error: String)
}

final class UpdateUserViewModel{
    
    weak var delegates : UpdateUserViewModelDelegates?
    private let validator = UpdateUserValidation()
    private let resource = UpdateUserResource()
    
    func updateUserWith(request: UpdateUserRequest,phoneNmb: String,isValidNmb: Bool,images: [Data?]){
        
        let validationResult = validator.validateUpdateUser(request: request,phoneNmb: phoneNmb,isValidNmb: isValidNmb,images: images)
        
        if validationResult.success{
            
            resource.updateUser(request: request,phoneNmb: phoneNmb) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didUpdateUserResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didUpdateUserResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didUpdateUserResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didUpdateUser(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didUpdateUserResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
