//
//  NotificationsVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 14/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

class NotificationsVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var notificationsTableView: UITableView!{
        didSet{
            notificationsTableView.delegate = self
            notificationsTableView.dataSource = self
            notificationsTableView.register(R.nib.notificationCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    private var notificationListVM = NotificationListViewModel()
    private var arrayOfNotifications : [NotificationList] = []
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        notificationListVM.delegates = self
        getAllNotifications()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** NotificationsVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.notifications().capitalized
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func getAllNotifications(){
        LoaderView.shared.showSpiner(inVC: self)
        self.notificationListVM.getAllNotifications()
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }

}

//MARK: - EXTENSION FOR NOTIFICATION LIST VIEWMODEL DELEGATES -

extension NotificationsVC: NotificationListViewModelDelegates{
    
    func didGetAllNotifications(response: NotificationListResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let notificationList = response.data{
            if !notificationList.isEmpty{
                for list in notificationList {
                    self.arrayOfNotifications.append(list)
                }
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else {return}
            weakSelf.notificationsTableView.reloadData()
        }
    }
    
    func didGetAllNotificationsResponseWith(error: String) {
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

//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension NotificationsVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureNotificationsCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = self.arrayOfNotifications[indexPath.row].type,
              let pushType = PushTypes(rawValue: type) else {return}
        self.didTapOnNotificationOf(type: pushType)
    }
    
}

//MARK: - EXTESNION FOR CELL METHODS -

extension NotificationsVC{
    
    private func configureNotificationsCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.notificationsTableView.dequeueReusableCell(withIdentifier: .notificationCell, for: indexPath) as! NotificationCell
      
        let notification = self.arrayOfNotifications[indexPath.row]
        cell.userImageView.image = R.image.goWildIcon()
        cell.titleLbl.text = notification.title ?? GoWildStrings.goWildHistory()
        cell.descriptionLbl.text = notification.notificationMsg
        cell.dateLbl.text = Utils.shared.getNotificationDate(utcDate: notification.createdDate ?? "")
        
        return cell
    }
    
}


//MARK: - EXTENSION FOR NOTIFICATION TAP -

extension NotificationsVC{
    
    private func didTapOnNotificationOf(type: PushTypes){
        switch type {
        case .inbox:
            if let controller = R.storyboard.messageSB.messagesVC() {
                self.push(controller: controller, hideBar: true, animated: true)
            }
        case .gowild:
            Constants.printLogs("GoWild")
        case .routes:
            if let controller = R.storyboard.myTrailsSB.myTrailsVC() {
                self.push(controller: controller, hideBar: true, animated: true)
            }
        case .support:
            if let controller = R.storyboard.supportSB.supportVC() {
                self.push(controller: controller, hideBar: true, animated: true)
            }
        case .treasureChest:
            if let controller = R.storyboard.mapSB.treasureWildVC() {
                self.push(controller: controller, hideBar: true, animated: true)
            }
        case .notification:
            Constants.printLogs("Notification")
        case .approve:
            if let controller = R.storyboard.myTrailsSB.myTrailsVC() {
                self.push(controller: controller, hideBar: true, animated: true)
            }
        case .push:
            Constants.printLogs("Push")
        }
    }
    
}
