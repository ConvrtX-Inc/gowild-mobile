//
//  RetrieveOnePostViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 13/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol RetrieveOnePostViewModelDelegates: BaseProtocol{
    func didRetrieveOnePost(response: RetrieveOnePostResponse)
    func didRetrieveOnePostResponseWith(error: String)
}

final class RetrieveOnePostViewModel{
    
    weak var delegates : RetrieveOnePostViewModelDelegates?
    private let validator = RetrieveOnePostValidation()
    private let resource = RetrieveOnePostResource()
    
    func retrieveOnePostWith(postID: String){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.didGetPostWith(postID: postID) { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didRetrieveOnePostResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didRetrieveOnePostResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didRetrieveOnePostResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didRetrieveOnePost(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didRetrieveOnePostResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
