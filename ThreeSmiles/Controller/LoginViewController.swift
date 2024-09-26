//
//  LoginViewController.swift
//  ThreeSmiles
//
//  Created by Wei Wu on 2024/09/24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var demoBtn: CustomLoginBtn!
    @IBOutlet weak var loginBtn: CustomLoginBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        demoBtn.setLoginType(.demo)
        loginBtn.setLoginType(.login)
    }
}

