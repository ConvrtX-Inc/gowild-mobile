//
//  DeleteCreatedRouteViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol DeleteCreatedRouteViewModelDelegates: BaseProtocol{
    func didDeleteCreatedRoute(response: DeleteCreatedRouteResponse,routeID: String)
    func didGetDeleteCreatedRouteResponseWith(error: String)
}

final class DeleteCreatedRouteViewModel{
    
    weak var delegates : DeleteCreatedRouteViewModelDelegates?
    private let validator = DeleteCreatedRouteValidations()
    private let resource = DeleteCreatedRouteResource()
    
    func getMyTrailsCreatedRoutes(routeID: String){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.deleteCreatedRoute(routeID: routeID) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetDeleteCreatedRouteResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetDeleteCreatedRouteResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetDeleteCreatedRouteResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didDeleteCreatedRoute(response: result, routeID: routeID)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetDeleteCreatedRouteResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
