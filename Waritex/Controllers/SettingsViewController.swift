//
//  SettingsViewController.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/26/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: AbstractViewController,UITableViewDelegate,UITableViewDataSource, SettingsSwitchCellDelegate {
    
//    @IBOutlet weak var whatsappLabel: UILabel!
//    @IBOutlet weak var facebookLabel: UILabel!
//    @IBOutlet weak var websiteLabel: UILabel!
//    @IBOutlet weak var notificationSwitch: UISwitch!
//    @IBOutlet weak var faxLabel: UILabel!
//    @IBOutlet weak var telephoneLabel: UILabel!
//    @IBOutlet weak var companyInfoLabel: UILabel!
//    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navig = self.navigationController?.navigationBar {
            print(navig)
            self.navigationController?.navigationBar.tintColor = UIColor.init(red: 183.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1.0)
            
        }
        
    }
//
//    @IBOutlet weak var lanugageSwitch: UISwitch!
//    
//    @IBAction func notificationValueDidChange(_ sender: UISwitch) {
//        if sender.tag == 0{
//        UserManager().setNotification(value: sender.isOn)
//        }else{
//            // Language
//            UserManager().setToBeArabic(arabic: !sender.isOn)
//        }
//    }
//    func bindData(){
//        let companyInfo = ServerConstants.companyInfo
//        self.companyInfoLabel.text = companyInfo.about
//        self.telephoneLabel.text = companyInfo.telephone
//        self.faxLabel.text = companyInfo.fax
//        self.websiteLabel.text = companyInfo.website
//        self.facebookLabel.text = companyInfo.fb_page
//        self.whatsappLabel.text = companyInfo.whatsappNumber
//        self.notificationSwitch.setOn(UserManager().getNotificationValue(), animated: false)
//    }
//    
//    @IBAction func openWebsite(_ sender: UITapGestureRecognizer) {
//        let companyInfo = ServerConstants.companyInfo
//        
//        if let url = URL.init(string: companyInfo.website){
//            openURL(url: url)
//        }
//    }
//    
//    @IBAction func openFB(_ sender: UITapGestureRecognizer) {
//        let companyInfo = ServerConstants.companyInfo
//        if let url = URL.init(string: companyInfo.fb_page){
//            openURL(url: url)
//        }
//
//    }
//    
    
    func switchValueDidChange(value: Bool, indexPath: IndexPath) {
        if indexPath.row == 5 {
            
            UserManager().setNotification(value: value)
        }else{
            if UserManager().isArabic() {
                self.showToastMessage(messag: "برجاء إعادة فتح التطبيق لتفعيل تغيير اللغة")
            }else{
                self.showToastMessage(messag: "Please restart the app to apply language changes")
            }
            UserManager().setToBeArabic(arabic: !value)
        }
    }
    func openURL(url: URL){
        if #available(iOS 10.0, *) {

            UIApplication.shared.open(url, options: [:], completionHandler: { (result) in
                if result == false {
                    self.showToastMessage(messag: "فشل فتح الموقع")
                }
            })
        }else{
            UIApplication.shared.openURL(url)
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var key = "BannerCell"
        switch indexPath.row {
        case 0:
            key = "BannerCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: key, for: indexPath)
            return cell
            break
        case 1:
            key = "AboutCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: key, for: indexPath) as! AboutCell
            cell.bind(info: ServerConstants.companyInfo, indexPath: indexPath)
            return cell
            break
        case 2,3:
            key = "ContactCell"
            break
        case 4,9:
            key = "SeparatorCell"
            break
        case 5,6:
            key = "SettingSwitchCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: key, for: indexPath) as! SettingsSwitchCell
            cell.bind(info: ServerConstants.companyInfo, indexPath: indexPath)
            cell.delegate = self
            break
        case 7,8:
            key = "SettingButtonCell"
            break
        case 10,11,12:
            key = "FollowCell"
            break
        case 13:
            key = "VersionCell"
            break
        default:
            key = "CompanyCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: key, for: indexPath)
        if let settingsCell = cell as? SettingsCell {
            settingsCell.bind(info: ServerConstants.companyInfo, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return AboutCell.hegihtForCell(info: ServerConstants.companyInfo)
        case 2,3:
            return 40
        case 4,9:
            return 40
        case 5,6:
            return 40
        case 7,8:
            return 40
        case 10,11,12:
            return 65
        case 13:
            return 40
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            self.callNumber(phone: ServerConstants.companyInfo.telephone)
            break
        case 3:
            self.callNumber(phone: ServerConstants.companyInfo.fax)
            break
        case 7:
            self.rateApp()
            break
        case 8:
            self.shareApp()
            break
        case 10:
            if let url = URL.init(string: ServerConstants.companyInfo.website){
                self.openURL(url: url)
            }else{
                if UserManager().isArabic(){
                showToastMessage(messag: "فشل فتح الموقع")
                }else{
                    showToastMessage(messag: "Failed to open website")
                }
            }
            break
        case 11:
            if let url = URL.init(string: ServerConstants.companyInfo.fb_page){
                self.openURL(url: url)
            }else{
                if UserManager().isArabic(){
                    showToastMessage(messag: "فشل فتح الموقع")
                }else{
                    showToastMessage(messag: "Failed to open website")
                }
            }
            break
        case 12:
            UIPasteboard.general.string = ServerConstants.companyInfo.whatsappNumber
            if UserManager().isArabic(){
                showToastMessage(messag: "تم نسخ رقم الواتس")
            }else{
                showToastMessage(messag: "WhatsApp number copied")
            }
            break
        default:
            break
        }
    }
    
    func callNumber(phone: String) {
        //TODO Call Vendor
        guard let number = URL(string: "tel://\(phone)") else{
            print("Cant make phone call")
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(number)
        }
    }

}
