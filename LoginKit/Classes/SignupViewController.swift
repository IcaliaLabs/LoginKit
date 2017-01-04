//
//  SignupViewController.swift
//  LoginKit
//
//  Created by Daniel Lozano Valdés on 12/8/16.
//  Copyright © 2016 danielozano. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol SignupViewControllerDelegate: class {

    func didSelectSignup(_ viewController: UIViewController, email: String, name: String, password: String)
    func didSelectBack(_ viewController: UIViewController)

}

class SignupViewController: UIViewController, KeyboardMovable, BackgroundMovable {

    // MARK: - Properties

    weak var delegate: SignupViewControllerDelegate?

    var backgroundImage: UIImage?

    var signupInProgress = false

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
    @IBOutlet weak var backgroundImageView: UIImageView!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        initKeyboardMover()
        customizeAppearance()
        initBackgroundMover()
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
        if let backgroundImage = backgroundImage {
            backgroundImageView.image = backgroundImage
        }
    }

    // MARK: - Action's

    @IBAction func didSelectBack(_ sender: AnyObject) {
        delegate?.didSelectBack(self)
    }

    @IBAction func didSelectSignup(_ sender: AnyObject) {
        // validator.validate(self)
        delegate?.didSelectSignup(self, email: "", name: "", password: "")
    }

}

// MARK: - Validation

extension SignupViewController {

//    func setupValidation() {
//        validator.registerField(emailTextField, rules: [RequiredRule(), EmailRule()])
//        validator.registerField(passwordTextField, rules: [RequiredRule(), LengthPasswordRule()])
//        validator.registerField(repeatPasswordTextField, rules: [RequiredRule(), LengthPasswordRule(),
//                                                                 ConfirmationRule(confirmField: passwordTextField)])
//        validator.registerField(nameTextField, rules: [RequiredRule(), FullNameRule()])
//    }
//
//    func resetFields() {
//        for field in fields {
//            field.errorMessage = nil
//        }
//    }
//
//    // MARK: Validation Delegate
//
//    func validationSuccessful() {
//        guard let fullName = nameTextField.text, let email = emailTextField.text else {
//            return
//        }
//
//        let fullNameArray = fullName.components(separatedBy: " ")
//        guard let firstName = fullNameArray.first, let lastName = fullNameArray.last else {
//            return
//        }
//
//        resetFields()
//        let user = User(userId: nil, email: email, firstName: firstName, lastName: lastName, facebookConnected: nil, notification: nil, deviceToken: nil, subscriptions: nil)
//        user.password = passwordTextField.text ?? ""
//        signup(user)
//    }
//
//    public func validationFailed(_ errors: [(Validatable, ValidationError)]) {
//        print("VALIDATION FAILED")
//        resetFields()
//
//        for (field, error) in errors {
//            if let textField = field as? SkyFloatingLabelTextField {
//                textField.errorMessage = error.errorMessage
//                print("ERROR: \(error.errorMessage)")
//            }
//        }
//    }

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
        let nextTag = textField.tag + 1
        let nextResponder = view.viewWithTag(nextTag) as UIResponder!

        if nextResponder != nil {
            nextResponder?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didSelectSignup(self)
        }
        
        return false
    }
    
}
