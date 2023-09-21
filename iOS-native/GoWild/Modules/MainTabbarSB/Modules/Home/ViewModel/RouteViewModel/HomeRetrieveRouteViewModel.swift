//
//  HomeRetrieveRouteViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol HomeRetrieveRouteViewModelDelegates: BaseProtocol{
    func didRetrieveRoutes(response: HomeRetrieveRouteResponse)
    func didRetrieveRoutesResponseWith(error: String)
}

final class HomeRetrieveRouteViewModel{
    
    weak var delegates : HomeRetrieveRouteViewModelDelegates?
    private let validator = HomeRetrieveRouteValidation()
    private let resource = HomeRetrieveRouteResource()
    
    func retrieveAdminRoutes(currentPage: Int){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            let newPage = currentPage + 1
            
            resource.retrieveAdminRoutes(currentPage: newPage) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didRetrieveRoutesResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didRetrieveRoutesResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didRetrieveRoutesResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didRetrieveRoutes(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didRetrieveRoutesResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
