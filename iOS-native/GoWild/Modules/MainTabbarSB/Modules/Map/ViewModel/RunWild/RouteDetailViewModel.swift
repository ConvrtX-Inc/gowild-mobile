//
//  RouteDetailViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 20/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import CoreLocation

protocol RouteDetailViewModelDelegates: BaseProtocol{
    func didGetRouteDetail(response: RouteDetailResponse)
    func didGetRouteDetailResponseWith(error: String)
    func didGettileQuery(response: TileQueryResponse)
}

final class RouteDetailViewModel{
    
    weak var delegates : RouteDetailViewModelDelegates?
    private let validator = RouteDetailValidations()
    private let resource = RouteDetailResource()
    
    func getRouteDetail(routeID: String){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.getRouteDetail(routeID: routeID) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetRouteDetailResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetRouteDetailResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetRouteDetailResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetRouteDetail(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetRouteDetailResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
    func getTileQueryResponse(coordinates: CLLocationCoordinate2D, radius: Int, limit: Int) {
        let validationResult = validator.validateRequest()

        if validationResult.success{

            resource.fetchTileData(for: coordinates, radious: radius, limit: limit) { response, statusCode in
                
                DispatchQueue.main.async {
                    guard let statusCode = statusCode else {return}
                    switch statusCode {
                    case 401...430:
                        self.delegates?.didReceiveUnauthentic(error: [String(describing: statusCode) ])

                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetRouteDetailResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        self.delegates?.didGettileQuery(response: result)
                    }

                }
                
            }
        }else {
            self.delegates?.didGetRouteDetailResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
    }
    
}
