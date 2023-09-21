//
//  NewRouteUpdatePictureViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 01/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol NewRouteUpdatePictureViewModelDelegates: BaseProtocol{
    func didUpdateNewRoutePicture(response: NewRouteUpdatePictureResponse)
    func didUpdateNewRoutePictureResponseWith(error: String)
}

final class NewRouteUpdatePictureViewModel{
    
    weak var delegates : NewRouteUpdatePictureViewModelDelegates?
    private let validator = NewRouteUpdatePictureValidations()
    private let resource = NewRouteUpdatePictureResource()
    
    func updateNewRoutePicture(routeID: String,imageData: Data){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.didCreateNewRoute(routeID: routeID,imageData: imageData) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didUpdateNewRoutePictureResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didUpdateNewRoutePictureResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didUpdateNewRoutePictureResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didUpdateNewRoutePicture(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didUpdateNewRoutePictureResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
