//
//  InitialViewController.swift
//  LoginKit
//
//  Created by Daniel Lozano Valdés on 12/8/16.
//  Copyright © 2016 danielozano. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, BackgroundMovable {

    // MARK: - Properties

    var movableBackground: UIView {
        get {
            return backgroundImageView
        }
    }

    // MARK: Outlet's

    @IBOutlet weak var backgroundImageView: UIImageView!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        initBackgroundMover()
        navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - IBAction's

    @IBAction func didSelectSignup(_ sender: AnyObject) {
        // let controller = ViewController.signupViewController.getController(inNavController: false)
        // navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func didSelectLogin(_ sender: AnyObject) {
        // let controller = ViewController.loginViewController.getController(inNavController: false)
        // navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func didSelectFacebook(_ sender: AnyObject) {
        // facebookLogin()
    }

    // MARK: - Network

//    func facebookLogin() {
//        loginManager.logIn(withReadPermissions: permissions, from: self) { (result, error) in
//            if error != nil {
//                print("FACEBOOK LOGIN: ERROR")
//                print(error)
//            } else if let result = result {
//                if result.isCancelled {
//                    print("FACEBOOK LOGIN: CANCELLED")
//                } else {
//                    print("FACEBOOK LOGIN: SUCCESS")
//                    print("TOKEN: \(result.token)")
//                    print("PERMISSIONS: \(result.grantedPermissions)")
//
//                    if result.grantedPermissions.contains("email") && result.grantedPermissions.contains("public_profile") {
//                        print("FACEBOOK LOGIN: PERMISSIONS GRANTED")
//                        self.enterWithFacebook(result)
//                    } else {
//                        print("FACEBOOK LOGIN: MISSING REQUIRED PERMISSIONS")
//                    }
//                }
//            }
//        }
//    }
//
//    func enterWithFacebook(_ result: FBSDKLoginManagerLoginResult) {
//        Session.sharedSession.enterWithFacebook(result, completion: { (result) in
//            switch result {
//            case .success(let user, _, _):
//                print("SESSION : SIGNUP SUCCESS")
//                print("USER = \(user)")
//                LoginHelper.performLoginActions()
//            default:
//                print("TAP TO FUND API: LOGIN ERROR")
//                ErrorHandler.handleErrorIn(result, onViewController: self)
//            }
//        })
//    }

}

// MARK: - UINavigationController Delegate

extension InitialViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CrossDissolveAnimation()
    }
    
}
