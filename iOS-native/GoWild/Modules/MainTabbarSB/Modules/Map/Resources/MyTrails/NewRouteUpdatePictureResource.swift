//
//  NewRouteUpdatePictureResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct NewRouteUpdatePictureResource{
    
    private let endPoint : String = "api/v1/route/"
    
    func didCreateNewRoute(routeID: String,imageData: Data,completion: @escaping (_ response : NewRouteUpdatePictureResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.postMultipartRequest(endPoint: "\(endPoint)\(routeID)/update-picture", data: imageData, attachmentData: nil, params: [:], dataModel: NewRouteUpdatePictureResponse.self) { result, statusCode in
            completion(result, statusCode)
        }
        
    }
    
}
