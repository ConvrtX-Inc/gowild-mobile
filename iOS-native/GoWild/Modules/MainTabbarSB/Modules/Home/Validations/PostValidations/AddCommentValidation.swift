//
//  AddCommentValidation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct AddCommentValidation{
    
    func validateRequest(request: PostAddCommentRequest) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.message.isEmpty{
            return ValidationError(message: GoWildStrings.commentEmptyError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}