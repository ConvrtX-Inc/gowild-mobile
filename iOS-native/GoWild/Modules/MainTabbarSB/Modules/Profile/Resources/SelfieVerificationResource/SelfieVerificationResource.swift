//
//  SelfieVerificationResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 15/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct SelfieVerificationResource{
    
    private let endPoint: String = "/api/v1/users/image-verification"
    
    func verifySelfie(imageOne: Data?,imageTwo: Data?,completion: @escaping (_ response : SelfieVerificationResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.postMultipartRequestForSelfieVerification(endPoint: endPoint, imageOneData: imageOne, imageTwoData: imageTwo, dataModel: SelfieVerificationResponse.self) { result, statusCode in
            completion(result, statusCode)
        }
        
    }
    
}
