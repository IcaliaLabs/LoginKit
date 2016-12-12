//
//  SignupViewController.swift
//  LoginKit
//
//  Created by Daniel Lozano Valdés on 12/8/16.
//  Copyright © 2016 danielozano. All rights reserved.
//

import UIKit

import SkyFloatingLabelTextField

class SignupViewController: UIViewController, KeyboardMovable, BackgroundMovable {

    // MARK: - Properties

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
        // setupValidation()
        initKeyboardMover()
        initBackgroundMover()
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

    // MARK: - Network

    func signup() {
        guard signupInProgress == false else {
            print("SIGNUP IN PROGRESS... ABORTING")
            return
        }

        signupInProgress = true
        // startActivityLoading()
        // session shared session signup
    }

    // MARK: - Action's

    @IBAction func didSelectBack(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func didSelectSignup(_ sender: AnyObject) {
        // validator.validate(self)
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
