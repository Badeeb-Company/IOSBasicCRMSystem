//
//  AppDelegate.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/7/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import UserNotifications
import CoreLocation
import Firebase
import FirebaseMessaging
import FirebaseDynamicLinks


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, CLLocationManagerDelegate {

    var window: UIWindow?

    var cllocationManager: CLLocationManager!
/*
     - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
     
     // URL is myapp://discount-scheme/id304
     if ([url.scheme isEqualToString:@"myapp"]) {
     if ([url.relativePath isEqualToString:@"/id304"]) {
     // Handle deep link in app. Do something inside your app.
     [MyApp doSomething];
     }
     }
     
     return YES;
     }

     */
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if let scheme = url.scheme {
            if scheme == "www.waritex.com" {
                print(url.absoluteString)
                let id = url.absoluteString.replacingOccurrences(of: "www.waritex.com://promotion_id=", with: "")
                if let currentVC = AbstractViewController.currentViewController {
                    if let promotionID = Int(id){
                        currentVC.openPromotionDeeplink(promotionID: promotionID)
                    }
                }
                // TODO Open promotion with id = 12
            }
        }
        return true
    }
    @available(iOS 8.0, *)
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        guard let dynamicLinks = FIRDynamicLinks.dynamicLinks() else {
            return false
        }
        
        let handled = dynamicLinks.handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
            // ...
        }
        if let url = userActivity.webpageURL {
            let separator = "http://waritex.com?promotion_id%3D"
            if url.absoluteString.contains(separator){
                let components = url.absoluteString.components(separatedBy: separator)
                if components.count >= 2 {
                    if let id = components[1].components(separatedBy: "&").first {
                        if let promotionID = Int(id){
                            if let currentVC = AbstractViewController.currentViewController {
                                currentVC.openPromotionDeeplink(promotionID: promotionID)
                            }
                        }
                    }
                }
            }
        }
        
        return handled
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        print(identifier)
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Load Company Info
        if let _ = UserDefaults.standard.value(forKey: "AppleLanguagesInitial") as? [String] {
            // Do nothing 
        }else{
            UserDefaults.standard.setValue(["ar"], forKey: "AppleLanguages")
            UserDefaults.standard.setValue(["ar"], forKey: "AppleLanguagesInitial")
            UserDefaults.standard.synchronize()
        }
    
    

        let manager = CompanyManager()
        UserManager().initializeUser()
        manager.getCompanyInfo { (result) in
            if let info = result.result as? CompanyInfo {
                ServerConstants.companyInfo = info
            }
        }
        FIROptions.default().deepLinkURLScheme = "me5zd.app.goo.gl"
        FIRApp.configure()

        Fabric.with([Crashlytics.self])
        if (CLLocationManager.locationServicesEnabled()) {
            cllocationManager = CLLocationManager()
            cllocationManager.delegate = self
            cllocationManager.desiredAccuracy = kCLLocationAccuracyBest
            cllocationManager.allowsBackgroundLocationUpdates = false
            cllocationManager.requestAlwaysAuthorization()
            cllocationManager.startUpdatingLocation()
        }
        if UserManager().getNotificationValue() {
            UserManager().registerNotification()
        }
        let locationPermissionStatus = CLLocationManager.authorizationStatus()
        if(locationPermissionStatus == CLAuthorizationStatus.authorizedAlways
            || locationPermissionStatus == CLAuthorizationStatus.authorizedWhenInUse){
            
            if let location = cllocationManager.location {
                UserDefaults.standard.setValue(location.coordinate.latitude, forKey: "lat")
                UserDefaults.standard.setValue(location.coordinate.longitude, forKey: "long")
                UserDefaults.standard.synchronize()
            }
            
            
        }

        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        let notificationSettings = UIUserNotificationSettings.init(types: notificationTypes, categories: nil)
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil{
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }else{
            application.registerUserNotificationSettings(notificationSettings)
            //            application.registerForRemoteNotifications()
        }
        application.registerForRemoteNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification(notification:)), name: NSNotification.Name.firInstanceIDTokenRefresh, object: nil)

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        if let language = UserDefaults.standard.value(forKey: "TempAppleLanguages") as? [String] {
            UserDefaults.standard.setValue(language, forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }

    }

    
    
    
    func tokenRefreshNotification(notification:NSNotification){
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            UserManager().storeNotifToken(token: refreshedToken)
            registerDeviceToken()
            print("InstanceID token: \(refreshedToken)")
        }
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    func connectToFcm(){
        
        FIRMessaging.messaging().connect { (error) in
            if (error != nil) {
                print("Unable to connect to FCM. \(error)")
            }else{
                print("Connected to FCM.")
            }
        }
    }
    
    func registerDeviceToken(){
        
        let userManager = UserManager()
        userManager.storeNotifToken(token: FIRInstanceID.instanceID().token()!)
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            UserDefaults.standard.setValue(location.coordinate.latitude, forKey: "lat")
            UserDefaults.standard.setValue(location.coordinate.longitude, forKey: "long")
            UserDefaults.standard.synchronize()
        }
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if #available(iOS 10.0, *) {
        }else{
            if (application.applicationState == .active || application.applicationState == .inactive) {
                var message = ""
                if let aps = userInfo["aps"] as? NSDictionary {
                    if let alert = aps["alert"] as? NSDictionary {
                        if let body = alert["body"] as? String,
                            let title = alert["title"]as? String{
                            message = body
                        }
                    }
                }
                
                let localNotification = UILocalNotification.init()
                localNotification.userInfo = userInfo
                localNotification.soundName = UILocalNotificationDefaultSoundName
                localNotification.alertBody = message
                let date = Date()
                localNotification.fireDate = date
                UIApplication.shared.scheduleLocalNotification(localNotification)
            }
        }
        print(userInfo.values)
        if let id = userInfo["group_id"] as? String {
            if let group_id = Int(id) {
                print(group_id)
                // TODO Open the view
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            }
        }
    }
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("Notification")
        print(notification)
        if let userInfo = notification.userInfo {
            print(userInfo.values)
            if let id = userInfo["group_id"] as? String {
                if let group_id = Int(id) {
                    print(group_id)
                    // TODO Open the view
                    let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                }
            }
        }
    }
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
        if let refreshedToken = FIRInstanceID.instanceID().token() {
//            UserManager().storeNotifToken(token: refreshedToken)
            registerDeviceToken()
            print("InstanceID token: \(refreshedToken)")
        }
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
        
    }
    //Called when a notification is delivered to a foreground app.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("User Info = ",notification.request.content.userInfo)
        completionHandler([.alert, .badge, .sound])
    }
    
    //Called to let your app know which action was selected by the user for a given notification.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User Info = ",response.notification.request.content.userInfo)
        completionHandler()
    }

}

