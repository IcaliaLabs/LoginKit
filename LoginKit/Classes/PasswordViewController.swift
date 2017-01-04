//
//  PasswordViewController.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 12/12/16.
//
//

import UIKit
import Validator
import SkyFloatingLabelTextField

protocol PasswordViewControllerDelegate: class {

    func didSelectRecover(_ viewController: UIViewController, email: String)
    func passwordDidSelectBack(_ viewController: UIViewController)

}

class PasswordViewController: UIViewController, BackgroundMovable {

    // MARK: - Properties

    weak var delegate: PasswordViewControllerDelegate?

    var backgroundImage: UIImage?

    var recoverAttempted = false

    // MARK: Background Movable
    var movableBackground: UIView {
        get {
            return backgroundImageView
        }
    }

    // MARK: Outlet's

    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var recoverButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        initBackgroundMover()
        customizeAppearance()
        setupValidation()
    }

    override func loadView() {
        self.view = viewFromNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Setup

    func customizeAppearance() {
        backgroundImageView.image = backgroundImage
    }

    // MARK: - Action's

    @IBAction func didSelectBack(_ sender: AnyObject) {
        delegate?.passwordDidSelectBack(self)
    }

    @IBAction func didSelectRecover(_ sender: AnyObject) {
        recoverAttempted = true

        guard let email = emailTextField.text else {
            return
        }

        validateFields {
            delegate?.didSelectRecover(self, email: email)
        }
    }
    
}

// MARK: - Validation

extension PasswordViewController {

    func setupValidation() {
        setupValidationOn(field: emailTextField, rules: ValidationService.emailRules)
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
                guard self.recoverAttempted == true else {
                    break
                }
                field.errorMessage = nil
            case .invalid(let errors):
                guard self.recoverAttempted == true else {
                    break
                }
                if let errors = errors as? [ValidationError] {
                    field.errorMessage = errors.first?.message
                }
            }
        }
    }

    func validateFields(success: () -> Void) {
        let result = emailTextField.validate()
        switch result {
        case .valid:
            emailTextField.errorMessage = nil
            success()
        case .invalid(let errors):
            if let errors = errors as? [ValidationError] {
                emailTextField.errorMessage = errors.first?.message
            }
        }
    }

}
