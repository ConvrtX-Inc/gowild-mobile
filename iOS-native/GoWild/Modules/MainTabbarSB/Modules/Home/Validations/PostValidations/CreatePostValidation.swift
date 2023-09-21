//
//  CreatePostValidation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct CreatePostValidation{
    
    func validate(request: CreatePostRequest) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.description == GoWildStrings.newPostTextViewPlaceholder(){
            return ValidationError(message: GoWildStrings.createPostDescriptionError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}
