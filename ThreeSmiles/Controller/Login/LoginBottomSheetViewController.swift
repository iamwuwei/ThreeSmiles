//
//  LoginBottomSheetViewController.swift
//  ThreeSmiles
//
//  Created by Wei Wu on 2024/09/27.
//

import UIKit

class LoginBottomSheetViewController: UIViewController {
    @IBOutlet weak var loginWithGoogleBtn: CustomLoginBtn!
    @IBOutlet weak var loginWithAppleBtn: CustomLoginBtn!
    @IBOutlet weak var loginWithEmail: CustomLoginBtn!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        loginWithGoogleBtn.setLoginType(.google)
        loginWithAppleBtn.setLoginType(.apple)
        loginWithEmail.setLoginType(.email)
    }
}
