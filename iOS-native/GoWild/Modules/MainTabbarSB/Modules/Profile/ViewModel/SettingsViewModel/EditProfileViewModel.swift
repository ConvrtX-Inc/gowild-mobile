//
//  EditProfileViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 12/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol EditProfileViewModelDelegates: BaseProtocol{
    func didEditUser(response: EditProfileResponse)
    func didEditUserResponseWith(error: String)
}

final class EditProfileViewModel{
    
    weak var delegates : EditProfileViewModelDelegates?
    private let validator = EditProfileValidations()
    private let resource = EditProfileResource()
    
    func editUserWith(request: EditProfileRequest,username: String){
        
        let validationResult = validator.validateUpdateUser(request: request,username: username)
        
        if validationResult.success{
            
            resource.editUser(request: request,username: username) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didEditUserResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didEditUserResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didEditUserResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didEditUser(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didEditUserResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
