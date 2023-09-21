//
//  SaveRouteViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol SaveRouteViewModelDelegates: BaseProtocol{
    func didGetSaveUnSaveRoute(response: SaveRouteResponse,with routeID: String)
    func didGetSaveUnSaveRouteResponseWith(error: String)
}

final class SaveRouteViewModel{
    
    weak var delegates : SaveRouteViewModelDelegates?
    private let validator = SaveRouteValidations()
    private let resource = SaveRouteResource()
    
    func getMyTrailsCreatedRoutes(request: SaveRouteRequest){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.didSaveOrUnSaveRoute(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetSaveUnSaveRouteResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetSaveUnSaveRouteResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetSaveUnSaveRouteResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetSaveUnSaveRoute(response: result,with: request.routeID)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetSaveUnSaveRouteResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
