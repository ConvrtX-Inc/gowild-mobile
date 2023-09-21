//
//  SelfieVerificationViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 15/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol SelfieVerificationViewModelDelegates: BaseProtocol{
    func didGetSelfieVerification(response: SelfieVerificationResponse)
    func didGetSelfieVerificationResponseWith(error: String)
}

final class SelfieVerificationViewModel{
    
    weak var delegates : SelfieVerificationViewModelDelegates?
    private let validator = SelfieVerificationValidations()
    private let resource = SelfieVerificationResource()
    
    func getSelfieVerification(imageOne: Data?,imageTwo: Data?){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.verifySelfie(imageOne: imageOne,imageTwo: imageTwo) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetSelfieVerificationResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetSelfieVerificationResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetSelfieVerificationResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetSelfieVerification(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetSelfieVerificationResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
