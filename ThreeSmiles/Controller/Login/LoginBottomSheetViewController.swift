//
//  LoginBottomSheetViewController.swift
//  ThreeSmiles
//
//  Created by Wei Wu on 2024/09/27.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

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

    @IBAction func loginWithGoogleBtnDidTap(_ sender: Any) {
        AuthService.shared.signInWithGoogle(presenting: self) { result in
            switch result {
            case .success(let user):
                print("Successfully signed in: \(user.uid)")
                DispatchQueue.main.async {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let main = storyboard.instantiateViewController(withIdentifier: "main") as? UITabBarController {
                            window.rootViewController = main
                            window.makeKeyAndVisible()
                        } else {
                            print("Failed to instantiate dashboard")
                        }
                    }
                }
            case .failure(let error):
                print("Failed to sign in: \(error.localizedDescription)")
                // Handle the error (e.g., show an alert to the user)
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Sign In Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
