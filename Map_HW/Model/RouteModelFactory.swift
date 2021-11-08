//
//  RouteModelFactory.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 08.11.2021.
//

import Foundation
import GoogleMaps

struct CoordinatesModel {
    let idNumber: Int
    let latitude: Double
    let longtitude: Double
}

struct RouteModel {
    let coordinates: [CoordinatesModel]
}

class RouteModelFactory {
    func constructRouteRealm(route: GMSMutablePath) -> RouteRealmObject {
        let tmpRoute = RouteRealmObject()
        for index in 0..<route.count() {
            let coordinate = route.coordinate(at: index)
            let coords = Coordinates()
            coords.idNumber = Int(index)
            coords.latitude = coordinate.latitude
            coords.longtitude = coordinate.longitude
            tmpRoute.coordinates.append(coords)
        }
        return tmpRoute
    }
    
    func constructRouteToGMSMutablePath(route: RouteRealmObject) -> GMSMutablePath {
        let routeGMS = GMSMutablePath()
        for index in 0..<route.coordinates.count {
            route.coordinates.forEach { coordinate in
                if coordinate.idNumber == index {
                    let cllocationCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longtitude)
                    routeGMS.add(cllocationCoordinate)
                }
            }
        }
        return routeGMS
    }
}


