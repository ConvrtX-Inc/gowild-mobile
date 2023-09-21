//
//  RootRouter.swift
//  GoWild
//
//  Copyright © Go_Wild. All rights reserved.
//

import UIKit

class RootRouter {

    /** Replaces root view controller. You can specify the replacment animation type.
     If no animation type is specified, there is no animation */
    func setRootViewController(controller: UIViewController, animatedWithOptions: UIView.AnimationOptions?) {
        guard let window = UIApplication.shared.keyWindow else {
            fatalError("No window in app")
        }
        if let animationOptions = animatedWithOptions, window.rootViewController != nil {
            window.rootViewController = controller
            UIView.transition(with: window, duration: 0.33, options: animationOptions, animations: {
            }, completion: nil)
        } else {
            window.rootViewController = controller
        }
    }

    func loadMainAppStructure() {
        // Customize your app structure here
        let controller = UIViewController()
        controller.view.backgroundColor = UIColor.red
        setRootViewController(controller: controller, animatedWithOptions: nil)
    }
    
    func loadCustomSplash(){
        guard let customSplashNavigationVC = R.storyboard.splashSB.customSplashNavigationVC() else {
            return
        }
        setRootViewController(controller: customSplashNavigationVC, animatedWithOptions: nil)
    }
    
    func loadCustomMainTabbar(){
        guard let customMainTabbarVC = R.storyboard.mainTabbarSB.mainTabbarNavigationVC() else {
            return
        }
        setRootViewController(controller: customMainTabbarVC, animatedWithOptions: nil)
    }
    
    func open(viewController: UIViewController) {
        if UserManager.shared.isLoggedIn() {
            guard let homeBoard = R.storyboard.mainTabbarSB.mainTabbarNavigationVC() else {return}
            setRootViewController(controller: homeBoard, animatedWithOptions: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                guard let window = UIApplication.shared.windows.first else {
                    fatalError("No window in app")
                }
                if let navCntrl = window.rootViewController as? UINavigationController {
                    navCntrl.pushViewController(viewController, animated: false)
                }
            }
        }
    }
    
}
