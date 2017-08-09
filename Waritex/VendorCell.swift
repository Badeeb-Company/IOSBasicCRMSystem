//
//  VendorCell.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/25/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

protocol VendorCellDelegate {
    func callVendor(vendor: Vendor)
}
class VendorCell: UITableViewCell {
    var delegate : VendorCellDelegate?
    var vendor : Vendor?
    
    @IBOutlet weak var phoneNumberCell: UILabel!
    @IBOutlet weak var vendorGovLabel: UILabel!
    @IBOutlet weak var vendorAddrlabel: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    func bindCell(vendor: Vendor){
        self.vendor = vendor
        self.vendorGovLabel.text = vendor.governorate
        self.vendorAddrlabel.text = vendor.address
        self.vendorNameLabel.text = vendor.name
        self.phoneNumberCell.text = vendor.phoneNumber
    }
    @IBAction func callVendor(_ sender: UIButton) {
        if let vend = vendor {
            self.delegate?.callVendor(vendor: vend)
        }
    }
}
