//
//  VerifyTreasureHuntValidations.swift
//  GoWild
//
//  Created by SA - Haider Ali on 22/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct VerifyTreasureHuntValidations{
    
    func validate(request: VerifyTreasureHuntRequest) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.code.isEmpty{
            return ValidationError(message: GoWildStrings.otpRequired(), success: false)
        }
        
        if request.code.count < 6{
            return ValidationError(message: "Please enter 6 digit otp code.", success: false)
        }
        
        if request.code != "000000"{
            return ValidationError(message: "Please enter 000000 OTP Code for now.", success: false)
        }
        
        return ValidationError(message: nil, success: true)
        
    }
    
}
