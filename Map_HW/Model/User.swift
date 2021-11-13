//
//  User.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 12.11.2021.
//

import Foundation
import RealmSwift

class UserRealmObject: Object {

    @Persisted(primaryKey: true) var login: String
    @Persisted var password: String

}
