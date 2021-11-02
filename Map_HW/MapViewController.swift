//
//  MapViewController.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 02.11.2021.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {

    var locationManager: CLLocationManager?
    
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureLocationManager()
    }
    
    func configureMap() {
        let coordinate = CLLocationCoordinate2D(latitude: 59.939095, longitude: 30.315868)
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 14)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
    }
    
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        locationManager?.distanceFilter = 50
    }
    
    func centerMap(newLocation: CLLocation) {
        let myLocation = newLocation
        let camera = GMSCameraPosition.camera(withLatitude: myLocation.coordinate.latitude, longitude: myLocation.coordinate.longitude, zoom: 17.0)
        mapView.camera = camera
    }
    
    func addMarker(newLocation: CLLocation) {
        let coordinate2d = newLocation.coordinate
        let marker = GMSMarker(position: coordinate2d)
        let imageOfMarker = UIImage(systemName: "drop.fill")
        marker.icon = imageOfMarker
        marker.map = mapView
    }

    @IBAction func centerButtonWasPressed(_ sender: Any) {
        guard let location = locationManager?.location else {
            print("Failed get coordinate")
            return
        }
        mapView.animate(toLocation: location.coordinate)
    }
}

extension MapViewController: CLLocationManagerDelegate, GMSMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        addMarker(newLocation: location)
        mapView.animate(toLocation: location.coordinate)
        print("Location changed")
        print(locations.last as Any)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        print("Error in delegate")
    }
}

