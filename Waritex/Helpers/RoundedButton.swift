//
//  RoundedButton.swift
//  WaritexPromotions
//
//  Created by Mostafa on 7/5/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        var maskLayer = CAShapeLayer.init()
        let corners : UIRectCorner = UIRectCorner.allCorners;
        maskLayer.path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: 8, height: 8)).cgPath
        
        self.layer.mask = maskLayer;
    }
}

