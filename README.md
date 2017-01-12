# LoginKit

[![Version](https://img.shields.io/cocoapods/v/LoginKit.svg?style=flat)](http://cocoapods.org/pods/LoginKit)
[![License](https://img.shields.io/cocoapods/l/LoginKit.svg?style=flat)](http://cocoapods.org/pods/LoginKit)
[![Platform](https://img.shields.io/cocoapods/p/LoginKit.svg?style=flat)](http://cocoapods.org/pods/LoginKit)

LoginKit is a quick and easy way to add a Login/Signup UX to your app.

LoginKit handles Signup & Login, via Facebook & Email. It takes care of the UI, the forms, validation, and Facebook SDK access. All you need to do is start LoginKit, and then make the necessary calls to your own backend API to login or signup.

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

  func showLogin() {
     loginCoordinator.start()
  }

}
```

Afterwards call start on the coordinator. That's it!

### Customization

Of course you will want to customize the Login Coordinator to be able to supply your own UI personalization, and to perform the necessary actions on login or signup.

That is done by subclassing creating your own login coordinator subclassing the LoginCoordinator class.

```swift
import LoginKit

class MyLoginCoordinator: LoginCoordinator {
  
    // MARK: - Override these to customize the UI
  
    override var backgroundImage: UIImage {
        return UIImage()
    }

    override var logoImage: UIImage? {
        return UIImage()
    }
    
    //MARK: - Override these methods to handle login via your own API.
    
    override func login(email: String, password: String) {
        print("EMAIL = \(email), PASSWORD = \(password)")
        finish()
    }

    override func signup(name: String, email: String, password: String) {
        print("NAME = \(name), EMAIL = \(email), PASSWORD = \(password)")
        finish()
    }

    override func enterWithFacebook(profile: FacebookProfile) {
        print("FACEBOOK PROFILE = \(profile)")
        finish()
    }

    override func recoverPassword(email: String) {
        print("EMAIL = \(email)")
        finish()
    }
  
}

```

All these overriden methods return everything you need to handle login or signup on your end. The enterWithFacebook(profile:) method hands you a FacebookProfile struct which holds the Name, Email, and Facebook ID of the user's Facebook account, if they chose to enter with that method.

After successfull login call the finish() method on LoginCoordinator.

## Author

Daniel Lozano, dan@danielozano.com

## License

LoginKit is available under the MIT license. See the LICENSE file for more info.
