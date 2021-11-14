//
//  LoginRouter.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 13.11.2021.
//

import Foundation
import UIKit

class LoginRouter: BaseRouter {
    
    func toMain() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(MainViewController.self)
        setAsRoot(UINavigationController(rootViewController: controller))
    }
    
    func onRecover() {
        let controller = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(RegisterViewController.self)
        show(controller)
    }
}
