//
//  MainViewController.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 13.11.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    static let reuseIdentifier = "MainViewController"
    
    var onMap: ((String) -> Void)?
    var onLogout: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMap(_ sender: Any) {
        onMap?("пример")
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        onLogout?()
    }
    
    

}
