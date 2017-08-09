//
//  SettingsButtonCell.swift
//  Waritex
//
//  Created by Mostafa on 7/23/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class SettingsButtonCell: SettingsCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func bind(info: CompanyInfo, indexPath: IndexPath) {
        super.bind(info: info, indexPath: indexPath)
        let isArabic = UserManager().isArabic()
        if indexPath.row == 7 {
            iconView.image = #imageLiteral(resourceName: "iconRate")
            if isArabic {
                self.titleLabel.text = "تقييم التطبيق:"
            }else{
                self.titleLabel.text = "Rate App:"
            }
        }else{
            iconView.image = #imageLiteral(resourceName: "iconShare")
            if isArabic {
                self.titleLabel.text = "مشاركة التطبيق:"
            }else{
                self.titleLabel.text = "Share App:"
            }
        }
        
    }
}
