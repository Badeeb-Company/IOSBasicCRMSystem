//
//  ServerConstants.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/16/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation

class ServerConstants{
static let serverURL = "https://safe-bastion-53717.herokuapp.com/api/v1/"
static let promotionsURL = "\(serverURL)promotions.json"
static let productsURL = "\(serverURL)products.json"
static let promotionsDetailsURL = "\(serverURL)promotions/"
static let promotionVendorsURL = "\(serverURL)promotions/"
static let companyInfoURL = "\(serverURL)company_info.json"
static let notificationsURL = "\(serverURL)notifications.json"
static let HeaderColor = UIColor.init(red: 183.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1.0)
static let TextColor = UIColor.init(red: 29.0/255.0, green: 9.0/255.0, blue: 132.0/255.0, alpha: 1.0)
static let BackgroundColor = UIColor.init(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)

static var companyInfo : CompanyInfo = CompanyInfo()

}
