//
//  Notification+Extension.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let languageChanged = Notification.Name("languageChanged")
    static let mainTabbarReload = Notification.Name("mainTabbarReload")
    static let userUpdated = Notification.Name("userUpdated")
    static let mapStyleChanged = Notification.Name("mapStyleChanged")
    static let deepLinkUrlTap = Notification.Name("deepLinkUrlTap")
    static let pushReceived = Notification.Name("pushReceived")
}

extension String{
    static let _path: String = "path"
    static let _route: String = "route"
    static let _post: String = "post"
    static let _id: String = "id"
}
