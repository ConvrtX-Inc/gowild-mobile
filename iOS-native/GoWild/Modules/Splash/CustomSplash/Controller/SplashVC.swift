//
//  SplashVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var adventureLbl: UILabel!
    
    //MARK: - PROPERTIES -

    
    //MARK: - LIFE CYCLES -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        navigateAfterOneSeconds()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        adventureLbl.text = GoWildStrings.prepareForTheAdventureOfALifetime().capitalized
    }
    
    func setUI() {
        adventureLbl.font = Fonts.getForegenRoughOneFontOf(size: 40)
        adventureLbl.textColor = .white
        self.continueBtn.isHidden = true
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func navigateAfterOneSeconds(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if UserManager.shared.isLoggedIn(){
                RouterNavigation.shared.loadTabbarNavigation()
            }else{
                RouterNavigation.shared.loadAuthNavigation()
            }
        }
    }
        
    //MARK: - ACTIONS -

    @IBAction func didTapContinueBtn(_ sender: UIButton) {
        sender.showAnimation {
            if UserManager.shared.isLoggedIn(){
                RouterNavigation.shared.loadTabbarNavigation()
            }else{
                RouterNavigation.shared.loadAuthNavigation()
            }
        }
    }
    
}
