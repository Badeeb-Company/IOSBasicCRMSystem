//
//  ProductCell.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/16/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    var product : Product?
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    func bindCell(product: Product) {
        self.product = product
        self.productImageView.contentMode = .scaleAspectFill
        if let url = URL.init(string: product.photoUrl) {
            self.productImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imgPlaceholder"))
        }else{
            self.productImageView.image = #imageLiteral(resourceName: "imgPlaceholder")
        }
        self.productTitleLabel.text = product.name
        // TODO Check if expiered promotion or not
    }

}
