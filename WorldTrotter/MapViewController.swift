//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Gonzalo Benítez Bueno on 23/10/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var mapView: MKMapView!
    var locationManager =  CLLocationManager.init()
    var localizationButton: UIButton!
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self

        locationManager = CLLocationManager()

        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(segmentedControl)
    
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)

        
        let margins = view.layoutMarginsGuide
        
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
//        initLocalizationButton(mapView)
        
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex{
            case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        
        let localizationButton = UIButton(type: .system)
        let buttonWidth = 40

        
        localizationButton.frame = CGRect(x: 15,y: 100,width: buttonWidth, height: buttonWidth)
        localizationButton.layer.cornerRadius = 0.5 * localizationButton.bounds.size.width
        localizationButton.layer.borderWidth = 0.25
        localizationButton.layer.borderColor = UIColor.darkGray.cgColor
        localizationButton.layer.backgroundColor = UIColor.lightGray.cgColor
        localizationButton.setTitle("▲", for: UIControl.State())
        localizationButton.setTitleColor(UIColor.darkGray, for: UIControl.State())
        localizationButton.addTarget(self, action: #selector(self.geoButtonAction(_:)), for: .touchUpInside)
        view.addSubview(localizationButton)
        
        
    }
    
    @objc func geoButtonAction(_ sender: UIButton!) {
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
   
    }
    
     func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let zoomedInCurrentLocation = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(zoomedInCurrentLocation, animated: true)
        
    }
}
