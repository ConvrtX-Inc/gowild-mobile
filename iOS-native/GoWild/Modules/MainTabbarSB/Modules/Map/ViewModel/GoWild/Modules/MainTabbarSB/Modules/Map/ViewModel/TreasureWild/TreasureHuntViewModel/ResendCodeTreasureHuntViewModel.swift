//
//  ResendCodeTreasureHuntViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 27/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol ResendCodeTreasureHuntViewModelDelegates: BaseProtocol{
    func didResendRegisterTreasureHunt(response: ResendCodeTreasureHuntResponse)
    func didResendRegisterTreasureHuntResponseWith(error: String)
}

final class ResendCodeTreasureHuntViewModel{
    
    weak var delegates : ResendCodeTreasureHuntViewModelDelegates?
    private let validator = ResendCodeTreasureHuntValidations()
    private let resource = ResendCodeTreasureHuntResource()
    
    func resendTreasureHunt(request: ResendCodeTreasureHuntRequest){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.registerTreasureHunt(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didResendRegisterTreasureHuntResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didResendRegisterTreasureHuntResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didResendRegisterTreasureHuntResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didResendRegisterTreasureHunt(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didResendRegisterTreasureHuntResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
