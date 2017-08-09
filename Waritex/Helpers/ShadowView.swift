//
//  ShadowView.swift
//  Hippy
//
//  Created by inova5 on 6/13/17.
//  Copyright © 2017 Inova. All rights reserved.
//

import Foundation
import UIKit

class ShadowView : UIView {
    override func draw(_ rect: CGRect) {

        super.draw(rect)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.14
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 3.0
    }
}
