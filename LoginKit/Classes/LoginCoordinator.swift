//
//  LoginCoordinator.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 12/12/16.
//
//

import Foundation

open class LoginCoordinator {

    // MARK: - Properties

    fileprivate let rootViewController: UIViewController

    fileprivate lazy var bundle: Bundle = {
        return Bundle(for: InitialViewController.self)
    }()

    fileprivate lazy var navigationController: UINavigationController = {
        let navController = UINavigationController(rootViewController: self.initialViewController)
        return navController
    }()

    fileprivate lazy var initialViewController: InitialViewController = {
        let viewController = InitialViewController(nibName: "InitialViewController", bundle: self.bundle)
        viewController.delegate = self
        return viewController
    }()

    fileprivate lazy var loginViewController: LoginViewController = {
        let viewController = LoginViewController(nibName: "LoginViewController", bundle: self.bundle)
        viewController.delegate = self
        return viewController
    }()

    fileprivate lazy var signupViewController: SignupViewController = {
        let viewController = SignupViewController(nibName: "SignupViewController", bundle: self.bundle)
        viewController.delegate = self
        return viewController
    }()

    fileprivate lazy var passwordViewController: PasswordViewController = {
        let viewController = PasswordViewController(nibName: "PasswordViewController", bundle: self.bundle)
        viewController.delegate = self
        return viewController
    }()

    fileprivate lazy var facebookService: FacebookService = {
        let service = FacebookService()
        return service
    }()

    // MARK: - LoginCoordinator

    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    public func start() {
        rootViewController.present(navigationController, animated: true, completion: nil)
    }

    public func finish() {
        rootViewController.dismiss(animated: true, completion: nil)
    }

    // MARK: - Public/Subclassable methods

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

    func didSelectBack(_ viewController: UIViewController) {
        pop()
    }

}

extension LoginCoordinator: SignupViewControllerDelegate {

    func didSelectSignup(_ viewController: UIViewController, email: String, name: String, password: String) {
        signup(name: name, email: email, password: password)
    }

}

extension LoginCoordinator: PasswordViewControllerDelegate {

    func didSelectRecover(_ viewController: UIViewController, email: String) {
        recoverPassword(email: email)
    }

}
