//
//  Promotion.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/7/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation

class Promotion: BaseModel {
    var title : String = ""
    var dueDate : String  = ""
    var photoUrl : String = ""
    var imageHeight : CGFloat = #imageLiteral(resourceName: "imgPlaceholder").size.height
    override func bindModel(_ dict: NSDictionary) {
        super.bindModel(dict)
        if let _title = dict.object(forKey: "title") as? String {
            self.title = _title
        }
        
        if let _date = dict.object(forKey: "due_date") as? String {
            self.dueDate = _date
        }
        
        if let url = dict.object(forKey: "main_photo") as? String {
            self.photoUrl = url
        }
    }
}
