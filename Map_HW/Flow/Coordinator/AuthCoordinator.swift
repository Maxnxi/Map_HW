//
//  AuthCoordinator.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 14.11.2021.
//

import UIKit

class AuthCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showLoginModule()
    }
    
    private func showLoginModule() {
        guard let controller = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: LoginViewController.reuseIdentifier) as? LoginViewController else { return }
        
        controller.onRegister = { [weak self] in
            self?.showRegisterModule()
        }
        controller.onLogin = { [weak self] in
            self?.onFinishFlow?()
        }
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }
    
    private func showRegisterModule() {
        guard let controller = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: RegisterViewController.reuseIdentifier) as? RegisterViewController else { return }
        rootController?.pushViewController(controller, animated: true)
    }
}
