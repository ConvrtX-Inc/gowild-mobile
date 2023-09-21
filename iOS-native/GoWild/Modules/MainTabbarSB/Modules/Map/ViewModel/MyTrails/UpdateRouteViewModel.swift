//
//  UpdateRouteViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

import Foundation

protocol UpdateRouteViewModelDelegates: BaseProtocol{
    func didGetUpdateRoute(response: CreateNewRouteResponse)
    func didGetUpdateRouteResponseWith(error: String)
}

final class UpdateRouteViewModel{
    
    weak var delegates : UpdateRouteViewModelDelegates?
    private let validator = CreateNewRouteValidations()
    private let resource = UpdateRouteResource()
    
    func updateRouteOf(routeID: String,request: CreateNewRouteRequest){
        
        let validationResult = validator.validate(request: request)
        
        if validationResult.success{
            
            resource.didUpdateRouteOf(routeID: routeID,request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetUpdateRouteResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetUpdateRouteResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetUpdateRouteResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetUpdateRoute(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetUpdateRouteResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
