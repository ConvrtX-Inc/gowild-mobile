//
//  RouteCompleteValidations.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct RouteCompleteValidations{
    
    func validate(request: RouteCompleteRequest) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
        
    }
    
}
