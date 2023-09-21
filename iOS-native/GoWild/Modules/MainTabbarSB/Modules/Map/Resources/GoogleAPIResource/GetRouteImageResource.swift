//
//  GetRouteImageResource.swift
//  GoWild
//
//  Created by SA - Haider Ali on 31/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

struct GetRouteImageResource{
    
    func getRouteImage(request: GetRouteImageRequest,completion: @escaping (_ response : Data?,_ error: String?) -> Void){
        
        let baseUrl = "https://maps.googleapis.com/maps/api/staticmap?"
        let parameters: [String: String] = [
            "size": "600x400",
            "path": "color:green|weight:5|enc:\(request.points)",
            "zoom": "12",
            "markers": "color:red|label:S|\(request.sourceLat),\(request.sourceLong)|\(request.destinationLat),\(request.destinationLong)",
            "key": ConfigurationManager.shared.getGoogleMapApiKey()
        ]
        let urlString = baseUrl + parameters.map { key, value in
            "\(key)=\(value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }.joined(separator: "&")
        
        if let url = URL(string: urlString){
            do{
                
                let request = try URLRequest(url: url, method: .get)
                
                URLSession.shared.dataTask(with: request) { data, _, error in
                    
                    if let data = data, error == nil {
                            
                        completion(data, nil)
                        
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


/*
 ///Chat GPT Solution...
 let baseUrl = "https://maps.googleapis.com/maps/api/staticmap?"
 let parameters: [String: String] = [
     "size": "600x400",
     "path": "color:green|weight:5|enc:\(request.points)",
     "zoom": "14",
     "markers": "color:red|label:S|\(request.sourceLat),\(request.sourceLong)|\(request.destinationLat),\(request.destinationLong)",
     "key": ConfigurationManager.shared.getGoogleMapApiKey()
 ]
 let urlString = baseUrl + parameters.map { key, value in
     "\(key)=\(value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
 }.joined(separator: "&")
 
 */
