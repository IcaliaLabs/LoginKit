//
//  SignupViewController.swift
//  LoginKit
//
//  Created by Daniel Lozano Valdés on 12/8/16.
//  Copyright © 2016 danielozano. All rights reserved.
//

import UIKit
import Validator

protocol SignupViewControllerDelegate: class {

    func didSelectSignup(_ viewController: UIViewController, email: String, name: String, password: String)

    func signupDidSelectBack(_ viewController: UIViewController)

}

class SignupViewController: UIViewController, KeyboardMovable, BackgroundMovable {

    // MARK: - Properties

    weak var delegate: SignupViewControllerDelegate?

    var configuration: ConfigurationSource?

    var signupAttempted = false

    var signupInProgress = false {
        didSet {
            signupButton.isEnabled = !signupInProgress
        }
    }

    // MARK: Keyboard Movable

    var selectedField: UITextField?

    var offset: CGFloat = 0.0

    // MARK: Background Movable

    var movableBackground: UIView {
        get {
            return backgroundImageView
        }
    }

    // MARK: Outlet's

    @IBOutlet var fields: [SkyFloatingLabelTextField]!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var repeatPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var backgroundImageView: GradientImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var signupButton: Buttn!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupValidation()
        initKeyboardMover()
        initBackgroundMover()
        customizeAppearance()
    }

    override func loadView() {
        self.view = viewFromNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        destroyKeyboardMover()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Setup

    func customizeAppearance() {
        setupConfiguration()
        setupFonts()
    }
    
    func setupConfiguration() {
        guard let config = configuration else {
            return
        }

        view.backgroundColor = config.tintColor
        signupButton.setTitle(config.signupButtonText, for: .normal)

        backgroundImageView.image = config.backgroundImage
		backgroundImageView.gradientType = config.backgroundImageGradient ? .normalGradient : .none
        backgroundImageView.gradientColor = config.tintColor
        backgroundImageView.fadeColor = config.tintColor
        logoImageView.image = config.secondaryLogoImage

        emailTextField.placeholder = config.emailPlaceholder
        emailTextField.errorColor = config.errorTintColor
        nameTextField.placeholder = config.namePlaceholder
        nameTextField.errorColor = config.errorTintColor
        passwordTextField.placeholder = config.passwordPlaceholder
        passwordTextField.errorColor = config.errorTintColor
        repeatPasswordTextField.placeholder = config.repeatPasswordPlaceholder
        repeatPasswordTextField.errorColor = config.errorTintColor
    }

    func setupFonts() {
        nameTextField.font = Font.montserratRegular.get(size: 13)
        emailTextField.font = Font.montserratRegular.get(size: 13)
        passwordTextField.font = Font.montserratRegular.get(size: 13)
        repeatPasswordTextField.font = Font.montserratRegular.get(size: 13)
        signupButton.titleLabel?.font = Font.montserratRegular.get(size: 15)
    }

    // MARK: - Action's

    @IBAction func didSelectBack(_ sender: AnyObject) {
        delegate?.signupDidSelectBack(self)
    }

    @IBAction func didSelectSignup(_ sender: AnyObject) {
        guard let email = emailTextField.text, let name = nameTextField.text, let password = passwordTextField.text else {
            return
        }

        signupAttempted = true
        validateFields {
            delegate?.didSelectSignup(self, email: email, name: name, password: password)
        }
    }

}

// MARK: - Validation

extension SignupViewController {

    var equalPasswordRule: ValidationRuleEquality<String> {
        return ValidationRuleEquality<String>(dynamicTarget: { self.passwordTextField.text ?? "" },
                                              error: ValidationError.passwordNotEqual)
    }

    func setupValidation() {
        setupValidationOn(field: nameTextField, rules: ValidationService.nameRules)
        setupValidationOn(field: emailTextField, rules: ValidationService.emailRules)

        var passwordRules = ValidationService.passwordRules
        setupValidationOn(field: passwordTextField, rules: passwordRules)
        passwordRules.add(rule: equalPasswordRule)
        setupValidationOn(field: repeatPasswordTextField, rules: passwordRules)
    }

    func setupValidationOn(field: SkyFloatingLabelTextField, rules: ValidationRuleSet<String>) {
        field.validationRules = rules
        field.validateOnInputChange(enabled: true)
        field.validationHandler = validationHandlerFor(field: field)
    }

    func validationHandlerFor(field: SkyFloatingLabelTextField) -> ((ValidationResult) -> Void) {
        return { result in
            switch result {
            case .valid:
                guard self.signupAttempted == true else {
                    break
                }
                field.errorMessage = nil
            case .invalid(let errors):
                guard self.signupAttempted == true else {
                    break
                }
                if let errors = errors as? [ValidationError] {
                    field.errorMessage = errors.first?.message
                }
            }
        }
    }

    func validateFields(success: () -> Void) {
        var errorFound = false
        for field in fields {
            let result = field.validate()
            switch result {
            case .valid:
                field.errorMessage = nil
            case .invalid(let errors):
                errorFound = true
                if let errors = errors as? [ValidationError] {
                    field.errorMessage = errors.first?.message
                }
            }
        }
        if !errorFound {
            success()
        }
    }

}

// MARK: - UITextField Delegate

extension SignupViewController : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        selectedField = nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()

        let nextTag = textField.tag + 1
        let nextResponder = view.viewWithTag(nextTag) as UIResponder!

        if nextResponder != nil {
            nextResponder?.becomeFirstResponder()
        } else {
            didSelectSignup(self)
        }
        
        return false
    }
    
}
