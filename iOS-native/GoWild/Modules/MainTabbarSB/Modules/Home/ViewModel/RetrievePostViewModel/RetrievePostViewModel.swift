//
//  RetrievePostViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol RetrievePostViewModelDelegates: BaseProtocol{
    func didRetrievePosts(response: RetrievePostResponse)
    func didRetrievePostsResponseWith(error: String)
}

final class RetrievePostViewModel{
    
    weak var delegates : RetrievePostViewModelDelegates?
    private let validator = RetrievePostValidation()
    private let resource = RetrievePostResource()
    
    func retrievePosts(){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.retrievePosts { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didRetrievePostsResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didRetrievePostsResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didRetrievePostsResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didRetrievePosts(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didRetrievePostsResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
