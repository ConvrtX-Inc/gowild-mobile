//
//  UpdateUserPicturesResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct UpdateUserPicturesResource{
    
    private let endPoint : String = "api/v1/users/update-pictures"
    
    func updateUserPictures(images: [Data]?,completion: @escaping (_ response : UpdateUserPicturesResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.postMultipartRequestWithMultipleData(endPoint: endPoint, data: images, params: [:], dataModel: UpdateUserPicturesResponse.self) { result, statusCode in
            completion(result, statusCode)
        }
        
    }
    
}
