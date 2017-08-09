//
//  CompanyInfo.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/7/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation

class CompanyInfo: BaseModel {
    var about : String = ""
    var telephone : String = ""
    var fax : String = ""
    var website : String = ""
    var jumiaUrl : String = ""
    var fb_page : String = ""
    var whatsappNumber : String = ""
    
    override func bindModel(_ dict: NSDictionary) {
        super.bindModel(dict)
        
        if let _about = dict.object(forKey: "about") as? String {
            
            self.about = _about
        }
        
        if let tele = dict.object(forKey: "telephone") as? String {
            self.telephone = tele
        }
        
        if let _fax = dict.object(forKey: "fax") as? String {
            self.fax = _fax
        }
        
      
    
        if let url = dict.object(forKey: "facebook_page") as? String {
            self.fb_page = url
        }
        
        if let url = dict.object(forKey: "website") as? String {
            

            if !url.contains("http"){
                self.website = "http://\(url)"
            }else{
                self.website = url    
            }
        }
        
        if let whatsapp = dict.object(forKey: "whatsapp_number") as? String {
            self.whatsappNumber = whatsapp
        }
        
        
    }
}
