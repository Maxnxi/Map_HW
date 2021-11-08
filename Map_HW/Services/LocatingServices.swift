//
//  LocatingServices.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 08.11.2021.
//

import Foundation
import GoogleMaps

class LocatingServices {
    
    
    
    
    func stopLocating(route: GMSPolyline) {
        route?.map = nil
        route?.map = mapView
        locationManager?.stopUpdatingLocation()
        isStartTrackState = false
        // remove GMSMarker
        self.marker = nil
        // save last track
        self.saveLastRouteToRealm()
    }
}
