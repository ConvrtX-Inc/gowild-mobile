//
//  FBLoginViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit

protocol FBLoginViewModelDelegates: BaseProtocol{
    func didGetFBLogin(response: FBLoginBaseResponse)
    func didGetFBLoginResponseWith(error: String)
}

final class FBLoginViewModel{
    
    weak var delegates : FBLoginViewModelDelegates?
    private let resource = FBLoginResource()
    
    func loginWithFacebook(_ viewController: UIViewController){
        
        if !Network.isAvailable{
            self.delegates?.didGetFBLoginResponseWith(error: GoWildStrings.oopsNetworkError())
            return
        }
        
        let fbLoginManager = LoginManager()
        fbLoginManager.logOut()
        
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: viewController){ result, error in
            
            if error == nil{
                
                if AccessToken.current != nil {
                    
                    GraphRequest(graphPath: "me").start{ connection, result, error in
                        
                        if let result = result {
                            
                            if let data = result as? [String: Any],
                               let id = data["id"] as? String,
                               let name = data["name"] as? String,
                               let token = AccessToken.current?.tokenString
                            {
                                Constants.printLogs("FB ID: \(id)\nName: \(name)\nAccessToken: \(token)")
                                let request = FBLoginRequest(accessToken: token, deviceType: .iOS)
                                self.loginUserWith(request: request)
                                
                            } else {
                                self.delegates?.didGetFBLoginResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            }
                            
                        }else{
                            self.delegates?.didGetFBLoginResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                        }
                            
                    }
                    
                }else{
                    self.delegates?.didGetFBLoginResponseWith(error: GoWildStrings.fbLoginCancelError())
                }
                
            }else{
                self.delegates?.didGetFBLoginResponseWith(error: error?.localizedDescription ?? GoWildStrings.oopsSomethingWentWrong())
            }
            
        }
        
    }
    
    private func loginUserWith(request: FBLoginRequest){
        
        resource.didFBLoginWith(request: request) { response, statusCode in
            
            DispatchQueue.main.async {
                
                guard let statusCode = statusCode else { return }
                
                switch statusCode{
                case 500...599:
                    self.delegates?.didReceiveServer(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                default:
                    guard let result = response else {
                        self.delegates?.didGetFBLoginResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                        return
                    }
                    if result.errors != nil{
                        if let errorDict = result.errors?.first{
                            self.delegates?.didGetFBLoginResponseWith(error: errorDict.convertBackendErrorToString())
                        }else{
                            self.delegates?.didGetFBLoginResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                        }
                    }else{
                        self.delegates?.didGetFBLogin(response: result)
                    }
                }
            }
        }
    }
    
}
