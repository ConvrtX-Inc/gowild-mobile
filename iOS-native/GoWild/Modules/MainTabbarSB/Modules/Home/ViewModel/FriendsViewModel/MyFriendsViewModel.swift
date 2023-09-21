//
//  MyFriendsViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol MyFriendsViewModelDelegates: BaseProtocol{
    func didGetAllMyFriends(response: MyFriendsResponse)
    func didGetAllMyFriendsResponseWith(error: String)
}

final class MyFriendsViewModel{
    
    weak var delegates : MyFriendsViewModelDelegates?
    private let validator = MyFriendsValidation()
    private let resource = MyFriendsResource()
    
    func getAllMyFriends(){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.getAllMyFriends { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetAllMyFriendsResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetAllMyFriendsResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetAllMyFriendsResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetAllMyFriends(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetAllMyFriendsResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
