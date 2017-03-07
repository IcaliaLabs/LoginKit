//
//  ValidatorService.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 1/4/17.
//
//

import Foundation
import Validator

enum ValidationError: String, Error {

    case invalidName = "Invalid name"
    case invalidEmail = "Invalid email address"
    case passwordLength = "Must be at least 8 characters"
    case passwordNotEqual = "Password does not match"

    var message: String {
        return self.rawValue
    }
    
}

public struct FullNameRule: ValidationRule {

    public typealias InputType = String

    public var error: Error

    public init(error: Error) {
        self.error = error
    }

    public func validate(input: String?) -> Bool {
        guard let input = input else {
            return false
        }

        let components = input.components(separatedBy: " ")

        guard components.count > 1 else {
            return false
        }

        guard let first = components.first, let last = components.last else {
            return false
        }
        
        guard first.characters.count > 1, last.characters.count > 1 else {
            return false
        }

        return true
    }

}

struct ValidationService {

    static var emailRules: ValidationRuleSet<String> {
        var emailRules = ValidationRuleSet<String>()
        emailRules.add(rule: emailRule)
        return emailRules
    }

    static var passwordRules: ValidationRuleSet<String> {
        var passwordRules = ValidationRuleSet<String>()
        passwordRules.add(rule: ValidationRuleLength(min: 8, error: ValidationError.passwordLength))
        return passwordRules
    }

    static var nameRules: ValidationRuleSet<String> {
        var nameRules = ValidationRuleSet<String>()
        nameRules.add(rule: FullNameRule(error: ValidationError.invalidName))
        return nameRules
    }

    // MARK: - Private

    private static var emailRule: ValidationRulePattern {
        return ValidationRulePattern(pattern: EmailValidationPattern.standard,
                                     error: ValidationError.invalidEmail)
    }

}
