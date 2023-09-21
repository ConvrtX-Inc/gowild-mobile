//
//  NotificationListResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct NotificationListResource{
    
    private let endPoint : String = "api/v1/notifications"
    
    func getNotifications(completion: @escaping (_ response : NotificationListResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint, dataModel: NotificationListResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
