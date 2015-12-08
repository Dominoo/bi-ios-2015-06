//
//  MapController.swift
//  bi-ios-map
//
//  Created by Dominik Vesely on 24/11/15.
//  Copyright © 2015 Ackee s.r.o. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import _500px_iOS_api


class MapController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    weak var map : MKMapView!
    var annotation : MKPointAnnotation?
    
    
    
    override func loadView() {
        self.view = UIView()
        
        let m = MKMapView()
        m.showsUserLocation = true
        m.mapType = MKMapType.Standard
        m.delegate = self
        self.view.addSubview(m)
        m.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        map = m
    }

    
    override func viewDidLoad() {
        
        switch CLLocationManager.authorizationStatus() {
        case .NotDetermined:     self.manager.requestWhenInUseAuthorization()
            
        default: print("ahoj")
        }

        
        self.manager.delegate = self
        self.manager.distanceFilter = kCLDistanceFilterNone
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.startUpdatingLocation()
        
        
       self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.Plain, target: self, action: "search:")
        
       
    }
    
    
    func search(sender : UIBarButtonItem) {
        PXRequest(forSearchGeo: "\(annotation!.coordinate.latitude),\(annotation!.coordinate.longitude),20km") { (objs: [NSObject : AnyObject]!, err: NSError!) -> Void in
            let colls = CollectionViewController()
            colls.data = objs["photos"] as! [[String : AnyObject]]
            self.navigationController?.pushViewController(colls, animated: true)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        print (newLocation)
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if(annotation is MKUserLocation) {
            return nil
        }
        
        
        var pin = mapView.dequeueReusableAnnotationViewWithIdentifier("myPin") as! MKPinAnnotationView?
        
        if (pin == nil) {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
        }
        
        pin?.image = UIImage(named: "bageta")
        
        pin?.animatesDrop = true
        pin?.draggable = true
        pin?.canShowCallout = true
        pin?.leftCalloutAccessoryView = UISwitch()
        

        return pin;
    }
    
    
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("ahoj")
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == MKAnnotationViewDragState.Ending {
            let droppedAt = view.annotation!.coordinate
            print("Pin dropped at \(droppedAt.latitude), \(droppedAt.longitude) ")
            let geo = CLGeocoder()
            let loc = CLLocation(latitude: droppedAt.latitude, longitude: droppedAt.longitude)
            geo.reverseGeocodeLocation(loc, completionHandler: { ( marks : [CLPlacemark]?, err: NSError?) -> Void in
                if let placemarks = marks {
                    let mark = placemarks.first!
                    self.title = mark.locality
                }
            })
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if annotation == nil {
           self.annotation = MKPointAnnotation()
        }
        annotation?.coordinate = self.map.centerCoordinate
        annotation?.title = "Drag me!"
        map.addAnnotation(annotation!)
    }


    
    
}
