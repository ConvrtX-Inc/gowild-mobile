//
//  MyAchievementResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct MyAchievementResource{
    
    private let endPoint : String = "api/v1/leaderboard"
    
    func getMyAchievements(completion: @escaping (_ response : MyAchievementResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint, dataModel: MyAchievementResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
