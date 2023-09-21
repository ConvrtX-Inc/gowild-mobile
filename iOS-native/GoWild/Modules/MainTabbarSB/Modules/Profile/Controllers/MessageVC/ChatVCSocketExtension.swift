//
//  ChatVCSocketExtension.swift
//  GoWild
//
//  Created by SA - Haider Ali on 02/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import UIKit

extension ChatVC{
    
    func connectBothUsers(){
        SocketHelper.shared.emitUsersInChat(sender_id: UserManager.shared.id ?? "", receiver_id: self.userID)
    }
    
    func getRoomID(){
        SocketHelper.shared.getRoomID { [weak self] roomID in
            guard let weakSelf = self else {return}
            if let roomID = roomID{
                weakSelf.roomID = roomID
                weakSelf.getMessages()
            }
        }
    }
    
    func sendTextMessageToSocket(request: SendMessageToSocketRequest){
        SocketHelper.shared.sendTextMessageToSocket(request: request)
    }
    
    func sendAttachmentsToSocket(attachment: MessagesList){
        SocketHelper.shared.sendAttachmentsToSocket(attachment: attachment)
    }
    
    func recieveMessageObj(){
        SocketHelper.shared.receiveMessageFromClient { [weak self] message in
            guard let self = self else {return}
            if let message = message{
                
                if !message.message.isEmpty{
                    
                    let messageObj = Message(sender: message.user_id == UserManager.shared.id ? self.currentUser : self.otherUser, messageId: message.id, sentDate: Date(), kind: .text(message.message))
                    self.arrayOfMessages.append(messageObj)
                    
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.messagesCollectionView.reloadData()
                    self?.messagesCollectionView.scrollToLastItem()
                }
            }
        }
    }
    
    func receiveMessageFromTriggerApi(){
        SocketHelper.shared.receiveMessageFromTriggerApi { [weak self] msgObj in
            guard let self = self else {return}
            if let msgObj = msgObj,
               let attachment = msgObj.attachment{
                if !self.arrayOfMessages.contains(where: {$0.messageId == msgObj.id}){
                    if attachment.contains(find: .pdf){
                        
                        let messageObj = Message(sender: msgObj.userID == UserManager.shared.id ? self.currentUser : self.otherUser, messageId: msgObj.id ?? "", sentDate: Date(), kind: .text("\(UserManager.shared.getBaseURL())\(msgObj.attachment ?? "")"))
                        self.arrayOfMessages.append(messageObj)
                        
                    }else if attachment.contains(find: .png){
                        
                        let messageObj = Message(sender: msgObj.userID ?? "" == UserManager.shared.id ? self.currentUser : self.otherUser, messageId: msgObj.id ?? "", sentDate: Date(), kind: .photo(Media(url: URL(string: "\(UserManager.shared.getBaseURL())\(msgObj.attachment ?? "")"), placeholderImage: R.image.ic_user_placeholder_image() ?? UIImage(), size: self.getPhotoSize())))
                        self.arrayOfMessages.append(messageObj)
                        
                    }
                    DispatchQueue.main.async { [weak self] in
                        self?.messagesCollectionView.reloadData()
                        self?.messagesCollectionView.scrollToLastItem()
                    }
                }
            }
        }
    }
    
    func receiveMessageFromClient(){
        SocketHelper.shared.receiveMessageFromClient { message in
            Constants.printLogs("\(String(describing: message))")
        }
    }
    
    
}


extension ChatVC{
    
    func getPhotoSize() -> CGSize{
        return CGSize(width: (self.view.frame.width - 100), height: (self.view.frame.width - 100))
    }
    
}
