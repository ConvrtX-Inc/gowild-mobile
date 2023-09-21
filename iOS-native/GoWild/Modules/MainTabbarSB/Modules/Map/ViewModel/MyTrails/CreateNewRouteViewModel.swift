//
//  CreateNewRouteViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol CreateNewRouteViewModelDelegates: BaseProtocol{
    func didGetCreateNewRoute(response: CreateNewRouteResponse)
    func didGetCreateNewRouteResponseWith(error: String)
}

final class CreateNewRouteViewModel{
    
    weak var delegates : CreateNewRouteViewModelDelegates?
    private let validator = CreateNewRouteValidations()
    private let resource = CreateNewRouteResource()
    
    func getMyTrailsCreatedRoutes(request: CreateNewRouteRequest){
        
        let validationResult = validator.validate(request: request)
        
        if validationResult.success{
            
            resource.didCreateNewRoute(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetCreateNewRouteResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetCreateNewRouteResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetCreateNewRouteResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetCreateNewRoute(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetCreateNewRouteResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
