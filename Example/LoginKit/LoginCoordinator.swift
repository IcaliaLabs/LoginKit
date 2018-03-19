//
//  LoginCoordinator.swift
//  LoginKit
//
//  Created by Daniel Lozano Valdés on 3/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ILLoginKit

class LoginCoordinator: ILLoginKit.LoginCoordinator {

    // MARK: - LoginCoordinator

    override func start(animated: Bool = true) {
        super.start(animated: animated)
        configureAppearance()
    }

    override func finish(animated: Bool = true) {
        super.finish(animated: animated)
    }

    // MARK: - Setup

    func configureAppearance() {
        // Customize LoginKit. All properties have defaults, only set the ones you want.

        // Customize the look with background & logo images
        backgroundImage = #imageLiteral(resourceName: "Background")
		backgroundImageGradient = false
        // mainLogoImage =
        // secondaryLogoImage =

        // Change colors
        tintColor = UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1)
        errorTintColor = UIColor(red: 253.0/255.0, green: 227.0/255.0, blue: 167.0/255.0, alpha: 1)

        // Change placeholder & button texts, useful for different marketing style or language.
        loginButtonText = "Sign In"
        signupButtonText = "Create Account"
        facebookButtonText = "Login with Facebook"
        forgotPasswordButtonText = "Forgot password?"
        recoverPasswordButtonText = "Recover"
        namePlaceholder = "Name"
        emailPlaceholder = "E-Mail"
        passwordPlaceholder = "Password!"
        repeatPasswordPlaceholder = "Confirm password!"
    }

    // MARK: - Completion Callbacks

    override func login(email: String, password: String) {
        // Handle login via your API
        print("Login with: email =\(email) password = \(password)")
    }

    override func signup(name: String, email: String, password: String) {
        // Handle signup via your API
        print("Signup with: name = \(name) email =\(email) password = \(password)")
    }

    override func enterWithFacebook(profile: FacebookProfile) {
        // Handle Facebook login/signup via your API
        print("Login/Signup via Facebook with: FB profile =\(profile)")

    }

    override func recoverPassword(email: String) {
        // Handle password recovery via your API
        print("Recover password with: email =\(email)")
    }

}
