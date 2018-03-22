//
//  OverridenLoginViewController.swift
//  LoginKit_Example
//
//  Created by Daniel Lozano Valdés on 3/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ILLoginKit

class OverridenLoginViewController: LoginViewController {

    override func viewDidLoad() {
		configuration = Settings.defaultLoginConfig // configure before calling super
		super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
