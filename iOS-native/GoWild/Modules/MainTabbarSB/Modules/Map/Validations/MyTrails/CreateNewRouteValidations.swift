//
//  CreateNewRouteValidations.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct CreateNewRouteValidations{
    
    func validate(request: CreateNewRouteRequest) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.title.isEmpty{
            return ValidationError(message: GoWildStrings.routeNameRequired(), success: false)
        }
        
        if ((request.start.latitude == 0.0) && (request.start.longitude == 0.0)){
            return ValidationError(message: GoWildStrings.startingPointRequired(), success: false)
        }
        
        if ((request.end.latitude == 0.0) && (request.end.longitude == 0.0)){
            return ValidationError(message: GoWildStrings.endPointRequired(), success: false)
        }
        
        if (request.routePath.isEmpty){
            return ValidationError(message: GoWildStrings.invalidRoutePath(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
        
    }
    
}
