//
//  LoginViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 23/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegates: BaseProtocol{
    func didGetLogin(response: LoginBaseResponse)
    func didGetLoginResponseWith(error: String)
    func didGetUserIsNotVerify(error: String)
}

final class LoginViewModel{
    
    weak var delegates : LoginViewModelDelegates?
    private let validator = LoginValidation()
    private let resource = LoginResource()
    
    func getLoginUserWith(request: LoginRequest){
        
        let validationResult = validator.validateLoginRequest(request: request)
        
        if validationResult.success{
            
            resource.getLogin(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                    case 500...599:
                        self.delegates?.didGetLoginResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                    default:
                        guard let result = response else {
                            self.delegates?.didGetLoginResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                if statusCode == 400{
                                    self.delegates?.didGetUserIsNotVerify(error: errorDict.convertBackendErrorToString())
                                }else{
                                    self.delegates?.didGetLoginResponseWith(error: errorDict.convertBackendErrorToString())
                                }
                            }else{
                                self.delegates?.didGetLoginResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetLogin(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetLoginResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
