//
//  EditProfileValidations.swift
//  GoWild
//
//  Created by SA - Haider Ali on 12/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct EditProfileValidations{
    
    func validateUpdateUser(request: EditProfileRequest,username: String) -> ValidationError{
        
        if !Network.isAvailable{
            return ValidationError(message: GoWildStrings.oopsNetworkError(), success: false)
        }
        
        if request.firstName.isEmpty{
            return ValidationError(message: GoWildStrings.firstNameRequired(), success: false)
        }
        
        if request.firstName.count < 2{
            return ValidationError(message: GoWildStrings.firstNameLenghtError(), success: false)
        }
        
        if request.firstName.count > 15{
            return ValidationError(message: GoWildStrings.firstNameLenghtError(), success: false)
        }
        
        if request.lastName.isEmpty{
            return ValidationError(message: GoWildStrings.lastNameRequired(), success: false)
        }
        
        if request.lastName.count < 2{
            return ValidationError(message: GoWildStrings.lastNameLenghtError(), success: false)
        }
        
        if request.lastName.count > 15{
            return ValidationError(message: GoWildStrings.lastNameLenghtError(), success: false)
        }
        
//        if !(username.isEmpty) && (username.count) > 15{
//            return ValidationError(message: GoWildStrings.userNameLenghtError(), success: false)
//        }
        
        if (request.aboutMe != GoWildStrings.typeHere()) && !(request.aboutMe.isEmpty) && (request.aboutMe.count > 100){
            return ValidationError(message: GoWildStrings.aboutMeLenghtError(), success: false)
        }
        
        return ValidationError(message: nil, success: true)
    }
    
}
