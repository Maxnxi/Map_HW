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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func loginButtonWasPressed(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              login == Constants.login && password == Constants.password else { return }
        print("Логин")
    }
    
    @IBAction func registerButtonWasPressed(_ sender: Any) {
    }
    
}
