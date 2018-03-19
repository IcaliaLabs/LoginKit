//
//  ViewController.swift
//  LoginKit
//
//  Created by Daniel Lozano on 12/12/2016.
//  Copyright (c) 2016 Daniel Lozano. All rights reserved.
//

import UIKit
import ILLoginKit

class ViewController: UIViewController {

    lazy var loginCoordinator: LoginCoordinator = {
        return LoginCoordinator(rootViewController: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
		loginCoordinator.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

