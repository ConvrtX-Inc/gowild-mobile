//
//  LikePostViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol LikePostViewModelDelegates: BaseProtocol{
    func didLikePosts(response: LikePostResponse)
    func didLikePostsResponseWith(error: String,at index: Int)
}

final class LikePostViewModel{
    
    weak var delegates : LikePostViewModelDelegates?
    private let validator = LikePostValidation()
    private let resource = LikePostResource()
    
    func likePostsWith(request: LikePostRequest,at index: Int){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.didLikePostWith(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didLikePostsResponseWith(error: GoWildStrings.oopsSomethingWentWrong(), at: index)
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didLikePostsResponseWith(error: errorDict.convertBackendErrorToString(), at: index)
                            }else{
                                self.delegates?.didLikePostsResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong(), at: index)
                            }
                        }else{
                            self.delegates?.didLikePosts(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didLikePostsResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong(), at: index)
        }
        
    }
    
}
