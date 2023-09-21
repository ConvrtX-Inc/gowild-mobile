//
//  RegisterViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 23/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol RegisterViewModelDelegates: BaseProtocol{
    func didGetRegisterUser(response: RegisterBaseResponse)
    func didGetRegisterUserResponseWith(error: String)
}

final class RegisterViewModel{
    
    weak var delegates : RegisterViewModelDelegates?
    private let validator = RegisterValidation()
    private let resource = RegisterResource()
    
    func getRegisterUserWith(request: RegisterRequest,isValidPhoneNmb: Bool){
        
        let validationResult = validator.validateRegister(request: request,isValidPhoneNmb: isValidPhoneNmb)
        
        if validationResult.success{
            
            resource.registerUserWith(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [response?.responseMessage ?? GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetRegisterUserResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetRegisterUserResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetRegisterUserResponseWith(error: response?.responseMessage ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetRegisterUser(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetRegisterUserResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
