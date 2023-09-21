//
//  AlertControllers.swift
//  GoWild
//
//  Created by SA - Haider Ali on 24/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import UIKit

final class AlertControllers{
    
    private init() {}
    
    static func showAlert(inVC: UIViewController,title: String = GoWildStrings.alert(), message: String,ok: @escaping () -> Void = {}){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let done = UIAlertAction(title: GoWildStrings.ok(), style: .default) { _ in
            ok()
        }
        alertController.addAction(done)
        inVC.present(alertController, animated: true)
    }
    
    static func showAlertMessage(inVC: UIViewController,title: String, message: String,ok: @escaping () -> Void,cancel: @escaping () -> Void){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let done = UIAlertAction(title: GoWildStrings.ok(), style: .default) { _ in
            ok()
        }
        let cancel = UIAlertAction(title: GoWildStrings.cancel(), style: .cancel) { _ in
            cancel()
        }
        alertController.addAction(done)
        alertController.addAction(cancel)
        inVC.present(alertController, animated: true)
    }
    
}


