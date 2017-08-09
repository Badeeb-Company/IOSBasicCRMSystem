//
//  UIViewAlignmentExtenstion.swift
//

import Foundation
import UIKit

/*
 * Extention to UIView that adjust the elements alignment direction
 */
extension UIView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        if (self.semanticContentAttribute != .forceLeftToRight){
            if UserManager().isArabic() {
                    self.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
            }else{
                self.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
            }
        
        }
    }
}


extension UILabel {
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        switch tag {
        case 0:
            self.textColor = ServerConstants.HeaderColor
            break
        case 1,5,9:
            self.textColor = ServerConstants.TextColor
            break
        
        case 2:
            self.textColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            break
        case 3:
            self.textColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            break
        default:
            self.textColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
    }
}
