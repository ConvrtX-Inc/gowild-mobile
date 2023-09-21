//
//  SendFriendRequestValidation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 09/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct SendFriendRequestValidation{
    
    func validate(request: SendFriendRequest) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.email.isEmpty{
            return ValidationError(message: GoWildStrings.oopsSomethingWentWrong(), success: false)
        }
        
        /*
        if request.email.isValidEmail{
            return ValidationError(message: GoWildStrings.enterValidEmail(), success: false)
        }
         */
        
        return ValidationError(message: nil, success: true)
    }
    
}
