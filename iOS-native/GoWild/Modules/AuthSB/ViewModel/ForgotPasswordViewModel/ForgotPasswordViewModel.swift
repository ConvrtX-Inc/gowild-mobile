//
//  ForgotPasswordViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol ForgotPasswordViewModelDelegates: BaseProtocol{
    func didGetForgotPassword(response: ForgotPasswordResponse)
    func didGetForgotPasswordResponseWith(error: String)
}

final class ForgotPasswordViewModel{
    
    weak var delegates : ForgotPasswordViewModelDelegates?
    private let validator = ForgotPasswordValidation()
    private let resource = ForgotPasswordResource()
    
    func forgotPasswordWith(request: ForgotPasswordRequest,isValidPhone: Bool){
        
        let validationResult = validator.validate(request: request,isValidPhoneNmb: isValidPhone)
        
        if validationResult.success{
            
            resource.didForgotPasswordWith(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [response?.responseMessage ?? GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetForgotPasswordResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetForgotPasswordResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetForgotPasswordResponseWith(error: response?.responseMessage ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetForgotPassword(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetForgotPasswordResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
