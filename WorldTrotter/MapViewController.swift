//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Gonzalo Benítez Bueno on 23/10/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController{
    
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        
        view = mapView
        
    }
    
}
