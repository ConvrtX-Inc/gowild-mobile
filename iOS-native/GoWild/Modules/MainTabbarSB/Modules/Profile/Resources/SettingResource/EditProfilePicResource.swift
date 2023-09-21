//
//  EditProfilePicResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 12/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct EditProfilePicResource{
    
    private let endPoint : String = "api/v1/users/update-pictures"
    
    func updateUser(picture: Data?,completion: @escaping (_ response : EditProfilePicResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.postUserPictureUsingMultipartData(endPoint: endPoint, data: picture, params: [:], dataModel: EditProfilePicResponse.self) { result, statusCode in
            completion(result, statusCode)
        }
        
    }
    
}
