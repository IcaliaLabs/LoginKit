//
//  LoginCoordinator.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 12/12/16.
//
//

import Foundation

protocol Configurable: class {

    var configuration: Configuration! { get set }

}

struct Configuration {

    var backgroundImage: UIImage!

    var logoImage: UIImage!

    var tintColor: UIColor!

    var signupButtonText: String!

    var loginButtonText: String!

    var facebookButtonText: String!

    var forgotPasswordText: String!

    var recoverPasswordText: String!

    var emailPlaceholder: String!

    var passwordPlaceholder: String!

    var repeatPasswordPlaceholder: String!

    var namePlaceholder: String!

}

open class LoginCoordinator {

    // MARK: - Properties

    // MARK: Public Configuration

    public var backgroundImage = UIImage()

    public var logoImage = UIImage()

    public var tintColor = UIColor(red: 185.0 / 255.0, green: 117.0 / 255.0, blue: 216.0 / 255.0, alpha: 1)

    public var signupButtonText = "SIGN UP"

    public var loginButtonText = "LOG IN"

    public var facebookButtonText = "CONNECT WITH FACEBOOK"

    public var forgotPasswordText = "Forgot Password"

    public var recoverPasswordText = "Recover Password"

    public var emailPlaceholder = "EMAIL"

    public var passwordPlaceholder = "PASSWORD"

    public var repeatPasswordPlaceholder = "REPEAT PASSWORD"

    public var namePlaceholder = "FULL NAME"

    // MARK: Private

    fileprivate let rootViewController: UIViewController?

    fileprivate let window: UIWindow?

    fileprivate static let bundle = Bundle(for: InitialViewController.self)

    // MARK: View Controller's

    fileprivate lazy var navigationController: UINavigationController = {
        let navController = UINavigationController(rootViewController: self.initialViewController)
        return navController
    }()

    fileprivate lazy var initialViewController: InitialViewController! = {
        let viewController = InitialViewController()
        self.configure(controller: viewController)
        viewController.delegate = self
        return viewController
    }()

    fileprivate lazy var loginViewController: LoginViewController! = {
        let viewController = LoginViewController()
        self.configure(controller: viewController)
        viewController.delegate = self
        return viewController
    }()

    fileprivate lazy var signupViewController: SignupViewController! = {
        let viewController = SignupViewController()
        self.configure(controller: viewController)
        viewController.delegate = self
        return viewController
    }()

    fileprivate lazy var passwordViewController: PasswordViewController! = {
        let viewController = PasswordViewController()
        self.configure(controller: viewController)
        viewController.delegate = self
        return viewController
    }()

    // MARK: Services

    fileprivate lazy var facebookService = FacebookService()

    // MARK: - Setup

    func configure(controller: Configurable) {
        var config = Configuration()
        config.backgroundImage = backgroundImage
        config.logoImage = logoImage
        config.tintColor = tintColor
        config.signupButtonText = signupButtonText
        config.loginButtonText = loginButtonText
        config.facebookButtonText = facebookButtonText
        config.forgotPasswordText = forgotPasswordText
        config.recoverPasswordText = recoverPasswordText
        config.emailPlaceholder = emailPlaceholder
        config.passwordPlaceholder = passwordPlaceholder
        config.repeatPasswordPlaceholder = repeatPasswordPlaceholder
        config.namePlaceholder = namePlaceholder
        controller.configuration = config
    }

    // MARK: - LoginCoordinator

    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        self.window = nil
    }

    public init(window: UIWindow) {
        self.window = window
        self.rootViewController = nil
    }

    open func start() {
        if let rootViewController = rootViewController {
            rootViewController.present(navigationController, animated: true, completion: nil)
        } else if let window = window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }

    open func finish() {
        if let rootViewController = rootViewController {
            rootViewController.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - Callbacks, Meant to be subclassed

    open func login(email: String, password: String) {
        print("Implement this method in your subclass to handle login.")
    }

    open func signup(name: String, email: String, password: String) {
        print("Implement this method in your subclass to handle signup.")
    }

    open func enterWithFacebook(profile: FacebookProfile) {
        print("Implement this method in your subclass to handle facebook.")
    }

    open func recoverPassword(email: String) {
        print("Implement this method in your subclass to handle password recovery.")
    }

}

// MARK: - Navigation

private extension LoginCoordinator {

    func goToLogin() {
        navigationController.pushViewController(loginViewController, animated: true)
    }

    func goToSignup() {
        navigationController.pushViewController(signupViewController, animated: true)
    }

    func goToPassword() {
        navigationController.pushViewController(passwordViewController, animated: true)
    }

    func pop() {
        _ = navigationController.popViewController(animated: true)
    }

}

// MARK: - View Controller Callbacks

extension LoginCoordinator: InitialViewControllerDelegate {

    func didSelectLogin(_ viewController: UIViewController) {
        goToLogin()
    }

    func didSelectSignup(_ viewController: UIViewController) {
        goToSignup()
    }

    func didSelectFacebook(_ viewController: UIViewController) {
        facebookService.login(from: viewController) { (result) in
            switch result {
            case .success(let profile):
                print("SUCCESS: FB PROFILE = \(profile)")
                self.enterWithFacebook(profile: profile)
            default:
                break
            }
        }
    }

}

extension LoginCoordinator: LoginViewControllerDelegate {

    func didSelectLogin(_ viewController: UIViewController, email: String, password: String) {
        login(email: email, password: password)
    }

    func didSelectForgotPassword(_ viewController: UIViewController) {
        goToPassword()
    }

    func loginDidSelectBack(_ viewController: UIViewController) {
        pop()
        loginViewController = nil
    }
}

extension LoginCoordinator: SignupViewControllerDelegate {

    func didSelectSignup(_ viewController: UIViewController, email: String, name: String, password: String) {
        signup(name: name, email: email, password: password)
    }

    func signupDidSelectBack(_ viewController: UIViewController) {
        pop()
        signupViewController = nil
    }

}

extension LoginCoordinator: PasswordViewControllerDelegate {

    func didSelectRecover(_ viewController: UIViewController, email: String) {
        recoverPassword(email: email)
    }

    func passwordDidSelectBack(_ viewController: UIViewController) {
        pop()
        passwordViewController = nil
    }

}
