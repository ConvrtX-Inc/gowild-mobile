//
//  VerifyTreasureHuntViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 22/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol VerifyTreasureHuntViewModelDelegates: BaseProtocol{
    func didVerifyTreasureHunt(response: VerifyTreasureHuntResponse)
    func didVerifyTreasureHuntResponseWith(error: String)
}

final class VerifyTreasureHuntViewModel{
    
    weak var delegates : VerifyTreasureHuntViewModelDelegates?
    private let validator = VerifyTreasureHuntValidations()
    private let resource = VerifyTreasureHuntResource()
    
    func verifyTreasureHunt(request: VerifyTreasureHuntRequest){
        
        let validationResult = validator.validate(request: request)
        
        if validationResult.success{
            
            resource.verifyTreasureHunt(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didVerifyTreasureHuntResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didVerifyTreasureHuntResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didVerifyTreasureHuntResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didVerifyTreasureHunt(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didVerifyTreasureHuntResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
