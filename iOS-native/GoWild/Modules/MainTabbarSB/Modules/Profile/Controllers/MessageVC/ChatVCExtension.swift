//
//  ChatVCExtension.swift
//  GoWild
//
//  Created by SA - Haider Ali on 27/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import MessageKit
import InputBarAccessoryView
import Kingfisher

extension ChatVC: MessageCellDelegate {
    
    func setupMessageView() {
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        scrollsToLastItemOnKeyboardBeginsEditing = true // default false
//        maintainPositionOnKeyboardFrameChanged = true // default false
        
        self.view.backgroundColor = AppColor.appChatBgColor()
        messagesCollectionView.backgroundColor = AppColor.appChatBgColor()
        messagesCollectionView.keyboardDismissMode = .onDrag
        
        let attachmentButton = UIButton()
        attachmentButton.addTarget(self, action: #selector(didTapAttachmentBtn), for: .touchUpInside)
        attachmentButton.setImage(R.image.ic_chat_attachment_image(), for: .normal)
        
        let cameraButton = UIButton()
        cameraButton.addTarget(self, action: #selector(didTapCameraBtn), for: .touchUpInside)
        cameraButton.setImage(R.image.ic_chat_camera_image(), for: .normal)
        
        let spacerView = UIView()
        
        messageInputBar.inputTextView.textColor = AppColor.appWhiteColor()
        messageInputBar.backgroundView.backgroundColor = AppColor.appInputBarColor()
        messageInputBar.leftStackView.addArrangedSubview(attachmentButton)
        messageInputBar.leftStackView.addArrangedSubview(cameraButton)
        messageInputBar.leftStackView.addArrangedSubview(spacerView)
        
        messageInputBar.setLeftStackViewWidthConstant(to: 74, animated: false)
        messageInputBar.leftStackView.alignment = .center
        messageInputBar.rightStackView.alignment = .center
        messageInputBar.sendButton.setTitle(nil, for: .normal)
        messageInputBar.sendButton.setImage(R.image.ic_chat_send_btn_image(), for: .normal)
        
        messageInputBar.inputTextView.placeholder = GoWildStrings.sendMessage()
        messageInputBar.delegate = self
        messagesCollectionView.refreshControl = refreshControl
        messagesCollectionView.showsVerticalScrollIndicator = false
    }
    
    func setScrollViewTopHeightToAutomatic(){
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
        } else {
            UIScrollView.appearance().automaticallyAdjustsScrollIndicatorInsets = false
        }
    }
    
    func setScrollViewTopHeightToNever(){
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            UIScrollView.appearance().automaticallyAdjustsScrollIndicatorInsets = false
        }
    }
    
}

///
// MARK:- MESSGAES DATASOURCE -
///

extension ChatVC: MessagesDataSource {
    func currentSender() -> SenderType {
        return currentUser
    }
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return arrayOfMessages.count
    }
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        if indexPath.section != arrayOfMessages.count {
            return arrayOfMessages[indexPath.section]
        } else {
            return arrayOfMessages[indexPath.section - 1]
        }
    }
}


extension ChatVC: MessagesDisplayDelegate, MessagesLayoutDelegate {
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        return message.sender.senderId == currentUser.senderId ? .bubbleTail(.bottomRight, .pointedEdge) : .bubbleTail(.bottomLeft, .pointedEdge)
    }
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        if message.sender.senderId == self.currentUser.senderId {
            if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(UserManager.shared.picture ?? "")"){
                avatarView.kf.indicatorType = .activity
                avatarView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
            }
        } else {
            if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(self.userPicture)"){
                avatarView.kf.indicatorType = .activity
                avatarView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
            }
        }
        
    }
    
    func configureMediaMessageImageView(_ imageView: UIImageView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        switch message.kind {
        case .photo(let photoItem):
            
            /// if we don't have a url, that means it's simply a pending message
            guard let url = photoItem.url else {
                imageView.kf.indicator?.startAnimatingView()
                return
            }
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
//            imageView.setupImageViewer()
        default:
            break
        }
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        let message = arrayOfMessages[indexPath.section]
        return message.sender.senderId == currentUser.senderId ? AppColor.appWhiteColor() ?? .white : AppColor.appLightGreenBgColor() ?? .appLightGreenColor
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        let message = arrayOfMessages[indexPath.section]
        return message.sender.senderId == currentUser.senderId ? AppColor.bgBlackColor() ?? .black : AppColor.appWhiteColor() ?? .white
    }
    
    
    func isLastSectionVisible() -> Bool {
        
        guard !arrayOfMessages.isEmpty else { return false }
        
        let lastIndexPath = IndexPath(item: 0, section: arrayOfMessages.count - 1)
        
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    func insertMessage(_ message: Message) {
        self.arrayOfMessages.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            if self.arrayOfMessages.count >= 2 {
                messagesCollectionView.reloadSections([self.arrayOfMessages.count - 2])
            }
        }, completion: { [weak self] _ in
            self?.messagesCollectionView.scrollToLastItem(animated: true)
        })
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
//        self.isMessageSelected = !self.isMessageSelected
        guard let indexPath = messagesCollectionView.indexPath(for: cell),
              let message = messagesCollectionView.messagesDataSource?.messageForItem(at: indexPath, in: messagesCollectionView) else {
            print("Failed to identify message when audio cell receive tap gesture")
            return
        }
        switch message.kind{
        case .text(let attachment):
            if attachment.contains(find: .pdf){
                if let url = URL(string: attachment){
                    UIApplication.shared.open(url)
                }
            }
        default:
            break
        }
    }
    func didTapImage(in cell: MessageCollectionViewCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell),
              let message = messagesCollectionView.messagesDataSource?.messageForItem(at: indexPath, in: messagesCollectionView) else {
            print("Failed to identify message when audio cell receive tap gesture")
            return
        }
        switch message.kind {
        case .photo(let photoItem):
            
            if let photoUrl = photoItem.url {
                LightBoxVC.shared.showImage(with: photoUrl, inVC: self)
            }
            
        default:
            break
        }
    }
    
    func detectorAttributes(for detector: DetectorType, and message: MessageType, at indexPath: IndexPath) -> [NSAttributedString.Key: Any] {
          switch detector {
          case .hashtag, .mention: return [.foregroundColor: AppColor.appYellowColor() ?? UIColor.appYellowColor]
          default: return MessageLabel.defaultAttributes
          }
      }
      

    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: Fonts.getSourceSansProRegularOf(size: 12) ?? .systemFont(ofSize: 12, weight: .medium),NSAttributedString.Key.foregroundColor: AppColor.textDarkGrayColor() ?? .darkGray])
    }
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if indexPath.section == 0 {
            return 0
        }else{
            return 0
        }
    }
    
}


// MARK:- INPUT ACCECCORY VIEW -
///

extension ChatVC: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        // Append a new Message
        if SocketHelper.shared.isConnected() == 1{
            let request = SendMessageToSocketRequest(user_id: UserManager.shared.id ?? "", message: text)
            self.sendTextMessageToSocket(request: request)
            inputBar.inputTextView.text = ""
        }else{
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
        }
    }
    
}
