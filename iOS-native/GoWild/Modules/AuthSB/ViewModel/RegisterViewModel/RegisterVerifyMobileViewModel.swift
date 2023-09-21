//
//  RegisterVerifyMobileViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol RegisterVerifyMobileViewModelDelegates: BaseProtocol{
    func didVerifyMobileOTP(response: RegisterVerifyMobileResponse)
    func didVerifyMobileOTPResponseWith(error: String)
}

final class RegisterVerifyMobileViewModel{
    
    weak var delegates : RegisterVerifyMobileViewModelDelegates?
    private let resource = RegisterVerifyMobileResource()
    private let validation = RegisterVerifyMobileValidations()
    
    func verifyMobileOTPWith(request: RegisterVerifyMobileRequest){
        
        if validation.validate(request: request).success{
            
            resource.verifyOTP(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [response?.responseMessage ?? GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didVerifyMobileOTPResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didVerifyMobileOTPResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didVerifyMobileOTPResponseWith(error: response?.responseMessage ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didVerifyMobileOTP(response: result)
                        }
                    }
                    
                }
                
            }
            
        }else{
            self.delegates?.didVerifyMobileOTPResponseWith(error: validation.validate(request: request).message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
