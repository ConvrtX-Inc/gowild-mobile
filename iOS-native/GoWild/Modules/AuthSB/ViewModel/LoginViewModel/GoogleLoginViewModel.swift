//
//  GoogleLoginViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 28/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

protocol GoogleLoginViewModelDelegates: BaseProtocol{
    func didGetGoogleLogin(response: GoogleLoginResponse)
    func didGetGoogleLoginResponseWith(error: String)
}

final class GoogleLoginViewModel{
    
    weak var delegates : GoogleLoginViewModelDelegates?
    private let resource = GoogleLoginResource()
    
    func loginWithGoogle(_ viewController: UIViewController){
        
        if !Network.isAvailable{
            self.delegates?.didGetGoogleLoginResponseWith(error: GoWildStrings.oopsNetworkError())
            return
        }
        
        let configuration = GIDConfiguration.init(clientID: Constants.googleClientID)
        
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: viewController){ gidUser, error in
         
            if error == nil {
                if let gUser = gidUser {
                    
                    if let emailAddress = gUser.profile?.email,
                       let userName = gUser.profile?.name,
                       let userID = gUser.userID,
                       let idToken = gUser.authentication.idToken{
                        
                        let accessToken = gUser.authentication.accessToken
                        let refreshToken = gUser.authentication.refreshToken
                        
                        Constants.printLogs("Name: \(userName)\nEmail: \(emailAddress)\nuserID: \(userID)\nAccessToken: \(accessToken)\nidToken: \(idToken)\nrefreshToken: \(refreshToken)")
                        
                        let request = GoogleLoginRequest(idToken: "\(idToken)", deviceType: .iOS)
                        self.loginUserWith(request: request)
                        
                    }else{
                        self.delegates?.didGetGoogleLoginResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                    }
        
                }
            } else {
                self.delegates?.didGetGoogleLoginResponseWith(error: GoWildStrings.googleLoginCancelError())
            }
            
        }
        
    }
    
    private func loginUserWith(request: GoogleLoginRequest){
        
        resource.didGoogleLoginWith(request: request) { response, statusCode in
            
            DispatchQueue.main.async {
                
                guard let statusCode = statusCode else { return }
                
                switch statusCode{
                case 500...599:
                    self.delegates?.didReceiveServer(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                default:
                    guard let result = response else {
                        self.delegates?.didGetGoogleLoginResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                        return
                    }
                    if result.errors != nil{
                        if let errorDict = result.errors?.first{
                            self.delegates?.didGetGoogleLoginResponseWith(error: errorDict.convertBackendErrorToString())
                        }else{
                            self.delegates?.didGetGoogleLoginResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                        }
                    }else{
                        self.delegates?.didGetGoogleLogin(response: result)
                    }
                }
            }
        }
    }
    
}
