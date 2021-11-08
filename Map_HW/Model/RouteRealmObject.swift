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




