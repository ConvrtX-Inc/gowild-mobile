//
//  PostUpdatePictureViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol PostUpdatePictureViewModelDelegates: BaseProtocol{
    func didUpdatePostImage(response: PostUpdatePictureResponse)
    func didUpdatePostImageResponseWith(error: String)
}

final class PostUpdatePictureViewModel{
    
    weak var delegates : PostUpdatePictureViewModelDelegates?
    private let validator = PostUpdatePictureValidation()
    private let resource = PostUpdatePictureResource()
    
    func updatePostImageWith(postID: String,imageData: Data?,attachmentData: Data?){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.updatePostImage(postID: postID, imageData: imageData, attachmentData: attachmentData) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didUpdatePostImageResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didUpdatePostImageResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didUpdatePostImageResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didUpdatePostImage(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didUpdatePostImageResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
