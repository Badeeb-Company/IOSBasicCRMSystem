//
//  StringDateExtention.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/8/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation

extension String {
    /*
        If string is not a date represented, it will return current date
        else it will return date representation
     */
    func getDateRep() -> String {
        // TODO
        
        
        return self
    }
    
    func getDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        /* date_format_you_want_in_string from
         * http://userguide.icu-project.org/formatparse/datetime
         */
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC")
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        return Date()

    }
}
