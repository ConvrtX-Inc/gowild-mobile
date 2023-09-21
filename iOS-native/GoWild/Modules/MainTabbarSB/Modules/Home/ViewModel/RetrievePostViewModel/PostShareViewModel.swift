//
//  PostShareViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol PostShareViewModelDelegates: BaseProtocol{
    func didSharePost(response: PostShareResponse)
    func didSharePostResponseWith(error: String,at index: Int)
}

final class PostShareViewModel{
    
    weak var delegates : PostShareViewModelDelegates?
    private let validator = PostShareValidation()
    private let resource = PostShareResource()
    
    func sharePost(with postId: String,at index: Int){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.sharePostWith(postId: postId) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didSharePostResponseWith(error: GoWildStrings.oopsSomethingWentWrong(), at: index)
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didSharePostResponseWith(error: errorDict.convertBackendErrorToString(), at: index)
                            }else{
                                self.delegates?.didSharePostResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong(), at: index)
                            }
                        }else{
                            self.delegates?.didSharePost(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didSharePostResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong(), at: index)
        }
        
    }
    
}
