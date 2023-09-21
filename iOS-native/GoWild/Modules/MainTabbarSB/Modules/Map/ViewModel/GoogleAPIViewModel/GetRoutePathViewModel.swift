//
//  GetRoutePathViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 31/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol GetRoutePathViewModelDelegates: BaseProtocol{
    func didGetGoogleRoutePath(response: GoogleRoutePathResponse)
    func didGetGoogleRoutePathResponseWith(error: String)
}

final class GetRoutePathViewModel{
    
    weak var delegates : GetRoutePathViewModelDelegates?
    private let validator = GetRoutePathValidations()
    private let resource = GetRoutePathResource()
    
    func getRoutePath(request: GetRoutePathRequest){
        
        let validationResult = validator.validate(request: request)
        
        if validationResult.success{
            
            
            resource.getRoutePath(request: request) { response, error in
                
                DispatchQueue.main.async {
                    
                    guard let response = response,
                          error == nil else {
                        self.delegates?.didGetGoogleRoutePathResponseWith(error: error ?? GoWildStrings.oopsSomethingWentWrong())
                        return
                    }
                    
                    self.delegates?.didGetGoogleRoutePath(response: response)
                    
                }
            }
            
        }else{
            self.delegates?.didGetGoogleRoutePathResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
