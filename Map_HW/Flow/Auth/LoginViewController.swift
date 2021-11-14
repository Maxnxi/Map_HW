//
//  LoginViewController.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 12.11.2021.
//

import UIKit

class LoginViewController: UIViewController {

    static let reuseIdentifier = "LoginViewController"
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    enum Constants {
        static let login = "admin"
        static let password = "123456"
    }
    
    var onLogin: (() -> Void)?
    var onRegister: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "isLogin") {
            performSegue(withIdentifier: "toMain", sender: self)
        }
    }
    
    
    @IBAction func loginButtonWasPressed(_ sender: Any) {
//        guard let login = loginTextField.text,
//              let password = passwordTextField.text,
//              login == Constants.login && password == Constants.password else { return }
        print("Логин")
        UserDefaults.standard.set(true, forKey: "isLogin")
        onLogin?()
    }
    
    @IBAction func registerButtonWasPressed(_ sender: Any) {
        onRegister?()
    }
    
}
