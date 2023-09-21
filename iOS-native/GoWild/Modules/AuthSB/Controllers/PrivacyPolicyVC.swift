//
//  PrivacyPolicyVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 22/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

enum PrivacyPolicyVCMode{
    case termsOfConditions
    case privacyPolicy
}

class PrivacyPolicyVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var guideLinesLbl: UILabel!
    
    //MARK: - PROPERTIES -
    
    private var guideLinesViewModel = GuideLineViewModel()
    
    var mode : PrivacyPolicyVCMode = {
        let mode : PrivacyPolicyVCMode = .termsOfConditions
        return mode
    }()
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        guideLinesViewModel.delegates = self
        getPrivacyPolicy()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

    //MARK: - METHODS -
    
    @objc func setText(){
        if self.mode == .termsOfConditions{
            titleLbl.text = GoWildStrings.termsAndConditions()
        }else{
            titleLbl.text = GoWildStrings.privacyPolicy()
        }
    }
    
    func setUI(){
        self.backView.backgroundColor = AppColor.appBgColor()
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        guideLinesLbl.font = Fonts.getSourceSansProRegularOf(size: 16)
        guideLinesLbl.textColor = AppColor.appWhiteColor()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func getPrivacyPolicy(){
        LoaderView.shared.showSpiner(inVC: self)
        if self.mode == .termsOfConditions{
            self.guideLinesViewModel.getAdminGuideLinesOf(type: .termsAndConditions)
        }else{
            self.guideLinesViewModel.getAdminGuideLinesOf(type: .termsAndConditions)
        }
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }
    

}

//MARK: - EXTENSION FOR GUIDLINES VIEWMODEL DELEGATES -

extension PrivacyPolicyVC: GuideLineViewModelDelegates{
    
    func didGetAdminGuideLines(response: GuideLineResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let eWavier = response.data{
            DispatchQueue.main.async { [weak self] in
                self?.guideLinesLbl.text = eWavier.description
            }
        }
    }
    
    func didGetAdminGuideLinesResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error?.first ?? ""){
            RouterNavigation.shared.logoutUserIsUnAutenticated()
        }
    }
    
}
