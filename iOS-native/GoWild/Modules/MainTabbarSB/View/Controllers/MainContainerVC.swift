//
//  MainContainerVC.swift
//  GoWild
//
//  Created by APPLE on 11/14/22.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class MainContainerVC: UIViewController {

    // MARK: - OUTLETS -
    
    @IBOutlet weak var parentStackView: UIStackView!
    
    // MARK: - TABBAR -
    
    @IBOutlet weak var homeImgView: UIImageView!
    @IBOutlet weak var mapImgView: UIImageView!
    @IBOutlet weak var onlineStoreImgView: UIImageView!
    @IBOutlet weak var profileImgView: UIImageView!
    
    @IBOutlet weak var tabbarView: UIView!
    
    @IBOutlet weak var tabBarHome: UIButton! {
        didSet {
            tabBarHome.tag = 1
        }
    }
    @IBOutlet weak var tabBarMap: UIButton! {
        didSet {
            tabBarMap.tag = 2
        }
    }
    
    @IBOutlet weak var tabBarCameraAR: UIButton! {
        didSet {
            tabBarCameraAR.setBackgroundImage(R.image.ic_tabbar_camera_ar(), for: .normal)
            tabBarCameraAR.setBackgroundImage(R.image.ic_tabbar_camera_ar(), for: .selected)
            tabBarCameraAR.tag = 3
        }
    }
    
    @IBOutlet weak var tabBarOnlineStore: UIButton! {
        didSet {
            tabBarOnlineStore.tag = 4
        }
    }
    
    @IBOutlet weak var tabBarProfile: UIButton! {
        didSet {
            tabBarProfile.tag = 5
        }
    }
 
    @IBOutlet weak var imgContainer: UIView!
    
    // MARK: - PROPERTIES -
    
    var tabbarContainer: MainTabbarPageVC!
    var timer: Timer?
    
    
    // MARK: - LIFE CYCLE -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        observesChanges()
        makeTabbarTwoCornersRounded()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @objc func setupUI () {
        guard let tabs = self.children.first as? MainTabbarPageVC else {return}
        self.tabbarContainer = tabs
//        didTapTabBarItem(tabBarHome)
    }
    
    func observesChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(setupUI), name: .mainTabbarReload, object: nil)
    }
    
    func makeTabbarTwoCornersRounded(){
        tabbarView.layer.cornerRadius = 20
        tabbarView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    // MARK: - FOOTER ACTIONS -
    
    @IBAction func didTapTabBarItem(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            print("Home")
            self.handleHomeTab()
        case 2:
            print("Map")
            self.handleMapTab()
        case 3:
            print("Camera")
            self.handleCameraTab()
        case 4:
            print("Online Store")
            self.handleOnlineStoreTab()
        case 5:
            print("Profile")
            self.handleProfileTab()
        default:
            return
        }
    }
    

}

extension MainContainerVC {
    
    @objc func handleHomeTab() {
        self.homeImgView.tintColor = R.color.textLightOrangeColor()
        self.mapImgView.tintColor = R.color.appWhiteColor()
        self.onlineStoreImgView.tintColor = R.color.appWhiteColor()
        self.profileImgView.tintColor = R.color.appWhiteColor()
        tabbarContainer.setViewContollerAtIndex(index: 0, animate: false)
        
        self.tabBarHome.isSelected = true
        self.tabBarMap.isSelected = false
        self.tabBarCameraAR.isSelected = false
        self.tabBarOnlineStore.isSelected = false
        self.tabBarProfile.isSelected = false
        
    }
    
    @objc func handleMapTab() {
        self.homeImgView.tintColor = R.color.appWhiteColor()
        self.mapImgView.tintColor = R.color.textLightOrangeColor()
        self.onlineStoreImgView.tintColor = R.color.appWhiteColor()
        self.profileImgView.tintColor = R.color.appWhiteColor()
        tabbarContainer.setViewContollerAtIndex(index: 1, animate: false)
        
        self.tabBarHome.isSelected = true
        self.tabBarMap.isSelected = false
        self.tabBarCameraAR.isSelected = false
        self.tabBarOnlineStore.isSelected = false
        self.tabBarProfile.isSelected = false
        
    }
    
    @objc func handleCameraTab() {
        self.homeImgView.tintColor = R.color.appWhiteColor()
        self.mapImgView.tintColor = R.color.appWhiteColor()
        self.onlineStoreImgView.tintColor = R.color.appWhiteColor()
        self.profileImgView.tintColor = R.color.appWhiteColor()
        tabbarContainer.setViewContollerAtIndex(index: 2, animate: false)
        
        self.tabBarHome.isSelected = true
        self.tabBarMap.isSelected = false
        self.tabBarCameraAR.isSelected = false
        self.tabBarOnlineStore.isSelected = false
        self.tabBarProfile.isSelected = false
        
    }
    
    @objc func handleOnlineStoreTab() {
        self.homeImgView.tintColor = R.color.appWhiteColor()
        self.mapImgView.tintColor = R.color.appWhiteColor()
        self.onlineStoreImgView.tintColor = R.color.textLightOrangeColor()
        self.profileImgView.tintColor = R.color.appWhiteColor()
        tabbarContainer.setViewContollerAtIndex(index: 3, animate: false)
        
        self.tabBarHome.isSelected = true
        self.tabBarMap.isSelected = false
        self.tabBarCameraAR.isSelected = false
        self.tabBarOnlineStore.isSelected = false
        self.tabBarProfile.isSelected = false
        
    }
    
    @objc func handleProfileTab() {
        self.homeImgView.tintColor = R.color.appWhiteColor()
        self.mapImgView.tintColor = R.color.appWhiteColor()
        self.onlineStoreImgView.tintColor = R.color.appWhiteColor()
        self.profileImgView.tintColor = R.color.textLightOrangeColor()
        tabbarContainer.setViewContollerAtIndex(index: 4, animate: false)
        
        self.tabBarHome.isSelected = true
        self.tabBarMap.isSelected = false
        self.tabBarCameraAR.isSelected = false
        self.tabBarOnlineStore.isSelected = false
        self.tabBarProfile.isSelected = false
        
    }
    
}
