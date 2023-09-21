//
//  GuideLineViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 19/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol GuideLineViewModelDelegates: BaseProtocol{
    func didGetAdminGuideLines(response: GuideLineResponse)
    func didGetAdminGuideLinesResponseWith(error: String)
}

final class GuideLineViewModel{
    
    weak var delegates : GuideLineViewModelDelegates?
    private let validator = GuideLineValidations()
    private let resource = GuideLineResource()
    
    func getAdminGuideLinesOf(type: GuideLineType){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.getAdminGuidelinesOf(type: type) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetAdminGuideLinesResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetAdminGuideLinesResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetAdminGuideLinesResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetAdminGuideLines(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetAdminGuideLinesResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
