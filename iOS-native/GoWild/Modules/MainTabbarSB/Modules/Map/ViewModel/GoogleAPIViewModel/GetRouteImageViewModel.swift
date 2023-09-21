//
//  GetRouteImageViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 31/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol GetRouteImageViewModelDelegates: BaseProtocol{
    func didGetGoogleRouteImage(response: Data)
    func didGetGoogleRouteImageResponseWith(error: String)
}

final class GetRouteImageViewModel{
    
    weak var delegates : GetRouteImageViewModelDelegates?
    private let validator = GetRouteImageValidations()
    private let resource = GetRouteImageResource()
    
    func getRouteImage(request: GetRouteImageRequest){
        
        let validationResult = validator.validate(request: request)
        
        if validationResult.success{
            
            
            resource.getRouteImage(request: request) { response, error in
                
                DispatchQueue.main.async {
                    
                    guard let response = response,
                          error == nil else {
                        self.delegates?.didGetGoogleRouteImageResponseWith(error: error ?? GoWildStrings.oopsSomethingWentWrong())
                        return
                    }
                    
                    self.delegates?.didGetGoogleRouteImage(response: response)
                    
                }
            }
            
        }else{
            self.delegates?.didGetGoogleRouteImageResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
