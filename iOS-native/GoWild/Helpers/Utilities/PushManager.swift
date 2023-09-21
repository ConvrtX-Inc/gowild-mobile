//
//  PushManager.swift
//  GoWild
//
//  Created by SA - Haider Ali on 27/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import UIKit

enum PushTypes: String {
    case inbox = "inbox"
    case gowild = "gowild"
    case routes = "routes"
    case support = "support"
    case treasureChest = "treasureChest"
    case notification = "notification"
    case approve = "approve"
    case push = "push"
}

struct PushManager {
    
    static let router = RootRouter()
    
    static private func markNotificationAsSeen(notificationId: String) {
       /* ConnectionManager.markNotificationAsSeen(notificationId, completion: { response in
            switch response.result {
            case .success(let user):
                UserManager.currentUser = user
            case .failure:
                break
            }
        }) */
    }
    
    static private func openMail(payload: [AnyHashable: Any], changeTabTo idx: Int) {
        /* guard let mailId = payload["mail_id"] as? String, !mailId.isEmpty else {
            //Mail id was not present, so lets open the notification tab instead
            _ = RouterManager.changeSelectedTabTo(index: idx)
            return
        }
        RouterManager.openMail(id: mailId, animated: false) */
    }
    
    static func handlePush(_ payload: [AnyHashable: Any], appWasActive: Bool) {
        guard let aps = payload["aps"] as? [String: Any],
              let type = aps["type"] as? String,
              let alert = aps["alert"] as? [String: Any],
              let title = alert["title"] as? String,
              let body = alert["body"] as? String
        else { return }
        
        if !UserManager.shared.isLoggedIn(){
            return
        }
        
        let pushType = PushTypes(rawValue: type)
        Constants.printLogs("Push payload: \(payload), type: \(type), Body: \(body)")
        
        //Actively setting app badge count if present
        (payload["aps"] as? NSDictionary)
            .flatMap { $0["badge"] as? Int }
            .map { UIApplication.shared.applicationIconBadgeNumber = ($0) }
        
        if appWasActive{
            if let totalNotificationCount = payload["badge"] as? String{
                if let badge = Int(totalNotificationCount){
                    UIApplication.shared.applicationIconBadgeNumber = badge
                }
            }
        }else{
            if let badge = aps["badge"] as? Int{
                UIApplication.shared.applicationIconBadgeNumber = badge
            }
        }
        
        if appWasActive{
            return
        }
        
        (payload["notification_id"] as? String).map(markNotificationAsSeen)
        if !appWasActive{
            handleNotificationTaped(type: pushType ?? .notification, title: title, body: body)
        }
    }
    
    private static func handleNotificationTaped(type: PushTypes,title: String,body: String) {
        switch type {
        case .inbox:
            if let controller = R.storyboard.messageSB.messagesVC() {
                router.open(viewController: controller)
            }
        case .gowild:
            if let controller = R.storyboard.homeSB.homeVC() {
                router.open(viewController: controller)
            }
        case .routes:
            if let controller = R.storyboard.myTrailsSB.myTrailsVC() {
                router.open(viewController: controller)
            }
        case .support:
            if let controller = R.storyboard.supportSB.supportVC() {
                router.open(viewController: controller)
            }
        case .treasureChest:
            if let controller = R.storyboard.mapSB.treasureWildVC() {
                router.open(viewController: controller)
            }
        case .notification:
            if let controller = R.storyboard.profileSB.notificationsVC() {
                router.open(viewController: controller)
            }
        case .approve:
            if let controller = R.storyboard.myTrailsSB.myTrailsVC() {
                router.open(viewController: controller)
            }
        case .push:
            if let controller = R.storyboard.homeSB.homeVC() {
                router.open(viewController: controller)
            }
        }
    }
    
}


extension String{
    static let pushType: String = "pushType"
}
