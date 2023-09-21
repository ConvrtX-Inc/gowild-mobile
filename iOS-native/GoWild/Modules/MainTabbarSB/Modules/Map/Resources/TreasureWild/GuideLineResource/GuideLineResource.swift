//
//  GuideLineResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 19/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct GuideLineResource{
    
    private let endPoint : String = "api/v1/admin-guidelines/"
    
    func getAdminGuidelinesOf(type: GuideLineType,completion: @escaping (_ response : GuideLineResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint + type.rawValue, dataModel: GuideLineResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
