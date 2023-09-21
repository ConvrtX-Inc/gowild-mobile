//
//  WebSocketHelper.swift
//  GoWild
//
//  Created by SA - Haider Ali on 17/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

@available(iOS 13.0, *)
class WebSocketHelper: NSObject {
    
    private var webSocket: URLSessionWebSocketTask?
    
    private var socketURL: String = ConfigurationManager.shared.getSocketURLString()
    
//    wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self
    
    override init() {
        super.init()
        createWebSocket()
    }
    
    private func createWebSocket() {
        let urlSession = URLSession(configuration: .default,
                                    delegate: self,
                                    delegateQueue: OperationQueue())
        
        let url = URL(string: socketURL)
        webSocket = urlSession.webSocketTask(with: url!)
        webSocket?.resume()
    }
    
    private func ping() {
        webSocket?.sendPing(pongReceiveHandler: { error in
            if let err = error {
                print("@@@ Ping Error: \(err.localizedDescription) @@@")
            }
        })
    }
    
    func close() {
        webSocket?.cancel(with: .goingAway, reason: "App Killed".data(using: .utf8))
    }
    
    func send(dictionary: [String: Any]? = nil) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
            // self.send(dictionary: dictionary)
            guard let dic = dictionary,
                  let d = self.convertDictionaryToJSON(dic: dic)
            else {return}
            
            if let theJSONText = String(data: d,
                                        encoding: String.Encoding.ascii) {
                print("\n\(theJSONText)")
                
                self.webSocket?.send(.string(theJSONText), completionHandler: { error in
                    if let err = error {
                        print("@@@ Message Sending Error: \(err.localizedDescription)")
                    }
                })
            }
        })
    }
    func receive() {
        webSocket?.receive(completionHandler: { [weak self] results in
            switch results {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("Data Received: \(data)")
                case .string(let message):
                    print("** Message Received: \(message) **")
                @unknown default:
                    break;
                }
            case .failure(let error):
                print("@@@ Received Error: \(error.localizedDescription) @@@")
            }
            self?.receive()
        })
    }
    
}

@available(iOS 13.0, *)
extension WebSocketHelper: URLSessionWebSocketDelegate {
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("***=== Did Connect To Socket ===***")
        ping()
        receive()
        send()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("*** Did Close Connection To Socket ***")
    }
}

extension WebSocketHelper {
    private func convertDictionaryToJSON(dic: [String: Any]) -> Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
            return jsonData
        } catch {
            
        }
        return nil
    }
}
