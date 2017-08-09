//
//  PromotionDetail.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/7/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation

class PromotionDetail: BaseModel {
    
    var title : String = ""
    var desc : String = ""
    var dueDate : String = ""
    var photos : [Photo] = []
    
    override func bindModel(_ dict: NSDictionary) {
        super.bindModel(dict)
        
        if let _title = dict.value(forKey: "title") as? String {
            self.title = _title
        }
        
        if let _desc = dict.value(forKey: "description") as? String {
            self.desc = _desc
        }
        
        if let date = dict.value(forKey: "due_date") as? String {
            self.dueDate = date
        }
        
        if let photos = dict.value(forKey: "photos") as? [NSDictionary] {
            for photoDict in photos {
                let photo = Photo()
                photo.bindModel(photoDict)
                self.photos.append(photo)
            }
        }
    }
}
