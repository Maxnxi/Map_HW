//
//  MainViewController.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 13.11.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var router: MainRouter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMap(_ sender: Any) {
        router.toMap(usseles: "пример")
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        router.toLaunch()
    }
    
    

}
