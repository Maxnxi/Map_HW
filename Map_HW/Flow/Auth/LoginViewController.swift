//
//  LoginViewController.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 12.11.2021.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    static let reuseIdentifier = "LoginViewController"
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    enum Constants {
        static let login = "admin"
        static let password = "123456"
    }
    
    var onLogin: (() -> Void)?
    var onRegister: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loginButton.isEnabled 
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "isLogin") {
            performSegue(withIdentifier: "toMain", sender: self)
        }
    }
    
    func configureLoginBindings() {
        Observable
            .combineLatest(loginTextField.rx.text, passwordTextField.rx.text)
            .map { login, password in
                return !(login ?? "").isEmpty && (password ?? "").count >= 6
            }
            .bind { [weak loginButton] inputFilled in
                loginButton?.isEnabled = inputFilled
                
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
