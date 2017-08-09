//
//  MapViewController.swift
//  WaritexPromotions
//
//  Created by Mostafa on 6/30/17.
//  Copyright © 2017 Badeeb. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class MapViewController: AbstractViewController,MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.map.isZoomEnabled = true

    }
    
    
    
    var vendors : [Vendor] = []
    var selectedVendor : Vendor?
        @IBAction func didTapOutside(_ sender: Any) {
            self.selectedVendor = nil
            self.setAnnotationsOnMap()
        }
        @IBAction func zoomToLocationPressed(_ sender: UIButton) {
            self.zoomToUserLocation(MKCoordinateSpanMake(0.02, 0.02))
            self.selectedVendor = nil
            self.setAnnotationsOnMap()
        }
        
        func zoomToUserLocation(_ span: MKCoordinateSpan) {
//             TODO Get User Location from User Manager
//                        if let user = UserManager().loadCachedUser() {
            var lat : Double = 0
            if let lt = UserDefaults.standard.value(forKey: "lat") as? Double {
                lat = lt
            }
            var long : Double = 0
            if let lng = UserDefaults.standard.value(forKey: "long") as? Double {
                long = lng
            }

                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: span)
                DispatchQueue.main.async{
                    self.map.setRegion(region, animated: true)
                }
//            }
        }
        
        @IBOutlet weak var mapView: MKMapView!
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.setAnnotationsOnMap()
            // TODO Load All Winners & lossers
        }
        
        func setAnnotationsOnMap (){
            
            self.map.removeAnnotations(self.map.annotations)
            // Reset current zoom scale to max, thus zooming due to selecting city and area are ignored
            //        self.currentZoomScale = CGFloat.max
            
            var annotationList: [MKAnnotation] = []
            
            
                for vendor in vendors {
                    
                    let c = CLLocationCoordinate2D(latitude: CLLocationDegrees(vendor.lat), longitude: CLLocationDegrees(vendor.lng))
                    let pinMap = KZNPinMap(locationName: vendor.name, locationDescription: vendor.address, coordinate: c,vendor: vendor)
                    annotationList.append(pinMap)
                }
            var user = Vendor()
            user.id = -1
            var lat : Double = 0
            if let lt = UserDefaults.standard.value(forKey: "lat") as? Double {
                lat = lt
            }
            var long : Double = 0
            if let lng = UserDefaults.standard.value(forKey: "long") as? Double {
                long = lng
            }
            
            let c = CLLocationCoordinate2D(latitude: long, longitude: lat)
            let pinMap = KZNPinMap(locationName: "", locationDescription: "", coordinate: c,vendor: user)
            var allAnnotations = annotationList
            allAnnotations.append(pinMap)

            self.map.addAnnotations(allAnnotations)
            self.map.showAnnotations(annotationList, animated: true)
            
        }

    
        // MKMap View Delegate
        //MARK: mapView
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let annotation = annotation as? KZNPinMap {
                var identifier = "pin"
                
                var view: KZNAnnotationView
                if let vendor = self.selectedVendor {
                    if annotation.vendor?.id == vendor.id {
                        identifier = "extraPin"
                    }
                }
                if let dequeuedView = map.dequeueReusableAnnotationView(withIdentifier: identifier)
                    as? KZNAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
                   
                } else {
                    view = KZNAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                }
                view.clipsToBounds = false
//                view.userImageView?.tag = 0
//                view.userImageView?.contentMode = .scaleToFill
                view.isEnabled = true
                view.isUserInteractionEnabled = true
                if annotation.vendor?.id == -1 {
                    view.image = UIImage.init(named: "myLocationPin")
                }else{
                    view.image = nil
                }
                if let vendor = self.selectedVendor {
//                    if let url = URL.init(string: groupStatus.group_image_url) {
//                        view.groupDetailsImage?.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imgPlaceholder"))
//                    }else{
//                        view.groupDetailsImage?.image = #imageLiteral(resourceName: "imgPlaceholder")
//                    }
//                    view.groupDetailsLabel?.text = groupStatus.group_title
                }
                return view
            }
            return nil
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print("Annotation")
            if let annotation = view.annotation as? KZNPinMap {
                print(annotation)
                // TODO Show view from this                
                self.selectedVendor = annotation.vendor
                self.setAnnotationsOnMap()
            }
        }
        var zoomingIn = false
        var zoomingAnnotation:MKAnnotation?
        var actionSheet : UIAlertController = UIAlertController.init()
        
        func zoomInOnPin(annotation:MKAnnotation) {
            let zoomOutRegion = MKCoordinateRegion(center: map.region.center, span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09))
            zoomingIn = true
            zoomingAnnotation = annotation
            map.setRegion(zoomOutRegion, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            if zoomingIn {
                if let annotation = zoomingAnnotation  {
                    zoomingIn = false
                    let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta:     0.07, longitudeDelta: 0.07))
                    map.setRegion(region, animated: true)
                }
            }
        }
        
  }
