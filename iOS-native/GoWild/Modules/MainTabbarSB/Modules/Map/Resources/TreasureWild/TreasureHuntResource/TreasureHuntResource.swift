//
//  TreasureHuntResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 20/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct TreasureHuntResource{
    
    private let endPoint : String = "api/v1/treasure-wild/listings?page="
    
    func getTreasureHuntOf(pageNmb: Int,completion: @escaping (_ response : TreasureHuntResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.getRequest(endPoint: endPoint + String(pageNmb), dataModel: TreasureHuntResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
