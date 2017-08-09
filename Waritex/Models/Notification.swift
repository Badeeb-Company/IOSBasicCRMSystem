//
//  Notification.swift
//  WaritexPromotions
//
//  Created by Mostafa on 7/8/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation


class Notification: BaseModel {
    var title : String = ""
    var desc : String  = ""
    var created_at : String = ""
    
    override func bindModel(_ dict: NSDictionary) {
        super.bindModel(dict)
        
        if let _title = dict.object(forKey: "title") as? String{
            self.title = _title
        }
        
        if let _desc = dict.object(forKey: "description") as? String {
            
            self.desc = _desc

        }
        
        if let date = dict.object(forKey: "created_at") as? String {
            self.created_at = date
        }
    }
}
