//
//  SettingsCell.swift
//  Waritex
//
//  Created by Mostafa on 7/19/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class SettingsCell: UITableViewCell {
    var info : CompanyInfo?
    var indexPath : IndexPath = IndexPath()
    
    func bind(info : CompanyInfo, indexPath : IndexPath) {
        self.selectionStyle = .none
        self.info = info
        self.indexPath = indexPath
    }
}
