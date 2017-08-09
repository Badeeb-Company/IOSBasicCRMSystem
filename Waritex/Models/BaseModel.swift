//
//  BaseModel.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/7/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation

class BaseModel{
    var id : Int = -1
    
    func bindModel(_ dict: NSDictionary){
        if let _id = dict.object(forKey: "id") as? Int {
            self.id = _id
        }
    }
    
}
