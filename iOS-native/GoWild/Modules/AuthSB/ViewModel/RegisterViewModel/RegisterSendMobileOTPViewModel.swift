//
//  RegisterSendMobileOTPViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol RegisterSendMobileOTPViewModelDelegates: BaseProtocol{
    func didGetOTPToMobile(response: RegisterSendMobileOTPResponse)
    func didGetOTPToMobilResponseWith(error: String)
}

final class RegisterSendMobileOTPViewModel{
    
    weak var delegates : RegisterSendMobileOTPViewModelDelegates?
    private let resource = RegisterSendMobileOTPResource()
    private let validation = RegisterSendMobileOTPValidations()
    
    func getOTPOnMobileWith(request: RegisterSendMobileOTPRequest){
        
        if validation.validate().success{
            
            resource.sendOTP(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [response?.responseMessage ?? GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetOTPToMobilResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetOTPToMobilResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetOTPToMobilResponseWith(error: response?.responseMessage ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetOTPToMobile(response: result)
                        }
                    }
                    
                }
                
            }
            
        }else{
            self.delegates?.didGetOTPToMobilResponseWith(error: validation.validate().message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
