//
//  LoginCoordinator.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 12/12/16.
//
//

import Foundation

protocol ConfigurationSource: class {

    var backgroundImage: UIImage { get }
    var mainLogoImage: UIImage { get }
    var secondaryLogoImage: UIImage { get }

    var tintColor: UIColor { get }
    var errorTintColor: UIColor { get }

    var signupButtonText: String { get }
    var loginButtonText: String { get }
    var facebookButtonText: String { get }
    var forgotPasswordButtonText: String { get }
    var recoverPasswordButtonText: String { get }

    var emailPlaceholder: String { get }
    var passwordPlaceholder: String { get }
    var repeatPasswordPlaceholder: String { get }
    var namePlaceholder: String { get }

    var shouldShowForgotPassword: Bool { get }

}

open class LoginCoordinator: ConfigurationSource {

    // MARK: - Properties

    public let window: UIWindow?

    public let rootViewController: UIViewController?

    // MARK: Public Configuration

    public var backgroundImage = UIImage()

    public var mainLogoImage = UIImage()

    public var secondaryLogoImage = UIImage()

    public var tintColor = UIColor(red: 185.0 / 255.0, green: 117.0 / 255.0, blue: 216.0 / 255.0, alpha: 1)

    public var errorTintColor = UIColor(red: 241 / 255, green: 196 / 255 , blue: 15 / 255, alpha: 1)

    public var signupButtonText = "SIGN UP"

    public var loginButtonText = "LOG IN"

    public var facebookButtonText = "CONNECT WITH FACEBOOK"

    public var forgotPasswordButtonText = "Forgot Password"

    public var recoverPasswordButtonText = "Recover Password"

    public var emailPlaceholder = "EMAIL"

    public var passwordPlaceholder = "PASSWORD"

    public var repeatPasswordPlaceholder = "REPEAT PASSWORD"

    public var namePlaceholder = "FULL NAME"

    public var shouldShowForgotPassword = true

    // MARK: Private

    fileprivate static let bundle = Bundle(for: InitialViewController.self)

    // MARK: View Controller's

    fileprivate lazy var navigationController: UINavigationController! = {
        let navController = UINavigationController(rootViewController: self.initialViewController)
        return navController
    }()

    fileprivate lazy var initialViewController: InitialViewController! = {
        let viewController = InitialViewController()
        viewController.delegate = self
        viewController.configurationSource = self
        return viewController
    }()

    fileprivate lazy var loginViewController: LoginViewController! = {
        let viewController = LoginViewController()
        viewController.delegate = self
        viewController.configurationSource = self
        return viewController
    }()

    fileprivate lazy var signupViewController: SignupViewController! = {
        let viewController = SignupViewController()
        viewController.delegate = self
        viewController.configurationSource = self
        return viewController
    }()

    fileprivate lazy var passwordViewController: PasswordViewController! = {
        let viewController = PasswordViewController()
        viewController.delegate = self
        viewController.configurationSource = self
        return viewController
    }()

    // MARK: Services

    public lazy var facebookService = FacebookService()

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
        
        navigationController = nil
        initialViewController = nil
        loginViewController = nil
        signupViewController = nil
        passwordViewController = nil
    }

    public func visibleViewController() -> UIViewController? {
        return navigationController.topViewController
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

// MARK: - Font Loading

enum Font: String {

    case montserratLight = "Montserrat-Light"
    case montserratRegular = "Montserrat-Regular"

    var type: String {
        switch self {
        case .montserratLight:
            return "otf"
        case .montserratRegular:
            return "ttf"
        }
    }

    func get(size: CGFloat = 15.0) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
    
}

let loadFonts = {
    print("Login Coordinator: Loading Fonts")
    let light = Font.montserratLight
    let regular = Font.montserratRegular
    let loadedLight = LoginCoordinator.loadFont(light.rawValue, type: light.type)
    let loadedRegular = LoginCoordinator.loadFont(regular.rawValue, type: regular.type)
    if loadedLight && loadedRegular {
        print("Login Coordinator: Loaded Fonts")
    } else {
        print("Login Coordinator: Failed Loading Fonts")
    }
}()

extension LoginCoordinator {

    static func loadFont(_ name: String, type: String) -> Bool {
        let bundle = Bundle(for: InitialViewController.self)

        guard let fontPath = bundle.path(forResource: name, ofType: type) else {
            return false
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: fontPath)) as CFData else {
            return false
        }

        guard let provider = CGDataProvider(data: data) else {
            return false
        }

        let font = CGFont(provider)
        var error: Unmanaged<CFError>?

        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        if !success {
            print("Error registering font. Font is possibly already registered.")
            return false
        }
        
        return true
    }

}
