//
//  PostAddCommentViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol PostAddCommentViewModelDelegates: BaseProtocol{
    func didAddNewCommentOnPost(response: PostAddCommentResponse)
    func didAddNewCommentOnPostResponseWith(error: String)
}

final class PostAddCommentViewModel{
    
    weak var delegates : PostAddCommentViewModelDelegates?
    private let validator = AddCommentValidation()
    private let resource = PostCommentResource()
    
    func addNewCommentWith(request: PostAddCommentRequest){
        
        let validationResult = validator.validateRequest(request: request)
        
        if validationResult.success{
            
            resource.didAddNewCommentOnPostWith(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didAddNewCommentOnPostResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didAddNewCommentOnPostResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didAddNewCommentOnPostResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didAddNewCommentOnPost(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didAddNewCommentOnPostResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
