//
//  CircularView.swift

//
//  Created by Mostafa on 5/16/17.
//

import Foundation
import UIKit

extension UIImageView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if self.tag == 10 {
            self.layoutIfNeeded()
            layer.cornerRadius = frame.size.height / 2;
            clipsToBounds = true;
            if self.tag != 1 {
                self.layer.borderColor = UIColor.init(red: 87.0/255.0, green: 167.0/255.0, blue: 0.0, alpha: 1.0).cgColor
                self.layer.borderWidth = 1
            }
        }
    }
}
class CircularImage: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        layer.cornerRadius = frame.size.height / 2;
        clipsToBounds = true;
        if self.tag != 1 {
            self.layer.borderColor = UIColor.init(red: 87.0/255.0, green: 167.0/255.0, blue: 0.0, alpha: 1.0).cgColor
            self.layer.borderWidth = 1
        }
    }
}
