//
//  BaseVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    
    var popRecognizer: InteractivePopRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        implementSwipeToPop()
        setInteractiveRecognizer()
        // Do any additional setup after loading the view.
    }
    
    @objc func popToDismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func implementSwipeToPop() {
        
        let gestureRec = UISwipeGestureRecognizer(target: self, action: #selector(popToDismiss))
        gestureRec.direction = .right
        self.view.addGestureRecognizer(gestureRec)
        
    }
    
    private func setInteractiveRecognizer() {
        guard let controller = navigationController else { return }
        popRecognizer = InteractivePopRecognizer(controller: controller)
        controller.interactivePopGestureRecognizer?.delegate = popRecognizer
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

}
