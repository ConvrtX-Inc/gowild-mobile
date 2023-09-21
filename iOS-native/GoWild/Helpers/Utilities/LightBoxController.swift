//
//  LightBoxController.swift
//  GoWild
//
//  Created by SA - Haider Ali on 06/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import UIKit
import Lightbox

struct LightBoxVC{
    
    private init() {}
    static let shared = LightBoxVC()
    
    func showImage(with url: String,inVC: UIViewController){
        if let imageURL = URL(string: url){
            let image = LightboxImage(imageURL: imageURL)
            let controller = LightboxController(images: [image])
            controller.dynamicBackground = true
            inVC.present(controller, animated: true,completion: nil)
        }
    }
    
    func showImage(with url: URL,inVC: UIViewController){
        let image = LightboxImage(imageURL: url)
        let controller = LightboxController(images: [image])
        controller.dynamicBackground = true
        inVC.present(controller, animated: true,completion: nil)
    }
    
}

extension String{
    static let pdf: String = "pdf"
    static let png: String = "png"
}
