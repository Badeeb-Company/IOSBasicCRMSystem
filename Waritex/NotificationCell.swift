//
//  NotificationCell.swift
//  WaritexPromotions
//
//  Created by Mostafa on 7/8/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class NotificationCell: UITableViewCell {
    var notification : Notification?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    func bindCell (notification: Notification){
        self.notification = notification
        self.titleLabel.text = notification.title
        self.descLabel.text = notification.desc
        self.dateLabel.text = notification.created_at
    }
    static func heightForLabel(text: String, width: CGFloat) -> CGFloat
    {
        let frame = CGRect(x: 0, y: 0, width: width, height:  CGFloat.greatestFiniteMagnitude)
        let label:UILabel = UILabel(frame: frame)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        
        return label.frame.height + 59
    }

}
