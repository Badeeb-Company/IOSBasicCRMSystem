//
//  RoundedView.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/25/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class RoundedView: UIView {
    override func draw(_ rect: CGRect) {
        let maskLayer = CAShapeLayer.init()
        let corners : UIRectCorner = UIRectCorner.allCorners;
        maskLayer.path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: 8, height: 8)).cgPath
        
        self.layer.mask = maskLayer;
        
    }
}
