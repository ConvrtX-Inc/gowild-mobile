//
//  ResendCodeTreasureHuntResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 27/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct ResendCodeTreasureHuntResource{
    
    private let endPoint : String = "api/v1/treasure-wild/resend-code"
    
    func registerTreasureHunt(request: ResendCodeTreasureHuntRequest,completion: @escaping (_ response : ResendCodeTreasureHuntResponse?,_ statusCode: Int?) -> Void){
        
        do{
           
            let param = try request.asDictionary()
            
            NetworkManager.postRequest(endPoint: endPoint, params: param, dataModel: ResendCodeTreasureHuntResponse.self) { results, statusCode in
                completion(results, statusCode)
            }
            
        }catch{
            completion(nil, nil)
        }
        
    }
    
}
