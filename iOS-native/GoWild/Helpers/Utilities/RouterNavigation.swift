//
//  RouterNavigation.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import UIKit

final class RouterNavigation{
    
    private let rootRouter = RootRouter()
    static let shared = RouterNavigation()
    private init () {}
    
    /// Load Custom Splash...
    func loadSplashNavigation(){
        guard let customSplashNavigationVC = R.storyboard.splashSB.customSplashNavigationVC() else {
            return
        }
        rootRouter.setRootViewController(controller: customSplashNavigationVC, animatedWithOptions: nil)
    }
    
    
    /// Load Authentication Navigation
    func loadAuthNavigation(){
        guard let authNavigationVC = R.storyboard.authSB.authNavigationVC() else {
            return
        }
        rootRouter.setRootViewController(controller: authNavigationVC, animatedWithOptions: nil)
    }
    
    /// Load MainTabbar Navigation
    func loadTabbarNavigation(){
        guard let mainTabbarNavigationVC = R.storyboard.mainTabbarSB.mainTabbarNavigationVC() else {
            return
        }
        rootRouter.setRootViewController(controller: mainTabbarNavigationVC, animatedWithOptions: nil)
    }
    
    ///User Unauthenticated
    func logoutUserIsUnAutenticated(){
        let currentUser = UserManager.shared
        currentUser.deleteUser()
        UserManager.shared.saveUser(user: currentUser)
        UIApplication.shared.applicationIconBadgeNumber = 0
        guard let authNavigationVC = R.storyboard.authSB.authNavigationVC() else {
            return
        }
        rootRouter.setRootViewController(controller: authNavigationVC, animatedWithOptions: nil)
    }
    
}
