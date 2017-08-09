//
//  SeparatorCell.swift
//  Waritex
//
//  Created by Mostafa on 7/23/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class SeparatorCell: SettingsCell {
    
    @IBOutlet weak var separatorTitleLabel: UILabel!
    override func bind(info: CompanyInfo, indexPath: IndexPath) {
        super.bind(info: info, indexPath: indexPath)
        if UserManager().isArabic() {
            switch indexPath.row {
            case 4:
                self.separatorTitleLabel.text = "إعدادات التطبيق:"
            default:
                self.separatorTitleLabel.text = "تابعنا:"
            }
        }else{
            switch indexPath.row {
            case 4:
                self.separatorTitleLabel.text = "Application Settings:"
            default:
                self.separatorTitleLabel.text = "Follow us:"
            }
        }
    }
}
