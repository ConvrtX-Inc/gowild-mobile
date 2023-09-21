//
//  SetNewPasswordValidation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct SetNewPasswordValidation{
    
    func validate(request: SetNewPasswordRequest,confirmPassword: String) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.password.isEmpty{
            return ValidationError(message: GoWildStrings.newPasswordRequired(), success: false)
        }
        
        if request.password.count < 6{
            return ValidationError(message: GoWildStrings.newPasswordLenghtError(), success: false)
        }
        
        if confirmPassword.isEmpty{
            return ValidationError(message: GoWildStrings.confirmPasswordRequired(), success: false)
        }
        
        if confirmPassword.count < 6{
            return ValidationError(message: GoWildStrings.confirmPasswordLenghtError(), success: false)
        }
        
        if request.password != confirmPassword{
            return ValidationError(message: GoWildStrings.bothPasswordMatchError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
        
    }
    
}
