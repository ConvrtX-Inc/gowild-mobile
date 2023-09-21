//
//  CurrentUserResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct CurrentUserResponse: Codable{
    
    let id : String?
    let createdDate : String?
    let updatedDate : String?
    let firstName : String?
    let lastName : String?
    let birthDate : String?
    let gender : String?
    let username : String?
    let email : String?
    let phoneNo : String?
    let aboutMe : String?
    let frontImage : String?
    let backImage: String?
    let userPhoto : String?
    let userStatus : CurrentUserStatus?
    let role : CurrentUserRole?
    let addressOne : String?
    let addressTwo : String?
    let message : String?
    let errors : [String]?
    let baseURL : String?
    let selfieVerified : Bool?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, updatedDate, firstName, lastName, birthDate, gender, username, email, phoneNo, role, addressOne, addressTwo, frontImage, backImage, message, errors
        case aboutMe = "about_me"
        case userPhoto = "picture"
        case userStatus = "status"
        case baseURL = "base_url"
        case selfieVerified = "selfie_verified"
    }
    
}


struct CurrentUserPicture: Codable{
    
    let id : String?
    let createdDate : String?
    let updatedDate : String?
    let path : String?
    let size : Int?
    let mimetype : String?
    let fileName : String?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, updatedDate, path, size, mimetype, fileName
    }
    
}

struct CurrentUserStatus: Codable{
    
    let id : String?
    let createdDate : String?
    let updatedDate : String?
    let statusName : String?
    let isActive : Bool?
    
    enum CodingKeys: String, CodingKey{
        case id, createdDate, updatedDate, statusName, isActive
    }
    
}

struct CurrentUserRole: Codable{
    
    let id : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey{
        case id, name
    }
    
}
