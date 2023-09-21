//
//  AppDelegate.swift
//  GoWild
//
//  Copyright © Go_Wild. All rights reserved.
//

import UIKit
import netfox
import IQKeyboardManagerSwift
import FBSDKCoreKit
import FirebaseCore
import GoogleSignIn
import FirebaseMessaging
import GoogleMaps
import GooglePlaces
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate{

    var window: UIWindow?
    lazy private var router = RootRouter()
    lazy private var deeplinkHandler = DeeplinkHandler()
    lazy private var notificationsHandler = NotificationsHandler()
    
    var fcm_Tokken: String = ""
    var deviceToken: String = ""

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        //Firebase Integration...
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        // Notifications
        notificationsHandler.configure()
        configureNotification(application: application)

        // App structure
        RouterNavigation.shared.loadSplashNavigation()
        
        // Load User
        UserManager.shared.loadUser()
        
        //Netfox
        NFX.sharedInstance().start()
        
        //IQ Keyboard manager
        IQKeyboardManager.shared.enable = true
        
        //FBSDKLogin
        ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
        
        Messaging.messaging().token { token, error in
            if let error = error {
                Constants.printLogs("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                Constants.printLogs("FCM registration token: \(token)")
                self.fcm_Tokken  = token
            }
        }
        
        //Socket
        if UserManager.shared.isLoggedIn(){
            SocketHelper.shared.establishConnection()
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        //Google Maps...
        GMSServices.provideAPIKey(Constants.googleMapAPIKey)
        GMSPlacesClient.provideAPIKey(Constants.googleMapAPIKey)
        
        //LocationManager...
        LocationManager.shared.startUpdatingLocation()
        
        //Setup TableView Section Height...
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0.0
        } else {
            // Fallback on earlier versions
        }
        
        //Setup ScrollView Top Extra Spacing While Scrolling...
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            UIScrollView.appearance().automaticallyAdjustsScrollIndicatorInsets = false
        }

        return true
    }
    
    //MARK: - OPEN URL FOR FBLogin...
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        var flag : Bool = false
        
        self.deeplinkHandler.handleDeeplink(with: url)
        
        if ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        ){
            //URL SCHEME FACEBOOK
            flag = ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
            
        }else{
            
            //URL SCHEME GOOGLE
            flag = GIDSignIn.sharedInstance.handle(url)
        }
        
        return flag
        
    }

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // To enable full universal link functionality add and configure the associated domain capability
        // https://developer.apple.com/library/content/documentation/General/Conceptual/AppSearch/UniversalLinks.html
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL {
            deeplinkHandler.handleDeeplink(with: url)
        }
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App Become InActive")
        if SocketHelper.shared.isConnected() != 1 {
            SocketHelper.shared.establishConnection()
        }
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // To enable full remote notifications functionality you should first register the device with your api service
        //https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/
        notificationsHandler.handleRemoteNotification(with: userInfo)
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func configureNotification(application: UIApplication){
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {granted, error in
                    if granted {
                        print("Permession Granted for Notification")
                    } else {
                        print("Permession Not granter Notification")
                    }
                })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        //  print("FCM token \(fcmToken ?? "NIL")")
        guard let tokken = fcmToken else {return}
        fcm_Tokken = tokken
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        self.fcm_Tokken = fcmToken
        // ConnectionManager.updateFcmTokken(fcmToken: fcmToken) { (resp) in }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        self.deviceToken = token
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // print("Notifications not available in simulator \(error)")
    }
    
    // This method will be called when app received push notifications in foreground
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("=== Push Received === *** APP ACTIVE *** ")
        PushManager.handlePush(notification.request.content.userInfo,
                               appWasActive: true)
        completionHandler(.badge)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        print("=== Push Received === *** APP BACKGROUND ***")
        PushManager.handlePush(userInfo,
                               appWasActive: UIApplication.shared.applicationState == .active)
    }
    
}
