//
//  MyTrailsCreatedRouteViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 18/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol MyTrailsCreatedRouteViewModelDelegates: BaseProtocol{
    func didGetMyTrailsCreatedRoute(response: MyTrailsCreatedRouteResponse)
    func didGetMyTrailsCreatedRouteResponseWith(error: String)
}

final class MyTrailsCreatedRouteViewModel{
    
    weak var delegates : MyTrailsCreatedRouteViewModelDelegates?
    private let validator = MyTrailsCreatedRouteValidations()
    private let resource = MyTrailsCreatedRouteResource()
    
    func getMyTrailsCreatedRoutes(currentPage: Int){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            let pageNmb = currentPage + 1
            resource.getCreatedRoutes(currentPage: pageNmb) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetMyTrailsCreatedRouteResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetMyTrailsCreatedRouteResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetMyTrailsCreatedRouteResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetMyTrailsCreatedRoute(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetMyTrailsCreatedRouteResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
