//
//  ChatModels.swift
//  GoWild
//
//  Created by SA - Haider Ali on 27/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import MessageKit
import InputBarAccessoryView

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Media: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}
