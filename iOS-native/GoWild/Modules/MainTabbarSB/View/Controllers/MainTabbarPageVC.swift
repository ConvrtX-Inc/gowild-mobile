//
//  MainTabbarPageVC.swift
//  GoWild
//
//  Created by APPLE on 11/14/22.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class MainTabbarPageVC: UIPageViewController {
    
    let homeController = R.storyboard.homeSB.homeVC() ?? UIViewController()
    let mapController = R.storyboard.mapSB.mapVC() ?? UIViewController()
    let cameraController = R.storyboard.cameraSB.camerARVC() ?? UIViewController()
    let onlineStoreController = R.storyboard.onlineStoreSB.onlineStoreVC() ?? UIViewController()
    let profileController = R.storyboard.profileSB.profileVC() ?? UIViewController()
     
     
     lazy var subViewControllers: [UIViewController] = {
         return [
            homeController,
            mapController,
            cameraController,
            onlineStoreController,
            profileController
         ]
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    private func setupView () {
        self.delegate = self
        self.dataSource = self
        setViewContollerAtIndex(index: 0)
        self.isPagingEnabled = false
    }

    func setViewContollerAtIndex (index: Int, animate: Bool = true) {
        setViewControllers([subViewControllers[index]], direction: .forward, animated: animate, completion: nil)
    }

}


extension MainTabbarPageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let currentIndex = subViewControllers.firstIndex(of: viewController) {
            if currentIndex <= 0 {
                return nil
            } else {
                return subViewControllers[currentIndex - 1]
            }
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentIndex = subViewControllers.firstIndex(of: viewController) {
            if currentIndex >= (subViewControllers.count - 1) {
                return nil
            } else {
                return subViewControllers[currentIndex + 1]
            }
        } else {
            return nil
        }
    }
}
