//
//  FacebookService.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 12/23/16.
//
//

import Foundation
import FBSDKLoginKit

typealias FacebookCompletion = (FacebookResult) -> Void

enum FacebookResult {

    case success(FacebookProfile)
    case error(Error)
    case missingPermissions
    case unknownError
    case cancelled

}

public struct FacebookProfile {

    let facebookId: String
    let firstName: String
    let lastName: String
    let email: String
    
}

class FacebookService {

    let loginManager: FBSDKLoginManager = {
        let manager = FBSDKLoginManager()
        manager.loginBehavior = .systemAccount
        return manager
    }()

    let permissions = ["email", "public_profile"]

    func login(from viewController: UIViewController, completion: @escaping FacebookCompletion) {
        loginManager.logIn(withReadPermissions: permissions, from: viewController) { (result, error) in
            guard let result = result else {
                if let error = error {
                    print("FACEBOOK LOGIN: ERROR")
                    print(error)
                    completion(.error(error))
                    return
                } else {
                    print("FACEBOOK LOGIN: MISSING RESULT")
                    completion(.unknownError)
                    return
                }
            }

            if result.isCancelled {
                print("FACEBOOK LOGIN: CANCELLED")
                completion(.cancelled)
            } else {
                print("FACEBOOK LOGIN: SUCCESS")
                print("TOKEN: \(result.token)")
                print("PERMISSIONS: \(result.grantedPermissions)")
                if result.grantedPermissions.contains("email") && result.grantedPermissions.contains("public_profile") {
                    print("FACEBOOK LOGIN: PERMISSIONS GRANTED")
                    self.getUserInfo(completion: completion)
                } else {
                    print("FACEBOOK LOGIN: MISSING REQUIRED PERMISSIONS")
                    completion(.missingPermissions)
                }
            }
        }
    }

}

private extension FacebookService {

    func getUserInfo(completion: @escaping FacebookCompletion) {
        guard FBSDKAccessToken.current() != nil else {
            print("FACEBOOK: NOT LOGGED IN: ABORTING")
            completion(.unknownError)
            return
        }

        let params = ["fields" : "id, name, email"]

        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        _ = graphRequest?.start { (connection, result, error) in
            guard let userData = result as? [String : String] else {
                if let error = error {
                    print("FACEBOOK: GRAPH REQUEST: ERROR")
                    completion(.error(error))
                    return
                } else {
                    print("FACEBOOK: GRAPH REQUEST: MISSING RESULT")
                    completion(.unknownError)
                    return
                }
            }

            guard let facebookId = userData["id"], let fullName = userData["name"], let email = userData["email"] else {
                print("FACEBOOK: GRAPH REQUEST: MISSING DATA")
                completion(.unknownError)
                return
            }

            let fullNameArray = fullName.components(separatedBy: " ")
            guard let firstName = fullNameArray.first, let lastName = fullNameArray.last else {
                print("FACEBOOK: GRAPH REQUEST: MISSING DATA")
                completion(.unknownError)
                return
            }

            //let fbAccessToken = loginResult.token.tokenString as String

            print("FACEBOOK: GRAPH REQUEST: SUCCESS")
            print("USER DATA = \(userData)")
            let profile = FacebookProfile(facebookId: facebookId,
                                          firstName: firstName,
                                          lastName: lastName,
                                          email: email)
            completion(.success(profile))
        }
    }

}
