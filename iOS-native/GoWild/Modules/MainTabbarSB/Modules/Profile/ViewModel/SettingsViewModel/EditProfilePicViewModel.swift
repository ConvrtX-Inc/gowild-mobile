//
//  EditProfilePicViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 12/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol EditProfilePicViewModelDelegates: BaseProtocol{
    func didUpdateUserPicture(response: EditProfilePicResponse)
    func didUpdateUserPictureResponseWith(error: String)
}

final class EditProfilePicViewModel{
    
    weak var delegates : EditProfilePicViewModelDelegates?
    private let validator = EditProfilePicValidation()
    private let resource = EditProfilePicResource()
    
    func uploadUser(image: Data?){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.updateUser(picture: image) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didUpdateUserPictureResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didUpdateUserPictureResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didUpdateUserPictureResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didUpdateUserPicture(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didUpdateUserPictureResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
