//
//  RegisterValidation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 23/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

final class RegisterValidation{
    
    func validateRegister(request: RegisterRequest,isValidPhoneNmb: Bool) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.firstName.isEmpty{
            return ValidationError(message: GoWildStrings.fullNameRequired(), success: false)
        }
        
        if request.firstName.count < 1{
            return ValidationError(message: GoWildStrings.fullNameLenghtError(), success: false)
        }
        
        if request.firstName.count > 30{
            return ValidationError(message: GoWildStrings.fullNameLenghtError(), success: false)
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
        
        if !isValidPhoneNmb{
            return ValidationError(message: GoWildStrings.phoneNmbIsInvalid(), success: false)
        }
        
        if request.addressOne.isEmpty{
            return ValidationError(message: GoWildStrings.addressLineOneRequired(), success: false)
        }
        
        if request.addressOne.count > 20{
            return ValidationError(message: GoWildStrings.addressLineLenghtError(), success: false)
        }
        
        if request.addressTwo.isEmpty{
            return ValidationError(message: GoWildStrings.addressLineTwoRequired(), success: false)
        }
        
        if request.addressTwo.count > 20{
            return ValidationError(message: GoWildStrings.addressLineLenghtError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}
