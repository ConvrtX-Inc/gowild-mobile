//
//  SocketHelper.swift
//  GoWild
//
//  Created by SA - Haider Ali on 02/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import SocketIO

struct SocketHelper{
    
    static let shared = SocketHelper()
    
    init() {
        manager = SocketManager(socketURL: URL(string: Constants.socketIOURL)!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        socket.connect()
    }
    
    let manager: SocketManager
    let socket: SocketIOClient
    
    private var onlineNamespace = "/"
    private var iam_online = "iam_online"
    private var connect_users = "connect_users"
    private var joinedRoom = "joinedRoom"
    private var msgToServer = "msgToServer"
    private var msgToClient = "msgToClient"
    private var msgToUser = "msgToUser"
    private var msgSupport = "msgSupport"
    private var supportUsers = "support_users"
    private var triggerApi = "triggerApi"
    private var listenTrigger = "listenTrigger"
    
    private var subscribeClient = "subscribeClient"
    private var unSubscribeClient = "unsubscribeClient"
    
    func establishConnection() {
        socket.on(clientEvent: .connect) { (_, _) in
            Constants.printLogs("==== Socket Connected ====")
            self.subscribe()
        }
        socket.on(clientEvent: .disconnect) { (_, _) in
            Constants.printLogs("====================\nsocket disconnected\n====================")
        }
    }
    
    func subscribe() {
        if socket.status != .connected { return }
        let payload: [Any] = []
        
        //socket.emit("sdjsdf", with: ["name": "hgyb"])
        
//        if UserManager.shared.isLoggedIn(){
//            socket.emit(iam_online, with: [["user_id": UserManager.shared.id ?? ""]])
//        }
        
        socket.emitWithAck(subscribeClient, payload).timingOut(after: 10) { (data) in
            Constants.printLogs("====================\nSocket Data:\n\(data)\n====================")
        }
        socket.on(onlineNamespace) { (data, _) in
            Constants.printLogs("====================\nSocket Data: \(self.onlineNamespace)\n\(data)\n====================")
        }
    }
    
    func unSubscribe() {
        if socket.status != .connected { return }
        socket.emitWithAck(unSubscribeClient).timingOut(after: 10) { _ in
            Constants.printLogs("====================\nSocket unsubcribed\n====================")
        }
    }
    
    func emitUserOnlineStatus(){
        if UserManager.shared.isLoggedIn(){
            socket.emit(iam_online, with: [["user_id": UserManager.shared.id ?? ""]])
        }
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func closeConnection() {
        socket.removeAllHandlers()
        socket.disconnect()
    }
    
    func isConnected() -> Int {
        switch socket.status {
        case .connected:
            return 1
        case .connecting:
            return 2
        default:
            return 0
        }
    }
    
    func emitUsersInChat(sender_id: String,receiver_id: String){
        socket.emit(self.connect_users, with: [["sender_id" : sender_id,"receiver_id" : receiver_id,"token" : UserManager.shared.getAccessToken()]])
    }
    
    func getRoomID(completion: @escaping (_ roomID: String?) -> Void){
        socket.on(self.joinedRoom) { (data, _) in
            if !data.isEmpty{
                for obj in data{
                    if let roomID = obj as? String{
                        completion(roomID)
                    }else{
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func sendTextMessageToSocket(request: SendMessageToSocketRequest){
        do{
            var params = try request.asDictionary()
            params["token"] = UserManager.shared.getAccessToken()
            socket.emit(self.msgToServer, with: [params])
        }catch{
            Constants.printLogs(error.localizedDescription)
        }
    }
    
    func sendAttachmentsToSocket(attachment: MessagesList){
        do{
            var params = try attachment.asDictionary()
            params["token"] = UserManager.shared.getAccessToken()
            socket.emit(self.triggerApi, with: [params])
        }catch{
            Constants.printLogs(error.localizedDescription)
        }
    }
    
    func receiveMessageFromClient(completion: @escaping (_ message: ReceiveMessageFromClientResponse?) -> Void){
        socket.on(self.msgToClient) { (data, _) in
            if !data.isEmpty{
                for obj in data{
                    if let msgObj = obj as? [String: Any]{
                        let attachment = msgObj["attachment"] as? String
                        let id = msgObj["id"] as? String
                        let message = msgObj["message"] as? String
                        let userID = msgObj["user_id"] as? String
                        let messageObj = ReceiveMessageFromClientResponse(id: id ?? "", user_id: userID ?? "", message: message ?? "", attachment: attachment ?? "")
                        completion(messageObj)
                    }else{
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func receiveMessageFromTriggerApi(completion: @escaping (_ message: MessagesList?) -> Void){
        socket.on(self.listenTrigger) { (data, _) in
            if !data.isEmpty{
                for obj in data{
                    if let msgObj = obj as? [String: Any]{
                        let id = msgObj["id"] as? String
                        let roomID = msgObj["room_id"] as? String
                        let userID = msgObj["user_id"] as? String
                        let message = msgObj["message"] as? String
                        let attachment = msgObj["attachment"] as? String
                        let messageObj = MessagesList(id: id, roomID: roomID, userID: userID, message: message, attachment: attachment)
                        completion(messageObj)
                    }else{
                        completion(nil)
                    }
                }
            }
        }
    }
    
    
    //MARK: - Support Messages -
    
    func emitTicketIdInSupport(ticketID: String){
        socket.emit(self.supportUsers, with: [["ticket_id" : ticketID]])
    }
    
    func emitMsgFromUserToSupport(msg: MsgSendFromUserToSupport){
        do{
            let msgObj = try msg.asDictionary()
            Constants.printLogs("\n\(msgObj)\n")
            self.socket.emit(self.msgToUser, with: [msgObj])
        }catch{
            Constants.printLogs(error.localizedDescription)
        }
    }
    
    func listenSupportMessage(completion: @escaping (_ msg: SupportTicketMessage?) -> Void){
        self.socket.on(self.msgSupport) { (data, _) in
            if !data.isEmpty{
                for obj in data{
                    if let supportMsgObj = obj as? [String: Any]{
                        if let supportMsgData = supportMsgObj["data"] as? [String: Any]{
                            if let id = supportMsgData["id"] as? String,
                               let ticketID = supportMsgData["ticket_id"] as? String,
                               let role = supportMsgData["role"] as? String,
                               let userID = supportMsgData["user_id"] as? String,
                               let message = supportMsgData["message"] as? String,
                               let createdDate = supportMsgData["createdDate"] as? String,
                               let updatedDate = supportMsgData["updatedDate"] as? String{
                                
                                var attachments : [String] = []
                                if let attachment = supportMsgData["attachment"] as? [String],
                                   !attachment.isEmpty{
                                    for obj in attachment{
                                        attachments.append(obj)
                                    }
                                }
                                let msgObj = SupportTicketMessage(id: id, createdDate: createdDate, ticketID: ticketID, role: role, message: message, updatedDate: updatedDate, userID: userID, attachment: attachments)
                                completion(msgObj)
                                
                            }
                        }else{
                            completion(nil)
                        }
                    }else{
                        completion(nil)
                    }
                }
                    
            }
        }
    }
    
}


struct SendMessageToSocketRequest: Codable{
    let user_id : String
    let message : String
}

struct SendMessageToSocketAttachment: Codable{
    let _extension : String
    let base64 : String
    enum CodingKeys: String, CodingKey{
        case _extension = "extension"
        case base64
    }
}

struct ReceiveMessageFromClientResponse: Codable{
    let id : String
    let user_id : String
    let message : String
    let attachment : String
}


struct MsgSendFromUserToSupport: Codable{
    
    let ticketID : String
    let message : String
    let token : String
    let userID : String
    
    enum CodingKeys:  String, CodingKey{
        case ticketID = "ticket_id"
        case userID = "user_id"
        case message, token
    }
    
}

struct SupportMsgObj: Codable{
    
    let ticketID : String
    let message : String
    let token : String
    let attachment : String
    
    enum CodingKeys:  String, CodingKey{
        case ticketID = "ticket_id"
        case message, token, attachment
    }
    
}
