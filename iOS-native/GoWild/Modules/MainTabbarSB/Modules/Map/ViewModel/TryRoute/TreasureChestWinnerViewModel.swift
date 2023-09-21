//
//  TreasureChestWinnerViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 10/03/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol TreasureChestWinnerViewModelDelegates: BaseProtocol{
    func didGetChestComplete(response: TreasureChestWinnerResponse)
    func didGetChestCompleteResponseWith(error: String)
}

final class TreasureChestWinnerViewModel{
    
    weak var delegates : TreasureChestWinnerViewModelDelegates?
    private let validator = TreasureChestWinnerValidations()
    private let resource = TreasureChestWinnerResource()
    
    func didCompleteChestOf(chestID: String){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.didCompleteChestOf(chestID: chestID) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetChestCompleteResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetChestCompleteResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetChestCompleteResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetChestComplete(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetChestCompleteResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
