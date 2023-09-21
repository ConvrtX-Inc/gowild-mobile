//
//  RouteCompleteViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol RouteCompleteViewModelDelegates: BaseProtocol{
    func didGetRouteComplete(response: RouteCompleteResponse)
    func didGetRouteCompleteResponseWith(error: String)
}

final class RouteCompleteViewModel{
    
    weak var delegates : RouteCompleteViewModelDelegates?
    private let validator = RouteCompleteValidations()
    private let resource = RouteCompleteResource()
    
    func didCompleteRoute(request: RouteCompleteRequest){
        
        let validationResult = validator.validate(request: request)
        
        if validationResult.success{
            
            resource.didCompleteRoute(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetRouteCompleteResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetRouteCompleteResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetRouteCompleteResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetRouteComplete(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetRouteCompleteResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
