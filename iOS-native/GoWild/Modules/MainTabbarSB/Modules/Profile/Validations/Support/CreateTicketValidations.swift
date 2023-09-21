//
//  CreateTicketValidations.swift
//  GoWild
//
//  Created by SA - Haider Ali on 04/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct CreateTicketValidations{
    
    func validate(request: CreateTicketRequest) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.subject.isEmpty{
            return ValidationError(message: GoWildStrings.subjectIsRequired(), success: false)
        }
        
        if ((request.message.isEmpty == true) || (request.message == GoWildStrings.whatWouldYouLikeToTellUs())){
            return ValidationError(message: GoWildStrings.messageIsRequired(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}
