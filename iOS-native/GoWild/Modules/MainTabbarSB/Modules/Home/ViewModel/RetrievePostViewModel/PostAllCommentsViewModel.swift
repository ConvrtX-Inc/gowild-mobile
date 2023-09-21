//
//  PostAllCommentsViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol PostAllCommentsViewModelDelegates: BaseProtocol{
    func didGetAllCommentsOnPost(response: PostAllCommentsResponse)
    func didGetAllCommentsOnPostResponseWith(error: String)
}

final class PostAllCommentsViewModel{
    
    weak var delegates : PostAllCommentsViewModelDelegates?
    private let validator = PostAllCommentsValidation()
    private let resource = PostAllCommentsResource()
    
    func getAllCommentWith(request: PostAllCommentsRequest){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.didGetAllCommentWith(request: request) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetAllCommentsOnPostResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetAllCommentsOnPostResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetAllCommentsOnPostResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetAllCommentsOnPost(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetAllCommentsOnPostResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
