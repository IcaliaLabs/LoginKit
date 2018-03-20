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

    var configuration: ConfigurationSource?

    // MARK: Background Movable

    var movableBackground: UIView {
        get {
            return backgroundImageView
        }
    }

    // MARK: Outlet's

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: GradientImageView!
    @IBOutlet weak var signupButton: Buttn!
    @IBOutlet weak var loginButton: Buttn!
    @IBOutlet weak var facebookButton: UIButton!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = loadFonts
        initBackgroundMover()
        customizeAppearance()
    }

    override func loadView() {
        view = viewFromNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Setup

    func customizeAppearance() {
        setupConfiguration()
        setupFonts()
        addShadows()
        navigationController?.isNavigationBarHidden = true
        navigationController?.delegate = self
    }

    func setupConfiguration() {
        guard let config = configuration else {
            return
        }

        backgroundImageView.image = config.backgroundImage
		backgroundImageView.gradientType = config.backgroundImageGradient ? .normalGradient : .none
        logoImageView.image = config.mainLogoImage

		if config.shouldShowSignupButton {
			signupButton.setTitle(config.signupButtonText, for: .normal)
			signupButton.setTitleColor(config.tintColor, for: .normal)
			signupButton.borderColor = config.tintColor.withAlphaComponent(0.25)
		} else {
			signupButton.isHidden = true
		}

		if config.shouldShowLoginButton {
			loginButton.setTitle(config.loginButtonText, for: .normal)
			loginButton.setTitleColor(config.tintColor, for: .normal)
			loginButton.borderColor = config.tintColor.withAlphaComponent(0.25)
		} else {
			loginButton.isHidden = true
		}

        facebookButton.setTitle(config.facebookButtonText, for: .normal)
    }

    func setupFonts() {
        loginButton.titleLabel?.font = Font.montserratRegular.get(size: 13)
        signupButton.titleLabel?.font = Font.montserratRegular.get(size: 13)
        facebookButton.titleLabel?.font = Font.montserratRegular.get(size: 15)
    }

    func addShadows() {
        facebookButton.layer.shadowOpacity = 0.3
        facebookButton.layer.shadowColor = UIColor(red: 89.0/255.0, green: 117.0/255.0, blue: 177.0/255.0, alpha: 1).cgColor
        facebookButton.layer.shadowOffset = CGSize(width: 15, height: 15)
        facebookButton.layer.shadowRadius = 7
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
