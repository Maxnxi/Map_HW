//
//  MainCoordinator.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 14.11.2021.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showMainModule()
    }
    
    private func showMainModule() {
    
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MainViewController.reuseIdentifier) as? MainViewController else { return }
        
        controller.onMap = { [weak self] usseles in
            self?.showMapModule(usseles: usseles)
        }
        
        controller.onLogout = { [weak self] in
            self?.onFinishFlow?()
        }
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }
    
    private func showMapModule(usseles: String) {
    
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MapViewController.reuseIdentifier) as? MapViewController else { return }
        controller.usselesExampleVariable = usseles
        rootController?.pushViewController(controller, animated: true)
    }
    
}
