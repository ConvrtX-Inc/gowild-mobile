//
//  GetRoutePathResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 31/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct GetRoutePathResource{
    
    let walking: String = "walking"
    let bicycling: String = "bicycling"
    let driving: String = "driving"
    let transit: String = "transit"
    let mapMode: String = "mode"
    
    func getRoutePath(request: GetRoutePathRequest,completion: @escaping (_ response : GoogleRoutePathResponse?,_ error: String?) -> Void){
        
        let urlString : String = "https://maps.googleapis.com/maps/api/directions/json?origin=\(request.sourceLat),\(request.sourceLong)&destination=\(request.destinationLat),\(request.destinationLong)&\(mapMode)=\(walking)&\(mapMode)=\(bicycling)&sensor=false&key=\(ConfigurationManager.shared.getGoogleMapApiKey())"
        
        if let url = URL(string: urlString){
            do{
                
                let request = try URLRequest(url: url, method: .get)
                
                URLSession.shared.dataTask(with: request) { data, _, error in
                    
                    if let data = data, error == nil {
                        
                        do{
                            
                            let response = try JSONDecoder().decode(GoogleRoutePathResponse.self, from: data)
                            
                            completion(response, nil)
                            
                        }catch{
                            completion(nil, error.localizedDescription)
                        }
                        
                    }else{
                        completion(nil, error?.localizedDescription ?? "")
                    }
                    
                }.resume()
                
            }catch{
                completion(nil, error.localizedDescription)
            }
            
        }else{
            completion(nil, nil)
        }
        
    }
    
}
