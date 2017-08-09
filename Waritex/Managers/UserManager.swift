//
//  UserManager.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/30/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import FirebaseMessaging

class UserManager{
    
    func initializeUser(){
        let defaults = UserDefaults.standard
        if let _ = defaults.value(forKey: "notification") as? Bool {
            return
        }else{
            defaults.setValue(true, forKey: "notification")
            defaults.synchronize()
        }
    }
    func isToBeArabic() -> Bool {
        if let languages = UserDefaults.standard.value(forKey: "TempAppleLanguages") as? [String]{
            if languages.count >= 1 {
                return languages[0] == "ar"
            }
        }
        return isArabic()
    }
    
    func setToBeArabic(arabic : Bool) {
        var value : [String] = ["en"]
        if arabic {
            value = ["ar"]
        }
        UserDefaults.standard.set(value, forKey: "TempAppleLanguages")
        UserDefaults.standard.synchronize()
    }
    func isIsArabic() -> Bool {
        if let languages = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if languages.count >= 1 {
                return languages[0] == "ar"
            }
        }
        return true
    }
    
    static let testEnglish = false
    func isArabic() -> Bool {
        return isIsArabic()
    }
    func storeNotifToken(token:String) -> Void {
        let wrapper:KeychainItemWrapper = self.getNotifTokenWrapper()
        wrapper.setObject("fcm_token", forKey: kSecAttrAccount)
        wrapper.setObject(token, forKey: kSecValueData)
        wrapper.setObject(kSecAttrAccessibleAlways, forKey:kSecAttrAccessible)
        if getNotificationValue() {
            registerNotification()
        }
    }
    
    func readNotifToken() -> String {
        let wrapper:KeychainItemWrapper = self.getNotifTokenWrapper()
        let token:String = wrapper.object(forKey: kSecValueData) as! String
        return token
    }
    func getNotifTokenWrapper() -> KeychainItemWrapper{
        let keyChain:KeychainItemWrapper = KeychainItemWrapper(identifier: "fcm_token", accessGroup: nil)
        return keyChain
    }
    func setNotification(value : Bool){
        let defaults = UserDefaults.standard
        defaults.setValue(value, forKey: "notification")
        defaults.synchronize()
        if value {
            registerNotification()
        }else{
            unregisterNotification()
        }
        
    }
    static let not_topic = "/topics/waritex"
    func registerNotification(){
        // TODO Add user to topic

        FIRMessaging.messaging().subscribe(toTopic: UserManager.not_topic)
        
    }
    func unregisterNotification(){
        // TODO Remove user from topic
        FIRMessaging.messaging().unsubscribe(fromTopic: UserManager.not_topic)
    }
    func getNotificationValue () -> Bool {
        let defaults = UserDefaults.standard

        if let not = defaults.value(forKey: "notification") as? Bool {
            return not
        }

        return true
    }
    
    
}
