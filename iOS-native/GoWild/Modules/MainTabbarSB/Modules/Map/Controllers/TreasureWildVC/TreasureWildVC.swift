//
//  TreasureWildVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 18/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class TreasureWildVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var upcomingView: UIView!
    @IBOutlet weak var upcomingLbl: UILabel!
    @IBOutlet weak var upcomingBtn: UIButton!
    @IBOutlet weak var ongoingView: UIView!
    @IBOutlet weak var ongoingLbl: UILabel!
    @IBOutlet weak var ongoingBtn: UIButton!
    
    //MARK: - PROPERTIES -
    
    weak var treasureWildTabs: TreasureWildContainerVC?
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        self.setTreasureWildUpCommingVC()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** TreasureWildVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.treasureMapTitle().capitalized
        upcomingLbl.text = GoWildStrings.upcoming()
        ongoingLbl.text = GoWildStrings.onGoing()
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        upcomingBtnSelected()
        setTreasureWildTabs()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func setTreasureWildTabs(){
        guard let treasureWildTabs = self.children.first as? TreasureWildContainerVC else {return}
        self.treasureWildTabs = treasureWildTabs
        treasureWildTabs.setSelectedTab = { [weak self] (index, value) in
            switch index{
            case 0:
                self?.setTreasureWildUpCommingVC()
            case 1:
                self?.setTreasureWildOnGoingVC()
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
    
    @IBAction func didTapSegmentBtn(_ sender: UIButton) {
        if sender.tag == 0{
            self.upcomingBtnSelected()
            self.setTreasureWildUpCommingVC()
        }else{
            self.ongoingBtnSelected()
            self.setTreasureWildOnGoingVC()
        }
    }

}


//MARK: - EXTENSION FOR CUSTOM SEGMENT BUTTONS -

extension TreasureWildVC{
    
    private func upcomingBtnSelected(){
        upcomingView.backgroundColor = AppColor.textLightOrangeColor()
        upcomingLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        upcomingLbl.textColor = AppColor.appWhiteColor()
        ongoingView.backgroundColor = AppColor.appOrangeBgColor()
        ongoingLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        ongoingLbl.textColor = AppColor.textLightOrangeColor()
    }
    
    private func ongoingBtnSelected(){
        upcomingView.backgroundColor = AppColor.appOrangeBgColor()
        upcomingLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        upcomingLbl.textColor = AppColor.textLightOrangeColor()
        ongoingView.backgroundColor = AppColor.textLightOrangeColor()
        ongoingLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        ongoingLbl.textColor = AppColor.appWhiteColor()
    }
    
    
    
}

//MARK: - EXTENSION FOR NAVIGATION FUNC -

extension TreasureWildVC {
    
    func setTreasureWildUpCommingVC() {
        treasureWildTabs?.setViewContollerAtIndex(index: 0, animate: false)
    }
    
    func setTreasureWildOnGoingVC() {
        treasureWildTabs?.setViewContollerAtIndex(index: 1, animate: false)
    }
    
}

enum TreasureWildCardStatus: String {
  case cancelled
  case pending
  case completed
}

enum TreasureWildRegisterStatus: String {
  case approved
  case processing
  case pending
}
