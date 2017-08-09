//
//  Meta.swift
//  Hippy
//
//  Created by Mostafa on 5/14/17.
//  Copyright © 2017 Inova. All rights reserved.
//

import Foundation
import Alamofire

class Meta{
    var status:String = "200";
    var message:String = "";
    var error_message: String = "";
    var success = true
static let invalid_response = "Failed"
    func parseMeta(dictionary: NSDictionary){
        if let metaDict = dictionary.value(forKey: "meta") as? NSDictionary {
        if let status = metaDict.value(forKey: "status") as? Int {
            self.status = "\(status)"
        }else{
            self.status = "401"
            self.error_message = Meta.invalid_response
            success = false
            return
        }
        if let message = metaDict.value(forKey: "message") as? String {
            self.message = message
            if self.status != "200" {
                if let error = dictionary.object(forKey: "errors") as? String {
                    self.error_message = error
                }else{
                    self.error_message = self.message
                    
                }
                self.success = false
            }
        }else{
            self.status = "401"
            self.error_message = Meta.invalid_response
            self.success = false
            }
        }else{
            self.status = "401"
            self.error_message = Meta.invalid_response
            self.success = false
        }
       
    }
}
