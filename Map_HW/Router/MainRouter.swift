//
//  MainRouter.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 13.11.2021.
//

import UIKit

final class MainRouter: BaseRouter {

    func toMap(usseles: String) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(MapViewController.self)
        //controller.usselesExampleVariable = usseles
        show(controller)
    }
    
    func toLaunch() {
        let controller = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(LoginViewController.self)
        setAsRoot(UINavigationController(rootViewController: controller))
    }
}
