//
//  ForgotPasswordValidation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct ForgotPasswordValidation{
    
    func validate(request: ForgotPasswordRequest,isValidPhoneNmb: Bool) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.email.isEmpty{
            return ValidationError(message: GoWildStrings.emailRequired(), success: false)
        }
        
        if !request.email.isValidEmail{
            return ValidationError(message: GoWildStrings.enterValidEmail(), success: false)
        }
        
        if !isValidPhoneNmb{
            return ValidationError(message: GoWildStrings.phoneNmbIsInvalid(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
        
    }
    
}
