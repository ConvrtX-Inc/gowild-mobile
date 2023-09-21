//
//  DeeplinkHandler.swift
//  GoWild
//
//  Copyright © Go_Wild. All rights reserved.
//

import Foundation

struct DeeplinkHandler {

    enum Path: String {
        case route
        case post
    }

    // MARK: Methods

    func handleDeeplink(with url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let path = getPath(from: components) else {
                return
        }

        switch path {
        case .route:
            handleRoute(with: components,path: .route)
        case .post:
            handlePost(with: components,path: .post)
        }
    }

    // MARK: Private methods

    private func getPath(from components: URLComponents) -> Path? {
        return Path(rawValue: components.host ?? "")
    }

    private func handleRoute(with components: URLComponents,path: Path) {
        if let queryItems = components.queryItems,
           !queryItems.isEmpty,
           let routeID = queryItems.first?.value{
            let routeObj: [String: Any] = [._path: path.rawValue,._id: routeID]
            Utils.shared.setDeepLink(state: true)
            Utils.shared.setDeepLink(obj: routeObj)
        }
    }
    
    private func handlePost(with components: URLComponents,path: Path) {
        if let queryItems = components.queryItems,
           !queryItems.isEmpty,
           let postID = queryItems.first?.value{
            let postObj: [String: Any] = [._path: path.rawValue,._id: postID]
            Utils.shared.setDeepLink(state: true)
            Utils.shared.setDeepLink(obj: postObj)
        }
    }
    
}


struct DeepLinks{
    private init() {}
    static let shared = DeepLinks()
    let post: String = "com.goWild://post?id="
    let route: String = "com.goWild://route?id="
}
