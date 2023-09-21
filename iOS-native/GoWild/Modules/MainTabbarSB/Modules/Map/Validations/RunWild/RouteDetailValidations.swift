//
//  RouteDetailValidations.swift
//  GoWild
//
//  Created by SA - Haider Ali on 20/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct RouteDetailValidations{
    
    func validateRequest() -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}
