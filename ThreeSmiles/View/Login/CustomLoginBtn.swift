//
//  CustomLoginBtn.swift
//  ThreeSmiles
//
//  Created by Wei Wu on 2024/09/27.
//

import Foundation
import UIKit

enum LoginType {
    case login
    case demo
    case google
    case apple
}

@IBDesignable
class CustomLoginBtn: UIButton {
    let standardHeight: CGFloat = 50

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        layer.cornerRadius = 10
        heightAnchor.constraint(equalToConstant: standardHeight).isActive = true
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        setTitleColor(.white, for: .normal)
    }

    func setLoginType(_ type: LoginType) {
        switch type {
        case .google:
            setTitle("Google", for: .normal)
        case .apple:
            setTitle("Apple", for: .normal)
        case .login:
            setTitle(NSLocalizedString("login", comment: "login button title"), for: .normal)
            backgroundColor = Colors.primaryBtn
        case .demo:
            setTitle(NSLocalizedString("demo", comment: "demo button title"), for: .normal)
            setTitleColor(Colors.primaryBtn, for: .normal)
            layer.borderWidth = 1
            layer.borderColor = Colors.primaryBtn.cgColor
        }
    }
}



