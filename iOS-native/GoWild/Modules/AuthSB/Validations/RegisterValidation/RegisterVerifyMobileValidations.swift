//
//  RegisterVerifyMobileValidations.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct RegisterVerifyMobileValidations{
    
    func validate(request: RegisterVerifyMobileRequest) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.otpCode.isEmpty{
            return ValidationError(message: GoWildStrings.otpRequired(), success: false)
        }
        
        if request.otpCode.count < 4{
            return ValidationError(message: GoWildStrings.otpLengthError(), success: false)
        }
        
        if request.otpCode != "0000"{
            return ValidationError(message: "Please enter 0000 OTP Code for now.", success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}