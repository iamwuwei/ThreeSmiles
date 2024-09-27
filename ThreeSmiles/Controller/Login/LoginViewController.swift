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

    @IBAction func loginBtnOnClick(_ sender: Any) {
        if let loginBottomSheetViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginBottomSheet") as? LoginBottomSheetViewController {
            self.presentAsBottomSheet(loginBottomSheetViewController, smallSize: 200)
        }
    }
}

extension UIViewController: UIAdaptivePresentationControllerDelegate, UISheetPresentationControllerDelegate {
    func presentAsBottomSheet(_ viewController: UIViewController, smallSize: CGFloat = 100) {
        viewController.isModalInPresentation = false

        if let sheet = viewController.sheetPresentationController {
            if #available(iOS 15.0, *) {
                let smallDetent = UISheetPresentationController.Detent.custom { _ in
                    return smallSize
                }
                sheet.detents = [smallDetent]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.selectedDetentIdentifier = sheet.detents.first?.identifier
            } else {
                // Fallback for iOS 14 and earlier
                sheet.detents = [.medium()]
                sheet.selectedDetentIdentifier = .medium
            }

            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
            sheet.delegate = self
        }

        self.present(viewController, animated: true)
    }
}

