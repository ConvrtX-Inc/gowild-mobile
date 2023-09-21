//
//  TreasureHuntViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 20/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol TreasureHuntViewModelDelegates: BaseProtocol{
    func didGetTreasureHunt(response: TreasureHuntResponse)
    func didGetTreasureHuntResponseWith(error: String)
}

final class TreasureHuntViewModel{
    
    weak var delegates : TreasureHuntViewModelDelegates?
    private let validator = TreasureHuntValidations()
    private let resource = TreasureHuntResource()
    
    func getTreasureHuntOf(pageNmb: Int){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            let currentPage = pageNmb + 1
            
            resource.getTreasureHuntOf(pageNmb: currentPage) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetTreasureHuntResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetTreasureHuntResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetTreasureHuntResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetTreasureHunt(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetTreasureHuntResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
