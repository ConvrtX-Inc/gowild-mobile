//
//  LoaderView.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import UIKit
import PKHUD
import JGProgressHUD

final class LoaderView{
    
    private var vSpinner : UIView?
    private let hud = JGProgressHUD()
    
    private init() {}
    static let shared = LoaderView()
    
    ///JGProgressHUD Loader
//    func showSpiner(inVC: UIViewController) {
//        hud.textLabel.text = GoWildStrings.loading()
//        hud.show(in: inVC.view)
//    }
//
//    func hideLoader(fromVC: UIViewController) {
//        hud.dismiss()
//    }
    
    
     /// PKHUD Loader
    func showSpiner(inVC: UIViewController) {
        let spinner = PKHUDRotatingImageView.init(image: UIImage(named: .loaderImg), title: "", subtitle: "")
        spinner.backgroundColor = .black
        spinner.imageView.contentMode = .scaleAspectFit
        PKHUD.sharedHUD.contentView = spinner
        PKHUD.sharedHUD.dimsBackground  = true
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled  = false
        PKHUD.sharedHUD.show()
    }
    
    func hideLoader(fromVC: UIViewController) {
        PKHUD.sharedHUD.hide(true)
    }
     
    
    
    func showLoader(viewController : UIViewController) {
        let spinnerView = UIView.init(frame: viewController.view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = AppColor.textLightOrangeColor() ?? UIColor.white
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            viewController.view.addSubview(spinnerView)
        }
        
        self.vSpinner = spinnerView
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
}

extension String{
    static let loaderImg : String = "loader_compass"
}
