//
//  CreatePostViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol CreatePostViewModelDelegates: BaseProtocol{
    func didCreateNewPost(response: CreatePostResponse)
    func didCreateNewPostResponseWith(error: String)
}

final class CreatePostViewModel{
    
    weak var delegates : CreatePostViewModelDelegates?
    private let validator = CreatePostValidation()
    private let resource = CreatePostResource()
    
    func createNewPostWith(request: CreatePostRequest){
        
        let validationResult = validator.validate(request: request)
        
        if validationResult.success{
            
            resource.createPostWith(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didCreateNewPostResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didCreateNewPostResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didCreateNewPostResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didCreateNewPost(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didCreateNewPostResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
