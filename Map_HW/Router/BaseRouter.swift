//
//  BaseRouter.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 13.11.2021.
//

import Foundation
import UIKit

class BaseRouter: NSObject {
    
    //var appDelegate: AppDelegate
    @IBOutlet weak var controller: UIViewController!
    
//    private init(appDelegate: AppDelegate, controller: UIViewController) {
//        self.appDelegate = appDelegate
//        self.controller = controller // isEmbedded()// firstEmbeded()
//        super.init()
//    }
    
    func show(_ controller: UIViewController) {
        self.controller.show(controller, sender: nil)
    }
    
    func present(_ controller: UIViewController) {
        self.controller.present(controller, animated: true)
    }
    
    func setAsRoot(_ controller: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
    
}
