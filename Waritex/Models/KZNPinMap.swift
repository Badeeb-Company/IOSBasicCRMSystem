//
//  KZNPinMap.swift
//  Kazyon
//
//  Created by inova5 on 5/3/16.
//  Copyright © 2016 Inova. All rights reserved.
//

import MapKit
import UIKit

class KZNPinMap: NSObject, MKAnnotation {
    let title: String?
    let locationDescription: String
    let coordinate: CLLocationCoordinate2D
    let vendor : Vendor?
//    let groupStatus : GroupStatus
    init(locationName: String, locationDescription: String, coordinate: CLLocationCoordinate2D, vendor:Vendor) {
        self.title = locationName
        self.locationDescription = locationDescription
        self.coordinate = coordinate
        self.vendor = vendor
        super.init()
    }
    
    var subtitle: String? {
        return locationDescription
    }
}
