//
//  Utils.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import UIKit

final class Utils{
    
    private init() {}
    static let shared = Utils()
    
    func getDateObjForString(_ date: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en")
        if let dateObj = dateFormatter.date(from: date){
            return dateObj
        }
        return Date()
    }
    
    func getDateObjFromStringUsingChatGPT(_ str: String) -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en")
        formatter.timeZone = .current
        let date = formatter.date(from: str)
        return date
    }
    
    func getUserDateOfBirth(dob: String) -> String{
        let birthDate = Utils.shared.getDateObjForString(dob.UTCToLocal(incomingFormat: .UTCFormat, outGoingFormat: .LocalFormat))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .userDateOfBirthFormat
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: birthDate)
    }
    
    func getSupportTicket(date: String) -> String{
        let birthDate = Utils.shared.getDateObjForString(date.UTCToLocal(incomingFormat: .UTCFormat, outGoingFormat: .LocalFormat))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .supportTicketDate
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: birthDate)
    }
    
    func getPostFeedDate(utcDate: String) -> String{
        let postDate = Utils.shared.getDateObjForString(utcDate.UTCToLocal(incomingFormat: .UTCFormat, outGoingFormat: .LocalFormat))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .postFeedDateFormat
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: postDate)
    }
    
    func getTreasureWildFeedDate(utcDate: String) -> String{
        let postDate = Utils.shared.getDateObjForString(utcDate.UTCToLocal(incomingFormat: .UTCFormat, outGoingFormat: .LocalFormat))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .TreasureWildFeedDateFormat
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: postDate)
    }
    
    func getTreasureWildFeedTime(utcDate: String) -> String{
        let postDate = Utils.shared.getDateObjForString(utcDate.UTCToLocal(incomingFormat: .UTCFormat, outGoingFormat: .LocalFormat))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .TreasureWildFeedTimeFormat
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: postDate)
    }
    
    func getTreasureWildFeedEventStartDate(utcDate: String) -> (String, String){
        let postDate = Utils.shared.getDateObjForString(utcDate.UTCToLocal(incomingFormat: .UTCFormat, outGoingFormat: .LocalFormat))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .TreasureWildEventStartDayDateFormat
        dateFormatter.timeZone = TimeZone.current
        let day = dateFormatter.string(from: postDate)
        dateFormatter.dateFormat = .TreasureWildEventStartMonthDateFormat
        let month = dateFormatter.string(from: postDate)
        return (day, month)
    }
    
    func getNotificationDate(utcDate: String) -> (String){
        let notificationDate = Utils.shared.getDateObjForString(utcDate.UTCToLocal(incomingFormat: .UTCFormat, outGoingFormat: .LocalFormat))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .notificationDateFormat
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: notificationDate)
    }
    
}

/// For Deep Link State
extension Utils{
    
    func setDeepLink(state: Bool){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(state, forKey: "DeepLinkState")
    }
    
    func getDeepLinkState() -> Bool{
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: "DeepLinkState") as? Bool{
            return value
        }
        return false
    }
    
    func setDeepLink(obj: [String: Any]){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(obj, forKey: "DeepLinkObj")
    }
    
    func getDeepLinkObj() -> [String: Any]?{
        let userDefaults = UserDefaults.standard
        let value = userDefaults.value(forKey: "DeepLinkObj") as? [String: Any]
        return value
    }
    
}
