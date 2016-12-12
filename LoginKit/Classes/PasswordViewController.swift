//
//  PasswordViewController.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 12/12/16.
//
//

import UIKit
import SkyFloatingLabelTextField

protocol PasswordViewControllerDelegate: class {

    func passwordDidSelectBack()
    func didSelectRecover(email: String)

}

class PasswordViewController: UIViewController, BackgroundMovable {

    // MARK: - Properties

    weak var delegate: PasswordViewControllerDelegate?

//    lazy var presenter = Presentr(presentationType: .alert)
//    lazy var alertController: UIViewController = {
//        let title = "Done!"
//        let body = "Check your email for instructions on resetting your password."
//        let controller = Presentr.alertViewController(title: title, body: body)
//        return controller
//    }()

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Action's

    @IBAction func didSelectBack(_ sender: AnyObject) {
        delegate?.passwordDidSelectBack()
    }

    @IBAction func didSelectRecover(_ sender: AnyObject) {
        guard let email = emailTextField.text else {
            return
        }

        // TODO: VALIDATE
        delegate?.didSelectRecover(email: email)
    }
    
}
