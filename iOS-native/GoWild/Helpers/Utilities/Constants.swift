//
//  Constants.swift
//  GoWild
//
//  Created by SA - Haider Ali on 15/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import UIKit

typealias ListViewMethods = UITableViewDelegate & UITableViewDataSource
typealias CollectionViewMethods = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

final class Constants{
    
    private init() {}
    
    static let USER_DATA : String = "USER_DATA"
    static let googleClientID: String = ConfigurationManager.shared.getGoogleClientID()
    static let socketIOURL = ConfigurationManager.shared.getSocketURLString()
    static let googleMapAPIKey = ConfigurationManager.shared.getGoogleMapApiKey()
    
    static func printLogs(_ string: String){
        print(string)
    }
    
    static var fcmToken: String{
        return (UIApplication.shared.delegate as! AppDelegate).fcm_Tokken
    }
    
    ///Map Box Polyline Precision...
    static var precision: Double{
        return 1e6
    }
    
    static func getDateFormatter() -> DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    static func userNameWithGreetings() -> String {
      let hour = Calendar.current.component(.hour, from: Date())
      let NEW_DAY = 0
      let NOON = 12
      let SUNSET = 18
      let MIDNIGHT = 24
        var greetingText = "\(GoWildStrings.hello()),\n\(UserManager.shared.firstName ?? "") 🙌" // Default greeting text
      switch hour {
      case NEW_DAY..<NOON:
          greetingText = "\(GoWildStrings.goodMorning()),\n\(UserManager.shared.firstName ?? "") 🙌"
      case NOON..<SUNSET:
          greetingText = "\(GoWildStrings.goodAfternoon()),\n\(UserManager.shared.firstName ?? "") 🙌"
      case SUNSET..<MIDNIGHT:
          greetingText = "\(GoWildStrings.goodEvening()),\n\(UserManager.shared.firstName ?? "") 🙌"
      default:
          _ = "\(GoWildStrings.hello()),\n\(UserManager.shared.firstName ?? "") 🙌"
      }
      
      return greetingText
    }
    
    static var maxFileSize : Double{
        return 5.0
    }
    
    ///GET CURRENT DATE AS STRING ....
    static func getCurrentDateString() -> String{
        let currentData = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = .UTCFormat
        return dateFormatter.string(from: currentData)
    }
    
    ///Get 2 decimal point mile value
    static func getDistannceInMiles(distanceMiles: Double?) -> String{
        return String(format: "%.2f", distanceMiles ?? 0)
    }
    
}
