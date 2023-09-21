//
//  ResetVerifyOTPViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 02/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol ResetVerifyOTPViewModelDelegates: BaseProtocol{
    func didGetResetVerifyOTP(response: ResetVerifyOTPResponse)
    func didGetResetVerifyOTPResponseWith(error: String)
}

final class ResetVerifyOTPViewModel{
    
    weak var delegates : ResetVerifyOTPViewModelDelegates?
    private let validator = ResetVerifyOTPValidation()
    private let resource = ResetVerifyOTPResource()
    
    func resetVerifyPhoneWith(request: ResetVerifyOTPRequest){
        
        let validationResult = validator.validate(request: request)
        
        if validationResult.success{
            
            resource.didVerifyOTPWith(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [response?.responseMessage ?? GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetResetVerifyOTPResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetResetVerifyOTPResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetResetVerifyOTPResponseWith(error: response?.responseMessage ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetResetVerifyOTP(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetResetVerifyOTPResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
