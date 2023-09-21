//
//  MyTrailsSavedRouteViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 18/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol MyTrailsSavedRouteViewModelDelegates: BaseProtocol{
    func didGetMyTrailsSavedRoute(response: MyTrailsSavedRouteResponse)
    func didGetMyTrailsSavedRouteResponseWith(error: String)
}

final class MyTrailsSavedRouteViewModel{
    
    weak var delegates : MyTrailsSavedRouteViewModelDelegates?
    private let validator = MyTrailsSavedRouteValidations()
    private let resource = MyTrailsSavedRouteResource()
    
    func getMyTrailsSavedRoutesOf(pageNmb: Int){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            let currentPage = pageNmb + 1
            
            resource.getSavedRoutesOf(pageNmb: currentPage) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetMyTrailsSavedRouteResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetMyTrailsSavedRouteResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetMyTrailsSavedRouteResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetMyTrailsSavedRoute(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetMyTrailsSavedRouteResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
