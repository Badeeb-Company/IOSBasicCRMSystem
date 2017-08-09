//
//  PromotionCell.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/10/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


protocol PromotionCellDelegate {
    func imageHeightForPromotion(indexPath: IndexPath, height : CGFloat)
}
class PromotionCell: UITableViewCell {
    
    @IBOutlet weak var promotionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var delegate : PromotionCellDelegate?
    var promotion : Promotion?
    var expired : Bool = false
    var indexPath : IndexPath = IndexPath(item: 0, section: 1)
    func bindCell(promotion: Promotion, expired: Bool) {
        self.promotion = promotion
        self.expired = expired
        self.promotionImageView.contentMode = .scaleToFill
        if let url = URL.init(string: promotion.photoUrl) {
            self.promotionImageView.sd_setImage(with: url, completed: { (image, error, type, url) in
                if let img = image {
                    let height = (UIScreen.main.bounds.width * img.size.height)/img.size.width
                    self.delegate?.imageHeightForPromotion(indexPath: self.indexPath, height: height)
                }else{
                    let img = #imageLiteral(resourceName: "imgPlaceholder")
                    let height = (UIScreen.main.bounds.width * img.size.height)/img.size.width
                    self.delegate?.imageHeightForPromotion(indexPath: self.indexPath, height: height)

                    self.promotionImageView.image = #imageLiteral(resourceName: "imgPlaceholder")
                }
            })
//               self.promotionImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imgPlaceholder"))
        }else{
            self.promotionImageView.image = #imageLiteral(resourceName: "imgPlaceholder")
            let img = #imageLiteral(resourceName: "imgPlaceholder")
            let height = (UIScreen.main.bounds.width * img.size.height)/img.size.width
            self.delegate?.imageHeightForPromotion(indexPath: self.indexPath, height: height)
        }
        self.titleLabel.text = promotion.title
        if self.expired {
            let attrs1 = [NSForegroundColorAttributeName :ServerConstants.HeaderColor]
            
            let attrs2 = [NSForegroundColorAttributeName : ServerConstants.TextColor]
            if UserManager().isArabic() {
                let attributedString1 = NSMutableAttributedString(string:"إنتهي في : ", attributes:attrs1)
            
                let attributedString2 = NSMutableAttributedString(string:"\(promotion.dueDate)", attributes:attrs2)
            
                attributedString1.append(attributedString2)
            
                self.dateLabel.attributedText = attributedString1
            }else{
                let attributedString1 = NSMutableAttributedString(string:"expired at :", attributes:attrs1)
                
                let attributedString2 = NSMutableAttributedString(string:"\(promotion.dueDate)", attributes:attrs2)
                
                attributedString1.append(attributedString2)
                
                self.dateLabel.attributedText = attributedString1
            }
        }else{
            if UserManager().isArabic() {
                let attrs1 = [NSForegroundColorAttributeName : ServerConstants.HeaderColor]
            
                let attrs2 = [NSForegroundColorAttributeName : ServerConstants.TextColor]
            
                let attributedString1 = NSMutableAttributedString(string:"صالح حتي : ", attributes:attrs1)
            
                let attributedString2 = NSMutableAttributedString(string:"\(promotion.dueDate)", attributes:attrs2)
            
                attributedString1.append(attributedString2)
                self.dateLabel.attributedText = attributedString1
            }else{
                let attrs1 = [NSForegroundColorAttributeName : ServerConstants.HeaderColor]
                
                let attrs2 = [NSForegroundColorAttributeName : ServerConstants.TextColor]
                
                let attributedString1 = NSMutableAttributedString(string:"valid till : ", attributes:attrs1)
                
                let attributedString2 = NSMutableAttributedString(string:"\(promotion.dueDate)", attributes:attrs2)
                
                attributedString1.append(attributedString2)
                self.dateLabel.attributedText = attributedString1
            }
            
        }
        // TODO Check if expiered promotion or not
    }
    
}
