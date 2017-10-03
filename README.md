# LoginKit

[![Version](https://img.shields.io/cocoapods/v/ILLoginKit.svg?style=flat)](http://cocoapods.org/pods/ILLoginKit)
[![License](https://img.shields.io/cocoapods/l/ILLoginKit.svg?style=flat)](http://cocoapods.org/pods/ILLoginKit)
[![Platform](https://img.shields.io/cocoapods/p/ILLoginKit.svg?style=flat)](http://cocoapods.org/pods/ILLoginKit)
![Made with Love by Icalia Labs](https://img.shields.io/badge/With%20love%20by-Icalia%20Labs-ff3434.svg)

## About

LoginKit is a quick and easy way to add Facebook and email Login/Signup UI to your app. If you need to quickly prototype an app, create an MVP or finish an app for a hackathon, LoginKit can help you by letting you focus on what makes your app special and leave login/signup to LoginKit. But if what you really want is a really specific and customized login/singup flow you are probably better off creating it on your own.

LoginKit handles Signup & Login, via Facebook & Email. It takes care of the UI, the forms, validation, and Facebook SDK access. All you need to do is start LoginKit, and then make the necessary calls to your own backend API to login or signup.

**This is a simple example of how your login can look. Check out the example project to see how this was done and tinker around with it.** 

<img src="http://danielozano.com/images/1small.png" width="210"><img src="http://danielozano.com/images/2small.png" width="210"><img src="http://danielozano.com/images/3small.png" width="210"><img src="http://danielozano.com/images/4small.png" width="210">

**This other example is LoginKit in use in one of our client apps.** 

<img src="http://danielozano.com/images/1bsmall.png" width="210"><img src="http://danielozano.com/images/2bsmall.png" width="210"><img src="http://danielozano.com/images/3bsmall.png" width="210"><img src="http://danielozano.com/images/4bsmall.png" width="210">

## Requirements

## Installation

LoginKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ILLoginKit"
```

## Getting Started

### Login Coordinator

Everything is handled through the **LoginCoordinator** class. You insantiate it and pass the root view controller which is the UIViewController from which the LoginKit process will be started (presented) on. This will usually be self.

```swift
import LoginKit

class ViewController: UIViewController { 

    lazy var loginCoordinator: LoginCoordinator = {
        return LoginCoordinator(rootViewController: self)
    }()
    
    ...

    func showLogin() {
        loginCoordinator.start()
    }
    
    ...

}
```

Afterwards call start on the coordinator. That's it!

### Customization

Of course you will want to customize the Login Coordinator to be able to supply your own UI personalization, and to perform the necessary actions on login or signup.

That is done by subclassing the LoginCoordinator class.

```swift

class LoginCoordinator: ILLoginKit.LoginCoordinator {

}

```

### Start

Handle anything you want to happen when LoginKit starts. Make sure to call super.

```swift
override func start() {
    super.start()
    configureAppearance()
}
```

### Configuration

You can set any of these properties on the superclass to change the way LoginKit looks. Besides the images, all other properties have defaults, no need to set them if you don't need them.

| Property  |  Effect      |
|----------|:-------------:|
| backgroundImage |  The background image that will be used in all ViewController's.  | 
| mainLogoImage |  A logo image that will be used in the initial ViewController.  | 
| secondaryLogoImage |  A smaller logo image that will be used on all ViewController's except the initial one.  | 
| tintColor |  The tint color for the button text and background color.  | 
| errorTintColor |  The tint color for error texts. | 
| loginButtonText |  The text for the login button.  | 
| signupButtonText |  The text for the signup button.  | 
| facebookButtonText |  The text for the facebook button.  | 
| forgotPasswordButtonText |  The text for the forgot password button.  | 
| recoverPasswordButtonText |  The text for the recover password button.  | 
| namePlaceholder |  The placeholder that will be used in the name text field.  | 
| emailPlaceholder |  The placeholder that will be used in the email text field.  | 
| passwordPlaceholder |  The placeholder that will be used in the password text field.  | 
| repeatPasswordPlaceholder |  The placeholder that will be used in the repeat password text field.  | 

```swift
// Customize LoginKit. All properties have defaults, only set the ones you want.
func configureAppearance() {
    // Customize the look with background & logo images
    backgroundImage = 
    mainLogoImage =
    secondaryLogoImage =

    // Change colors
    tintColor = UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1)
    errorTintColor = UIColor(red: 253.0/255.0, green: 227.0/255.0, blue: 167.0/255.0, alpha: 1)

    // Change placeholder & button texts, useful for different marketing style or language.
    loginButtonText = "Sign In"
    signupButtonText = "Create Account"
    facebookButtonText = "Login with Facebook"
    forgotPasswordButtonText = "Forgot password?"
    recoverPasswordButtonText = "Recover"
    namePlaceholder = "Name"
    emailPlaceholder = "E-Mail"
    passwordPlaceholder = "Password!"
    repeatPasswordPlaceholder = "Confirm password!"
}
```

### Completion Callbacks

Override these other 4 callback methods to handle what happens after the user tries to login, signup, recover password or enter with facebook.

Here you would call your own API.

```swift
// Handle login via your API
override func login(email: String, password: String) {
    print("Login with: email =\(email) password = \(password)")
}

// Handle signup via your API
override func signup(name: String, email: String, password: String) {
    print("Signup with: name = \(name) email =\(email) password = \(password)")
}

// Handle Facebook login/signup via your API
override func enterWithFacebook(profile: FacebookProfile) {
    print("Login/Signup via Facebook with: FB profile =\(profile)")
}

// Handle password recovery via your API
override func recoverPassword(email: String) {
    print("Recover password with: email =\(email)")
}
```

### Finish

After successfull login call the finish() method on LoginCoordinator. Be sure to call super.

```swift
override func finish() {
    super.finish()
}
```

### Code

The final result would look something like this.

```swift
import Foundation
import ILLoginKit

class LoginCoordinator: ILLoginKit.LoginCoordinator {

    // MARK: - LoginCoordinator

    override func start() {
        super.start()
        configureAppearance()
    }

    override func finish() {
        super.finish()
    }

    // MARK: - Setup

    // Customize LoginKit. All properties have defaults, only set the ones you want.
    func configureAppearance() {
        // Customize the look with background & logo images
        backgroundImage = #imageLiteral(resourceName: "Background")
        // mainLogoImage =
        // secondaryLogoImage =

        // Change colors
        tintColor = UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1)
        errorTintColor = UIColor(red: 253.0/255.0, green: 227.0/255.0, blue: 167.0/255.0, alpha: 1)

        // Change placeholder & button texts, useful for different marketing style or language.
        loginButtonText = "Sign In"
        signupButtonText = "Create Account"
        facebookButtonText = "Login with Facebook"
        forgotPasswordButtonText = "Forgot password?"
        recoverPasswordButtonText = "Recover"
        namePlaceholder = "Name"
        emailPlaceholder = "E-Mail"
        passwordPlaceholder = "Password!"
        repeatPasswordPlaceholder = "Confirm password!"
    }

    // MARK: - Completion Callbacks

    // Handle login via your API
    override func login(email: String, password: String) {
        print("Login with: email =\(email) password = \(password)")
    }
    
    // Handle signup via your API
    override func signup(name: String, email: String, password: String) {
        print("Signup with: name = \(name) email =\(email) password = \(password)")
    }

    // Handle Facebook login/signup via your API
    override func enterWithFacebook(profile: FacebookProfile) {
        print("Login/Signup via Facebook with: FB profile =\(profile)")
    }

    // Handle password recovery via your API
    override func recoverPassword(email: String) {
        print("Recover password with: email =\(email)")
    }

}
```

## Author

Daniel Lozano, dan@danielozano.com

## License

LoginKit is available under the MIT license. See the LICENSE file for more info.
