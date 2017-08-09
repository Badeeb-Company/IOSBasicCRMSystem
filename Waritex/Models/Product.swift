//
//  Product.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/7/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
class Product: BaseModel {
    
    var photoUrl : String = ""
    var name : String = ""
    var desc : String = ""
    override func bindModel(_ dict: NSDictionary) {
        super.bindModel(dict)
        
        if let url = dict.object(forKey: "url") as? String {
            self.photoUrl = url
        }
        
        if let nm = dict.object(forKey: "name") as? String{
            self.name = nm
        }else{
            self.name = ""
        }
        
        if let des = dict.object(forKey: "description") as? String {
            self.desc = des
        }else{
            self.desc = ""
        }
    }
}
