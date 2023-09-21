//
//  TreasureChestWinnerResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 10/03/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct TreasureChestWinnerResource{
    
    private let endPoint : String = "/api/v1/treasure-wild/"
    
    func didCompleteChestOf(chestID: String,completion: @escaping (_ response : TreasureChestWinnerResponse?,_ statusCode: Int?) -> Void){
        
        NetworkManager.postRequest(endPoint: endPoint + chestID, params: nil, dataModel: TreasureChestWinnerResponse.self) { results, statusCode in
            completion(results, statusCode)
        }
        
    }
    
}
