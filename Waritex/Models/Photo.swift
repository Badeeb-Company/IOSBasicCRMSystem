//
//  Photo.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/7/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation

class Photo: BaseModel {
    var url : String = ""
    
    override func bindModel(_ dict: NSDictionary) {
        super.bindModel(dict)
        
        if let _url = dict.value(forKey: "url") as? String {
            self.url = _url
        }
    }
}
