//
//  InitialViewController.swift
//  LoginKit
//
//  Created by Daniel Lozano Valdés on 12/8/16.
//  Copyright © 2016 danielozano. All rights reserved.
//

import UIKit

protocol InitialViewControllerDelegate: class {

    func didSelectSignup(_ viewController: UIViewController)

    func didSelectLogin(_ viewController: UIViewController)

    func didSelectFacebook(_ viewController: UIViewController)

}

class InitialViewController: UIViewController, BackgroundMovable {

    // MARK: - Properties

    weak var delegate: InitialViewControllerDelegate?

    weak var configurationSource: ConfigurationSource?

    // MARK: Background Movable

    var movableBackground: UIView {
        get {
            return backgroundImageView
        }
    }

    // MARK: Outlet's

    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var signupButton: Buttn!

    @IBOutlet weak var loginButton: Buttn!

    @IBOutlet weak var facebookButton: UIButton!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        initBackgroundMover()
        customizeAppearance()
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
        configureFromSource()

        navigationController?.isNavigationBarHidden = true
        navigationController?.delegate = self

        facebookButton.layer.shadowOpacity = 0.3
        facebookButton.layer.shadowColor = UIColor(red: 89.0 / 255.0, green: 117.0 / 255.0, blue: 177.0 / 255.0, alpha: 1).cgColor
        facebookButton.layer.shadowOffset = CGSize(width: 15, height: 15)
        facebookButton.layer.shadowRadius = 7
    }

    func configureFromSource() {
        guard let config = configurationSource else {
            return
        }

        backgroundImageView.image = config.backgroundImage
        logoImageView.image = config.logoImage
        signupButton.setTitle(config.signupButtonText, for: .normal)
        signupButton.setTitleColor(config.tintColor, for: .normal)
        signupButton.borderColor = config.tintColor.withAlphaComponent(0.25)
        loginButton.setTitle(config.loginButtonText, for: .normal)
        loginButton.setTitleColor(config.tintColor, for: .normal)
        loginButton.borderColor = config.tintColor.withAlphaComponent(0.25)
        facebookButton.setTitle(config.facebookButtonText, for: .normal)
    }

    // MARK: - Action's

    @IBAction func didSelectSignup(_ sender: AnyObject) {
        delegate?.didSelectSignup(self)
    }

    @IBAction func didSelectLogin(_ sender: AnyObject) {
        delegate?.didSelectLogin(self)
    }

    @IBAction func didSelectFacebook(_ sender: AnyObject) {
        delegate?.didSelectFacebook(self)
    }

}

// MARK: - UINavigationController Delegate

extension InitialViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CrossDissolveAnimation()
    }

}
