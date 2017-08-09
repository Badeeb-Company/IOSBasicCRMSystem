//
//  ContactCell.swift
//  Waritex
//
//  Created by Mostafa on 7/23/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit


class ContactCell: SettingsCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func bind(info: CompanyInfo, indexPath: IndexPath) {
        super.bind(info: info, indexPath: indexPath)
        // TODO
        if UserManager().isArabic() {
            switch indexPath.row {
            case 2:
                self.titleLabel.text = "التليفون:"
            default:
                self.titleLabel.text = "الفاكس:"
            }
        }else{
            switch indexPath.row {
            case 2:
                self.titleLabel.text = "Tele:"
            default:
                self.titleLabel.text = "Fax:"
            }
        }
        
        switch indexPath.row {
        case 2:
            self.numberLabel.text = info.telephone
        default:
            self.numberLabel.text = info.fax
        }

    }
}
