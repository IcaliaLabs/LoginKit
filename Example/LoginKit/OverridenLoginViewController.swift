//
//  OverridenLoginViewController.swift
//  LoginKit_Example
//
//  Created by Daniel Lozano Valdés on 3/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ILLoginKit

class OverridenLoginViewController: LoginViewController {

    override func viewDidLoad() {
		configuration = DefaultConfiguration(backgroundImage: #imageLiteral(resourceName: "Background"),
											 tintColor: UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1),
											 errorTintColor: UIColor(red: 253.0/255.0, green: 227.0/255.0, blue: 167.0/255.0, alpha: 1),
											 signupButtonText: "Create Account",
											 loginButtonText: "Sign In",
											 facebookButtonText: "Login with Facebook",
											 forgotPasswordButtonText: "Forgot password?",
											 recoverPasswordButtonText: "Recover",
											 emailPlaceholder: "E-Mail",
											 passwordPlaceholder: "Password!",
											 repeatPasswordPlaceholder: "Confirm password!",
											 namePlaceholder: "Name",
											 shouldShowSignupButton: false,
											 shouldShowLoginButton: true,
											 shouldShowForgotPassword: true)
		super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
