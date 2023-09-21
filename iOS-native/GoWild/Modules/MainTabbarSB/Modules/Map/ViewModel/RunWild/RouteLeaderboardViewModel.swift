//
//  RouteLeaderboardViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol RouteLeaderboardViewModelDelegates: BaseProtocol{
    func didGetRouteLeaderboard(response: RouteLeaderboardResponse)
    func didGetRouteLeaderboardResponseWith(error: String)
}

final class RouteLeaderboardViewModel{
    
    weak var delegates : RouteLeaderboardViewModelDelegates?
    private let validator = RouteLeaderboardValidations()
    private let resource = RouteLeaderboardResource()
    
    func getRouteLeaderboard(currentPage: Int,routeID: String){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            let newPage = currentPage + 1
            
            resource.getRouteLeaderboard(currentPage: newPage,routeID: routeID) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetRouteLeaderboardResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetRouteLeaderboardResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetRouteLeaderboardResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetRouteLeaderboard(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetRouteLeaderboardResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
