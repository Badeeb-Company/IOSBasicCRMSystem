//
//  PromotionsViewController.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/10/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

enum PromotionType {
    case valid
    case expierd
}
class PromotionsViewController: AbstractTabViewController,UITableViewDataSource,PromotionCellDelegate {
    var promotions : [Promotion] = []
    var promotionType : PromotionType = .valid
    var currentPage : Int = 1
    
    
    // MARK : Promotion Cell Delegate
    func imageHeightForPromotion(indexPath: IndexPath, height: CGFloat) {
        if promotions.count > indexPath.row {
            var promotion = promotions[indexPath.row]
            if promotion.imageHeight != height {
                promotion.imageHeight = height
                promotions[indexPath.row] = promotion
                self.tableView.reloadData()
            }
        }
        
    }
    override func viewDidLoad() {
        if self.view.tag == 1 {
            self.promotionType = .expierd
        }
        
        super.viewDidLoad()
        self.loadData(page: page)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData(page: page)
    }
    func isExpiered() -> Bool {
        
        return self.promotionType == .expierd
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 10))
        view.backgroundColor = UIColor.clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var promotion = promotions[indexPath.row]
        
        return promotion.imageHeight + 70
    }
    override func loadData(page: Int) {
        
        let manager = PromotionsManager()
        self.showLoading()
        manager.getPromotions(page: page, pageSize: pageSize, expired: isExpiered()) { (result) in
            if self.page == 1 {
                if let resultArray = result as? APIResponse {
                    if let promotions = resultArray.results as? [Promotion]{
                        self.promotions = promotions
                    }
                }
            }else{
                if let promotions = result.results as? [Promotion]{
                    let newPromotions = promotions
                    self.promotions.append(contentsOf: newPromotions)
                }
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
        return promotions.count
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let width = UIScreen.main.bounds.size.width - 50
//        return width
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "promotionCell", for: indexPath) as! PromotionCell
        if indexPath.row < promotions.count {
            let promotion = promotions[indexPath.row]
            cell.bindCell(promotion: promotion,expired: isExpiered())
        }
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    var selectedPromotion : Promotion?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO Open Promotion
        if indexPath.row < promotions.count {
            let promotion = promotions[indexPath.row]
            self.selectedPromotion = promotion
            self.openPromotion(promotion: promotion)
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PromotionViewController {
            dest.promotion = self.selectedPromotion
        }
        segue.destination.hidesBottomBarWhenPushed = true
    }
    
}
