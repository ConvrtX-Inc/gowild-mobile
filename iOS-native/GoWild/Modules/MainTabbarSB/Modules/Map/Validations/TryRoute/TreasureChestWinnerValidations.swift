//
//  TreasureChestWinnerValidations.swift
//  GoWild
//
//  Created by SA - Haider Ali on 10/03/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct TreasureChestWinnerValidations{
    
    func validateRequest() -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
        
    }
    
}
