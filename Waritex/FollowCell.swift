//
//  FollowCell.swift
//  Waritex
//
//  Created by Mostafa on 7/23/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class FollowCell: SettingsCell {
    
    @IBOutlet weak var linkLabel: CustomLabelIdentation!
    
    @IBOutlet weak var iconView: UIImageView!
    
    override func bind(info: CompanyInfo, indexPath: IndexPath) {
        super.bind(info: info, indexPath: indexPath)
        
        switch indexPath.row {
        case 10:
            linkLabel.text = info.website
            iconView.image = #imageLiteral(resourceName: "globe")
            break
        case 11:
            linkLabel.text = info.fb_page
            iconView.image = #imageLiteral(resourceName: "facebookLogo")
            break
        default:
            linkLabel.text = info.whatsappNumber
            iconView.image = #imageLiteral(resourceName: "whatsapp")
            break
        }
    }
}
