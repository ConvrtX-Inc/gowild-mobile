//
//  UpdateUserValidation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct UpdateUserValidation{
    
    func validateUpdateUser(request: UpdateUserRequest,phoneNmb: String,isValidNmb: Bool,images: [Data?]) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.firstName.isEmpty{
            return ValidationError(message: GoWildStrings.fullNameRequired(), success: false)
        }
        
        if request.firstName.count < 1{
            return ValidationError(message: GoWildStrings.fullNameLenghtError(), success: false)
        }
        
        if request.firstName.count > 30{
            return ValidationError(message: GoWildStrings.fullNameLenghtError(), success: false)
        }
        
        if (!phoneNmb.isEmpty && !isValidNmb){
            return ValidationError(message: GoWildStrings.phoneNmbIsInvalid(), success: false)
        }
        
        if images.isEmpty{
            return ValidationError(message: GoWildStrings.idImagesError(), success: false)
        }
        
        if images[0] == nil{
            return ValidationError(message: GoWildStrings.frontIdImageError(), success: false)
        }
        
        if images[1] == nil{
            return ValidationError(message: GoWildStrings.backIdImageError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}
