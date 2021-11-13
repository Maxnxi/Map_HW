//
//  BaseRouter.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 13.11.2021.
//

import Foundation
import UIKit

class BaseRouter: NSObject {
    @IBOutlet weak var controller: UIViewController!
    
    
    func show(_ controller: UIViewController) { self.controller.show(controller, sender: nil)
    }
    func present(_ controller: UIViewController) { self.controller.present(controller, animated: true)
    }
    func setAsRoot(_ controller: UIViewController) { UIApplication.shared.keyWindow?.rootViewController = controller
    }
}
