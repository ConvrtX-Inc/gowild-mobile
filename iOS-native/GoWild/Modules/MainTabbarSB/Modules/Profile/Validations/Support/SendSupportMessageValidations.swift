//
//  SendSupportMessageValidations.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct SendSupportMessageValidations{
    
    func validate(request: SendSupportMessageRequest) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.message.isEmpty{
            return ValidationError(message: GoWildStrings.messageIsRequired(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}
