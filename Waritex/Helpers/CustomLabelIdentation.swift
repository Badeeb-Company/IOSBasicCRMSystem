//
//  LabelIdentationExtention.swift
//  Waritex
//
//  Created by Mostafa on 7/16/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit


class CustomLabelIdentation: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        if UserManager().isArabic(){
            if self.tag == 0 || self.tag == 5{
                self.textAlignment = .left
            }else{
                self.textAlignment = .right
            }
        }else{
            if self.tag == 1 || self.tag == 9 {
                self.textAlignment = .left
            }else{
                self.textAlignment = .right
            }
        }
    }
}

