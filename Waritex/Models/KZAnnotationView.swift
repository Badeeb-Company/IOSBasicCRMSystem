//
//  KZNAnnotationView.swift
//  Kazyon
//
//  Created by inova5 on 5/18/16.
//  Copyright © 2016 Inova. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class KZNAnnotationView : MKAnnotationView
{
//    var userImageView : CircularImage?
    let selectedLabel:UILabel = UILabel.init(frame:CGRect.init(x: 0, y: 0, width: 280, height: 380))
    var groupDetailsImage : UIImageView?
    var groupDetailsLabel : UILabel?
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        if reuseIdentifier == "extraPin" {
            super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
            let width = UIScreen.main.bounds.width - 40
            let detailsView = RoundedView.init(frame: CGRect.init(x: -((width/2) - 39), y: -200, width: width, height: 200))
            groupDetailsImage = UIImageView.init(frame: CGRect.init(x: 8, y: 51, width: width - 16, height: 128))
            detailsView.addSubview(groupDetailsImage!)
            detailsView.backgroundColor = UIColor.white
            groupDetailsLabel = UILabel.init(frame: CGRect.init(x: 8, y: 11, width: width - 16, height: 35))
            groupDetailsLabel?.font = UIFont.init(name: "Roboto-Regular", size: 14)
            groupDetailsLabel?.textColor = UIColor.init(red: 57.0/255.0, green: 54.0/255.0, blue: 57.0/255.0, alpha: 1.0)
            detailsView.addSubview(groupDetailsLabel!)
            self.addSubview(detailsView)
        }else{
            
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        }
        if let vAnnot = annotation as? KZNPinMap {
            if vAnnot.vendor?.id == -1 {
                self.image = UIImage.init(named: "myLocationPin")
            }else{
                self.image = UIImage.init(named: "")
            }
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
