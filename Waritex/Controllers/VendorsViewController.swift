//
//  VendorsViewController.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/25/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class VendorsViewController: AbstractTabViewController,UITableViewDataSource,VendorCellDelegate {
    
    var promotion : Promotion?
    var promotionDetails : PromotionDetail?
    
    var currentPage : Int = 1

    var vendors : [Vendor] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData(page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData(page: page)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 10))
        view.backgroundColor = UIColor.clear
        return view
    }
    override func loadData(page: Int) {
        
        let manager = PromotionsManager()
        self.showLoading()
        manager.getPromotionVendors(page: page, pageSize: pageSize, promotion: self.promotion!) { (result) in
            if self.page == 1 {
                self.vendors = result.results as! [Vendor]
            }else{
                let newVendors = result.results as! [Vendor]
                self.vendors.append(contentsOf: newVendors)
            }
            self.hideLoading()
            self.tableView.reloadData()
        }
    }
    
    // MARK: Table View Delegate & Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VendorCell", for: indexPath) as! VendorCell
        if indexPath.row < vendors.count {
            let vendor = vendors[indexPath.row]
            cell.bindCell(vendor: vendor)
        }
        cell.delegate = self
        return cell
    }
    var selectedVendor : Vendor?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO Open Promotion
        if indexPath.row < vendors.count {
            let vendor = vendors[indexPath.row]
            self.selectedVendor = vendor
//            self.openPromotion(promotion: promotion)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MapViewController {
            dest.vendors = self.vendors
        }
    }
    
    func callVendor(vendor: Vendor) {
        //TODO Call Vendor
        guard let number = URL(string: "tel://\(vendor.phoneNumber)") else{
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
