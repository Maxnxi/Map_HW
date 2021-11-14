//
//  RealmServices.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 08.11.2021.
//

import Foundation
import RealmSwift

class RealmServices {
   
    func saveRoute(route: RouteRealmObject) {
        do {
            let realm = try Realm()
            // Use realm
            try realm.write({
                realm.deleteAll()
                realm.add(route)
            })
        } catch let error as NSError {
            // Handle error
        }
    }
    
    func loadRoute() -> RouteRealmObject? {
        
        do {
            let realm = try Realm()
            // Use realm
            let routes = realm.objects(RouteRealmObject.self)
            guard let lastRoute = routes.last else { return nil }
            
            return lastRoute
        } catch let error as NSError {
            // Handle error
            return nil
        }
       
        
        
    }
    
}
