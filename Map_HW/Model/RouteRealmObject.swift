//
//  RouteRealmObject.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 08.11.2021.
//

import Foundation
import RealmSwift
import GoogleMaps

class Coordinates: Object {
    @Persisted var idNumber: Int
    @Persisted var latitude: Double
    @Persisted var longtitude: Double
}

class RouteRealmObject: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var coordinates: List<Coordinates>
}

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
        
        return GMSMutablePath()
    }
}
