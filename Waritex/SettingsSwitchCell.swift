//
//  SettingsSwitchCell.swift
//  Waritex
//
//  Created by Mostafa on 7/23/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit
protocol SettingsSwitchCellDelegate {
    func switchValueDidChange(value: Bool, indexPath: IndexPath)
}
class SettingsSwitchCell: SettingsCell {
    var delegate : SettingsSwitchCellDelegate?
    
    @IBOutlet weak var cellSwitch: UISwitch!
    @IBOutlet weak var cellTitleLabel: UILabel!
    override func bind(info: CompanyInfo, indexPath: IndexPath) {
        super.bind(info: info, indexPath: indexPath)
        if UserManager().isArabic(){
            if indexPath.row == 5 {
                self.cellTitleLabel.text = "السماح بالإشعارات:"
            }else{
                self.cellTitleLabel.text = "اللغة الإنجليزية"
            }
        }else{
            if indexPath.row == 5 {
                self.cellTitleLabel.text = "Allow Notification"
            }else{
                self.cellTitleLabel.text = "English Language"
            }
        }
        
        if indexPath.row == 5 {
            self.cellSwitch.isOn = UserManager().getNotificationValue()
        }else{
            self.cellSwitch.isOn = !UserManager().isToBeArabic()
        }
    }
    
    @IBAction func switchValueDidChage(_ sender: UISwitch) {
        self.delegate?.switchValueDidChange(value: sender.isOn, indexPath: indexPath)
    }
    
}
