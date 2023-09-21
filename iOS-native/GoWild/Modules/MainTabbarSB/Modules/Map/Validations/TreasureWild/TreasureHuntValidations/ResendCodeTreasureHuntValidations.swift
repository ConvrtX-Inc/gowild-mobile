//
//  ResendCodeTreasureHuntValidations.swift
//  GoWild
//
//  Created by SA - Haider Ali on 27/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct ResendCodeTreasureHuntValidations{
    
    func validateRequest() -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
        
    }
    
}
