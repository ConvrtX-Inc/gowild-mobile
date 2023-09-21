//
//  SetNewPasswordViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol SetNewPasswordViewModelDelegates: BaseProtocol{
    func didGetSetNewPassword(response: SetNewPasswordResponse)
    func didGetSetNewPasswordResponseWith(error: String)
}

final class SetNewPasswordViewModel{
    
    weak var delegates : SetNewPasswordViewModelDelegates?
    private let validator = SetNewPasswordValidation()
    private let resource = SetNewPasswordResource()
    
    func setNewPasswordWith(request: SetNewPasswordRequest,confirmPassword: String){
        
        let validationResult = validator.validate(request: request, confirmPassword: confirmPassword)
        
        if validationResult.success{
            
            resource.didSetNewPasswordWith(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [response?.responseMessage ?? GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetSetNewPasswordResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetSetNewPasswordResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetSetNewPasswordResponseWith(error: response?.responseMessage ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetSetNewPassword(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetSetNewPasswordResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
