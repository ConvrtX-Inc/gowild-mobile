//
//  TreasureWildContainerVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 21/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import UIKit

class TreasureWildContainerVC: UIPageViewController {
    
    lazy var subViewControllers: [UIViewController] = {
        return [
            R.storyboard.mapSB.treasureWildUpCommingVC() ?? UIViewController(),
            R.storyboard.mapSB.treasureWildOnGoingVC() ?? UIViewController()
        ]
    }()
    
    var setSelectedTab: ((_ index: Int, _ value: Any?) -> Void)?
    
    var currentIndex: Int{
        guard let vc = viewControllers?.first else{ return 0}
        return subViewControllers.firstIndex(of: vc) ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    private func setupView () {
        self.delegate = self
        self.dataSource = self
        
        self.isPagingEnabled = false
        
//        NotificationCenter.default.addObserver(self, selector: #selector(setNewsTab), name: .newsTab, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(setEventsTab), name: .eventsTab, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(setTicketsTab), name: .ticketsTab, object: nil)
        
    }
    
    @objc func setUpcommingTab() {
        setViewContollerAtIndex(index: 0)
        self.setSelectedTab?(0, nil)
    }
    
    @objc func setOnGoingTab() {
        setViewContollerAtIndex(index: 1)
        self.setSelectedTab?(1, nil)
    }
    
    func setViewContollerAtIndex (index: Int, animate: Bool = true) {
        setViewControllers([subViewControllers[index]], direction: .forward, animated: animate, completion: nil)
    }
    
    
}


extension TreasureWildContainerVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentIndex = subViewControllers.firstIndex(of: viewController){
            if currentIndex <= 0 {
                return nil
            }else{
                return subViewControllers[currentIndex - 1]
            }
        } else{
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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed{
            self.setSelectedTab?(self.currentIndex - 1 , nil)
        }
        
    }
    
}
