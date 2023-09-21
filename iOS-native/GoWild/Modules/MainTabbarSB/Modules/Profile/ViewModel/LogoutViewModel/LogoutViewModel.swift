//
//  LogoutViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 29/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol LogoutViewModelDelegates: BaseProtocol{
    func didLogoutUser(response: LogoutResponse)
    func didLogoutUserResponseWith(error: String)
}

final class LogoutViewModel{
    
    weak var delegates : LogoutViewModelDelegates?
    private let resource = LogoutResource()
    
    func logoutUser(){
        
        if !Network.isAvailable{
            self.delegates?.didLogoutUserResponseWith(error: GoWildStrings.oopsNetworkError())
            return
        }
            
        resource.didLogoutUser { response, statusCode in
            
            DispatchQueue.main.async {
                
                guard let statusCode = statusCode else { return }
                
                switch statusCode{
                    
                case 401:
                    self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                    
                case 500...599:
                    self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                default:
                    guard let result = response else {
                        self.delegates?.didLogoutUserResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                        return
                    }
                    if result.errors != nil{
                        if let errorDict = result.errors?.first{
                            self.delegates?.didLogoutUserResponseWith(error: errorDict.convertBackendErrorToString())
                        }else{
                            self.delegates?.didLogoutUserResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                        }
                    }else{
                        self.delegates?.didLogoutUser(response: result)
                    }
                }
                
            }
        }
        
    }
    
}
