//
//  MyTrailsVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 14/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class MyTrailsVC: UIViewController {

    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var savedView: UIView!
    @IBOutlet weak var savedLbl: UILabel!
    @IBOutlet weak var savedBtn: UIButton!
    @IBOutlet weak var createdView: UIView!
    @IBOutlet weak var createdLbl: UILabel!
    @IBOutlet weak var createdBtn: UIButton!
    
    //MARK: - PROPERTIES -
    
    weak var myTrailsTabs: MyTrailsContainerVC?
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        setMyTrailsSavedRouteVC()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** MyTrailsVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.myTrailsTitle().capitalized
        savedLbl.text = GoWildStrings.saveRoutes()
        createdLbl.text = GoWildStrings.createdRoute()
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        savedBtnSelected()
        setMyTrailsTabs()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func setMyTrailsTabs(){
        guard let myTrailsTabs = self.children.first as? MyTrailsContainerVC else {return}
        self.myTrailsTabs = myTrailsTabs
        myTrailsTabs.setSelectedTab = { [weak self] (index, value) in
            switch index{
            case 0:
                self?.setMyTrailsSavedRouteVC()
            case 1:
                self?.setMyTrailsCreatedRouteVC()
            default:
                Constants.printLogs("........")
            }
        }
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func didTapCreateBtn(_ sender: UIButton){
        sender.showAnimation {
            guard let newRouteVC = R.storyboard.myTrailsSB.myTrailsCreateNewRouteVC() else {return}
            newRouteVC.mode = .newRoute
            self.push(controller: newRouteVC, hideBar: true, animated: true)
        }
    }
    
    @IBAction func didTapSegmentBtn(_ sender: UIButton) {
        if sender.tag == 0{
            self.savedBtnSelected()
            self.setMyTrailsSavedRouteVC()
        }else{
            self.createdBtnSelected()
            self.setMyTrailsCreatedRouteVC()
        }
    }

}

//MARK: - EXTENSION FOR CUSTOM SEGMENT BUTTONS -

extension MyTrailsVC{
    
    private func savedBtnSelected(){
        savedBtn.isSelected = true
        savedView.backgroundColor = AppColor.textLightOrangeColor()
        savedLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        savedLbl.textColor = AppColor.appWhiteColor()
        createdBtn.isSelected = false
        createdView.backgroundColor = AppColor.appOrangeBgColor()
        createdLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        createdLbl.textColor = AppColor.textLightOrangeColor()
    }
    
    private func createdBtnSelected(){
        savedBtn.isSelected = false
        savedView.backgroundColor = AppColor.appOrangeBgColor()
        savedLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        savedLbl.textColor = AppColor.textLightOrangeColor()
        createdBtn.isSelected = true
        createdView.backgroundColor = AppColor.textLightOrangeColor()
        createdLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        createdLbl.textColor = AppColor.appWhiteColor()
    }
    
}


//MARK: - EXTENSION FOR NAVIGATION FUNC -

extension MyTrailsVC {
    
    func setMyTrailsSavedRouteVC() {
        myTrailsTabs?.setViewContollerAtIndex(index: 0, animate: false)
    }
    
    func setMyTrailsCreatedRouteVC() {
        myTrailsTabs?.setViewContollerAtIndex(index: 1, animate: false)
    }
    
}
