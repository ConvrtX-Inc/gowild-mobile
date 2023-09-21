//
//  DeleteFriendValidation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 09/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct DeleteFriendValidation{
    
    func validate(friendID: String) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if friendID.isEmpty{
            return ValidationError(message: GoWildStrings.oopsSomethingWentWrong(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}
