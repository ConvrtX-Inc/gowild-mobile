//
//  FriendRequestAcceptValidation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct FriendRequestAcceptValidation{
    
    func validate(request: FriendRequestAcceptRequest) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.id.isEmpty{
            return ValidationError(message: GoWildStrings.oopsSomethingWentWrong(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}
