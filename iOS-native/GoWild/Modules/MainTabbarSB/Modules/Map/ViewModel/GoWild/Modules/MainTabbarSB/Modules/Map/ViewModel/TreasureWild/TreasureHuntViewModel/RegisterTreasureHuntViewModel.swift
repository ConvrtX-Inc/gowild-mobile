//
//  RegisterTreasureHuntViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 22/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol RegisterTreasureHuntViewModelDelegates: BaseProtocol{
    func didGetRegisterTreasureHunt(response: RegisterTreasureHuntResponse,eventID: String)
    func didGetRegisterTreasureHuntResponseWith(error: String)
}

final class RegisterTreasureHuntViewModel{
    
    weak var delegates : RegisterTreasureHuntViewModelDelegates?
    private let validator = RegisterTreasureHuntValidations()
    private let resource = RegisterTreasureHuntResource()
    
    func registerTreasureHunt(request: RegisterTreasureHuntRequest,eventID: String){
        
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
                            self.delegates?.didGetRegisterTreasureHuntResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetRegisterTreasureHuntResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetRegisterTreasureHuntResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetRegisterTreasureHunt(response: result,eventID: eventID)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetRegisterTreasureHuntResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
