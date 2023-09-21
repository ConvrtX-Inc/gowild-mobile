//
//  CamerARVC.swift
//  GoWild
//
//  Created by APPLE on 11/14/22.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class CamerARVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    
    
    //MARK: - PROPERTIES -
    
    
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    //MARK: - METHODS -
    
    @objc func setText(){
        
    }
    
    func setUI(){
        
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    //MARK: - ACTIONS -

    

}
