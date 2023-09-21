//
//  CurrentUserValidation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct CurrentUserValidation{
    
    func validate() -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}
