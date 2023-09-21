//
//  LoginValidation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 23/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct LoginValidation{
    
     func validateLoginRequest(request: LoginRequest) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.email.isEmpty{
            return ValidationError(message: GoWildStrings.emailRequired(), success: false)
        }
        
        if !request.email.isValidEmail{
            return ValidationError(message: GoWildStrings.enterValidEmail(), success: false)
        }
        
        if request.password.isEmpty{
            return ValidationError(message: GoWildStrings.passwordRequired(), success: false)
        }
        
        if request.password.count < 6{
            return ValidationError(message: GoWildStrings.passwordLenghtError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
        
    }
    
}
