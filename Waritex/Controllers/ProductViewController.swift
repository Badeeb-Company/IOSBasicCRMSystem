//
//  ProductViewController.swift
//  WaritexPromotions
//
//  Created by Mostafa on 7/8/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class ProductViewController: AbstractViewController {
    
    // Outlets
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIView!
    @IBOutlet weak var productDescTextView: UITextView!
    
    
    // Variables
    
    var product : Product = Product ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productDescTextView.textColor = ServerConstants.TextColor
        if let navig = self.navigationController?.navigationBar {
            print(navig)
            self.navigationController?.navigationBar.tintColor = UIColor.init(red: 183.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1.0)
            
        }

        self.bindData()
    }
    
    
    // Bind Data
    func bindData(){
        self.productTitleLabel.text = product.name
        self.productDescTextView.text = product.desc
        let imageView = UIImageView.init()
        let height = (UIScreen.main.bounds.width * 868.0/1188.0)
        self.productImageView.frame.size.height = height
        let heightConstraint = NSLayoutConstraint(item: productImageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: productImageView.frame.height)
        self.productImageView.addConstraint(heightConstraint)

        imageView.frame = self.productImageView.frame
        imageView.frame.origin = CGPoint.zero
        imageView.frame.size.width = UIScreen.main.bounds.width
        self.productImageView.addSubview(imageView)
        if let url = URL.init(string: product.photoUrl){
            imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imgPlaceholder"))
        }else{
            imageView.image = #imageLiteral(resourceName: "imgPlaceholder")
        }
        self.view.layoutIfNeeded()
    }
}
