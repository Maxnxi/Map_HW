//
//  MapViewController.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 02.11.2021.
//

import UIKit
import GoogleMaps
//import CoreLocation

class MapViewController: UIViewController {

    static let reuseIdentifier = "MapViewController"
    
    var usselesExampleVariable = ""
    
    var locationManager /*= LocationManager.shared // */: CLLocationManager?
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    var isStartTrackState: Bool = false
    
    var marker: GMSMarker?
    
    //Factory
    private let routeModelFactory = RouteModelFactory()
    //RealmServices
    private let realmServices = RealmServices()
    //Locatingservices
    //private let locatingServices = LocatingServices()
    
    @IBOutlet weak var startTrackView: UIView!
    @IBOutlet weak var startTrackButton: UIButton!
    @IBOutlet weak var stopTrackView: UIView!
    @IBOutlet weak var stopTrackButton: UIButton!
    @IBOutlet weak var showLastTrackView: UIView!
    @IBOutlet weak var showLastTrackButton: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    
    var avatarImage: UIImage?
    var avatarPositionView: UIImageView?
    var photoMarker: GMSMarker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureUI()
        
        avatarPositionView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        let size = CGSize(width: 30, height: 30)
        //avatarPositionView?.sizeThatFits(size)
        var imagetToShow: UIImage
        if let image = SaveNLoadToPhoneImageService.shared.loadImageFromDiskWith(fileName: avatarName) {
            imagetToShow = image
        } else {
            imagetToShow = UIImage(systemName: "photo.circle")!
        }
        //guard let image = imagetToShow else { return }
        avatarImage = UIImage().resizeImage(image: imagetToShow, targetSize: size)
        avatarPositionView?.image = avatarImage
        avatarPositionView?.layer.cornerRadius = 15
        avatarPositionView?.layer.shadowColor = UIColor.black.cgColor
        avatarPositionView?.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureLocationManager()
    }
    
    func configureUI() {
        startTrackView.layer.cornerRadius = 16
        stopTrackView.layer.cornerRadius = 16
        startTrackButton.layer.cornerRadius = 16
        let superViewSize = startTrackView.bounds.size
        startTrackButton.titleLabel?.sizeThatFits(superViewSize)
        stopTrackView.layer.cornerRadius = 16
        showLastTrackButton.layer.cornerRadius = 0
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
        // version #2
//        locationManager
//            .location
//            .asObservable()
//            .bind { [weak self] location in
//                guard let location = location else { return }
//                self?.routePath?.add(location.coordinate)
//                self?.route?.path = self?.routePath
//                let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
//                self?.mapView.animate(to: position)
//            }
    
        
        // version #1
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.startMonitoringSignificantLocationChanges()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        locationManager?.distanceFilter = 50
    }
    
    func centerMap(newLocation: CLLocation) {
        let myLocation = newLocation
        let camera = GMSCameraPosition.camera(withLatitude: myLocation.coordinate.latitude, longitude: myLocation.coordinate.longitude, zoom: 17.0)
        mapView.camera = camera
    }
    
    func addPhotoMarker(newLocation: CLLocation) {
        let coordinate2d = newLocation.coordinate
        let marker = GMSMarker(position: coordinate2d)
        //let imageOfMarker = avatarImage
        photoMarker = marker
        photoMarker?.iconView = avatarPositionView
        photoMarker?.iconView?.clipsToBounds = true
        photoMarker?.iconView?.layer.cornerRadius = 15
        photoMarker?.iconView?.layer.shadowColor = UIColor.darkGray.cgColor
        photoMarker?.iconView?.layer.shadowRadius = 10
        photoMarker?.iconView?.layer.shadowOffset = CGSize(width: 5, height: 5)
        photoMarker?.iconView?.layer.borderColor = UIColor.white.cgColor
        photoMarker?.iconView?.layer.borderWidth = 2
        //marker.iconView?.layer.cornerRadius = (marker.iconView?.bounds.size.width ?? 30 )/2
        photoMarker?.map = mapView
    }
    
    func removePhotoMarker() {
       
        //let marker = GMSMarker()// position: coordinate2d)
        //let imageOfMarker = avatarImage
        //marker.iconView = nil
        //marker.iconView?.layer.cornerRadius = (marker.iconView?.bounds.size.width ?? 30 )/2
        photoMarker?.map = nil
    
    }
    
    func addMarker(newLocation: CLLocation) {
        let coordinate2d = newLocation.coordinate
        let marker = GMSMarker(position: coordinate2d)
        let imageOfMarker = UIImage(systemName: "drop.fill")
        marker.icon = imageOfMarker
        marker.map = mapView
    }
    
    func addstartMarker() {
        guard let startRouteCoordinate = route?.path?.coordinate(at: 0) else { return }
        let marker = GMSMarker(position: startRouteCoordinate)
        marker.title = "Start Point"
        marker.snippet = "шоссе"
        marker.map = mapView
        self.marker = marker
    }
    
    func saveLastRouteToRealm() {
        guard let routepath = routePath else { return }
        let routeRealm = routeModelFactory.constructRouteRealm(route: routepath)
        realmServices.saveRoute(route: routeRealm)
    }
    
    func showLastRouteOnMap() {
        guard let routeRealm = realmServices.loadRoute() else { return }
        let routeGMS = routeModelFactory.constructRouteToGMSMutablePath(route: routeRealm)
        route?.path = routeGMS
        route?.map = mapView
        let camera = GMSCameraPosition.camera(withTarget: routeGMS.coordinate(at: 0), zoom: 12)
        mapView.camera = camera

    }
    
    func showAlertView(completion: @escaping(_ result: Bool ) -> ()) {
        let view = UIAlertController(title: "Внимание!", message: "Сейчас идет отслеживание маршрута!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] action in
            print("OK")
            completion(true)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { action in
            print("Cancel")
            completion(false)
        }
        view.addAction(okAction)
        view.addAction(cancelAction)
        self.present(view, animated: true) {
            print("Alert done!")
        }
    }

    @IBAction func startTrackButtonWasPressed(_ sender: Any) {
        print("start Track")
// version #2 for Homework #2
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.strokeWidth = 3
        route?.map = mapView
        locationManager?.startUpdatingLocation()// startUpdatingLocation()
        isStartTrackState = true
        
// version #1 for Homework #1
//        guard let location = locationManager?.location else {
//            print("Failed get coordinate")
//            return
//        }
//        mapView.animate(toLocation: location.coordinate)
    }
    
    func stopLocating() {
        route?.map = nil
        route?.map = mapView
        locationManager?.stopUpdatingLocation()
        isStartTrackState = false
        // remove GMSMarker
        self.marker = nil
        // save last track
        self.saveLastRouteToRealm()
    }

   
    
    @IBAction func stopTrackButtonWasPressed(_ sender: Any) {
        print("stop Track")
        stopLocating()
    }
    
    @IBAction func showLasttrackButtonWasPressed(_ sender: Any) {
        print("Show Last route")
        if isStartTrackState {
            showAlertView { result in
                switch result {
                case true:
                    print("true")
                    
                    // stop
                    self.stopLocating()
                    self.saveLastRouteToRealm()
                    self.showLastRouteOnMap()
                case false:
                    print("false")
                    
                }
            }
        } else {
            // try to show
            self.showLastRouteOnMap()
        }
        
        
    }
 
   
    
}

extension MapViewController: CLLocationManagerDelegate, GMSMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        removePhotoMarker()
        guard let location = locations.last else { return }
// version #2 for Homework #2
        routePath?.add(location.coordinate)
        route?.path = routePath
        if isStartTrackState && routePath?.count() == 1 {
            addstartMarker()
        }
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
        addPhotoMarker(newLocation: location)
        mapView.animate(to: position)
// version #1 for Homework #1
//        addMarker(newLocation: location)
//        mapView.animate(toLocation: location.coordinate)
//        print("Location changed")
//        print(locations.last as Any)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        print("Error in delegate")
    }
}

