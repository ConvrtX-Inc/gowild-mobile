//
//  UpdateUserPicturesViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol UpdateUserPicturesViewModelDelegates: BaseProtocol{
    func didUpdateUserPictures(response: UpdateUserPicturesResponse)
    func didUpdateUserPicturesResponseWith(error: String)
}

final class UpdateUserPicturesViewModel{
    
    weak var delegates : UpdateUserPicturesViewModelDelegates?
    private let validator = UpdateUserPicturesValidation()
    private let resource = UpdateUserPicturesResource()
    
    func updateUserWith(images: [Data]?){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.updateUserPictures(images: images) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didUpdateUserPicturesResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didUpdateUserPicturesResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didUpdateUserPicturesResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didUpdateUserPictures(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didUpdateUserPicturesResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
