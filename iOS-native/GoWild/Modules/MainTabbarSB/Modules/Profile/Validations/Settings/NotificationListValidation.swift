//
//  NotificationListValidation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct NotificationListValidation{
    
    func validateRequest() -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}
