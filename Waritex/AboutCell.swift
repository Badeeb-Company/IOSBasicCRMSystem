//
//  AboutCell.swift
//  Waritex
//
//  Created by Mostafa on 7/19/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class AboutCell: SettingsCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    override func bind(info: CompanyInfo, indexPath: IndexPath) {
        super.bind(info: info, indexPath: indexPath)
        self.descriptionLabel.text = info.about
    }
    
    static func hegihtForCell(info : CompanyInfo) -> CGFloat{
        
        let width = UIScreen.main.bounds.width - 16.0
        let frame = CGRect(x: 0, y: 0, width: width, height:  CGFloat.greatestFiniteMagnitude)
        let label:UILabel = UILabel(frame: frame)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = info.about
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        
        return label.frame.height + 47
    }
}
