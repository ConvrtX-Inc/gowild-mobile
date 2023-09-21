//
//  LoadingButton.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import UIKit

class LoadingButton: UIButton {
    private var originalButtonText: String?
    private var originalButtonImage: UIImage?
    private var originalButtonImageSelected: UIImage?
    
    private var originalButtonBackgroundImage: UIImage?
    
    var activityIndicator: UIActivityIndicatorView!
    var isAnimating : Bool = false
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        originalButtonImage = self.image(for: .normal)
        self.originalButtonBackgroundImage = self.backgroundImage(for: .normal)
        originalButtonImageSelected = self.image(for: .selected)
        self.setTitle("", for: .normal)
        self.setImage(nil, for: .normal)
        self.setImage(nil, for: .selected)
        self.setBackgroundImage(nil, for: .normal)
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.setTitle(self.originalButtonText, for: .normal)
            self.setImage(self.originalButtonImage, for: .normal)
            self.setImage(self.originalButtonImage, for: .selected)
            self.setBackgroundImage(self.originalButtonBackgroundImage, for: .normal)
            if (self.activityIndicator != nil) {
                self.activityIndicator.stopAnimating()
            }
            self.isAnimating = false
        }
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .lightGray
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
        self.isAnimating = true
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
