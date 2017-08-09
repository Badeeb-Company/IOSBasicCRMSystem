//
//  Vendor.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/7/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation

class Vendor: BaseModel {
    var type : String = ""
    var name : String = ""
    var phoneNumber : String = ""
    var mobileNumber : String = ""
    var governorate : String = ""
    var address : String = ""
    var lng : Float = 0
    var lat : Float = 0
    
    
    override func bindModel(_ dict: NSDictionary) {
        super.bindModel(dict)
        
        if let _type = dict.value(forKey: "type") as? String {
            self.type = _type
        }
        
        if let _name = dict.value(forKey: "name") as? String {
            self.name = _name
        }
        
        if let phone = dict.value(forKey: "phone_number") as? String {
            self.phoneNumber = phone
        }
        
        if let mobile = dict.value(forKey: "mobile_number") as? String {
            self.mobileNumber = mobile
        }
        
        if let gover = dict.value(forKey: "governorate") as? String {
            self.governorate = gover
        }
        
        if let addr = dict.value(forKey: "address") as? String {
            self.address = addr
        }
        
        if let longitude = dict.value(forKey: "lng") as? Float {
            self.lng = longitude
        }
        
        if let latitude = dict.value(forKey: "lat") as? Float {
            self.lat = latitude
        }
    }
}
