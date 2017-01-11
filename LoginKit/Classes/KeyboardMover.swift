//
//  KeyboardMover.swift
//  OneUP
//
//  Created by Daniel Lozano on 4/26/16.
//  Copyright © 2016 Icalia Labs. All rights reserved.
//

import Foundation
import ObjectiveC
import UIKit

struct KeyboardMovableKeys {

    static var keyboardShowObserver = "km_keyboardShowObserver"
    static var keyboardHideObserver = "km_keyboardHideObserver"

}

protocol KeyboardMovable: class {

    var selectedField: UITextField? { get }
    var offset: CGFloat { get set }

}

extension KeyboardMovable where Self: UIViewController {

    var notificationCenter: NotificationCenter { return .default }

    var keyboardShowObserver: NSObjectProtocol? {
        get {
            return objc_getAssociatedObject(self, &KeyboardMovableKeys.keyboardShowObserver) as? NSObjectProtocol
        }
        set(newValue) {
            objc_setAssociatedObject(self,
                                     &KeyboardMovableKeys.keyboardShowObserver,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    var keyboardHideObserver: NSObjectProtocol? {
        get {
            return objc_getAssociatedObject(self, &KeyboardMovableKeys.keyboardHideObserver) as? NSObjectProtocol
        }
        set(newValue) {
            objc_setAssociatedObject(self,
                                     &KeyboardMovableKeys.keyboardHideObserver,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    func initKeyboardMover() {
        keyboardShowObserver = notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { notification in
            self.keyboardWillShow(notification)
        }
        keyboardHideObserver =  notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { notification in
            self.keyboardWillHide(notification)
        }
    }

    func destroyKeyboardMover() {
        if let showObserver = keyboardShowObserver {
            notificationCenter.removeObserver(showObserver)
        }
        if let hideObserver = keyboardHideObserver {
            notificationCenter.removeObserver(hideObserver)
        }
    }

    func keyboardWillShow(_ notification: Notification) {
        guard let info: NSDictionary = (notification as NSNotification).userInfo as NSDictionary? else {
            return
        }

        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight: CGFloat = keyboardSize.height
        let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat

        animate(directionUp: true, keyboardHeight: keyboardHeight)
    }

    func keyboardWillHide(_ notification: Notification) {
        guard let info: NSDictionary = (notification as NSNotification).userInfo as NSDictionary? else {
            return
        }

        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight: CGFloat = keyboardSize.height
        let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat

        animate(directionUp: false, keyboardHeight: keyboardHeight)
    }

    func animate(directionUp: Bool, keyboardHeight: CGFloat) {
        guard let selectedField = selectedField else {
            print("KEYBOARD MOVER: MUST PROVIDE A SELECTED FIELD: ABORTING.")
            return
        }

        let fieldPoint = CGPoint(x: 0, y: selectedField.frame.origin.y + selectedField.frame.size.height)
        let visibleRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - keyboardHeight)

        print("FRAME = \(selectedField.frame)") // TODO: WHY IS FRAME ORIGIN 0,0 ???

        if visibleRect.contains(fieldPoint) {
            print("FIELD VISIBLE: NOT MOVING")
        } else {
            print("FIELD NOT VISIBLE: MOVING")
            // RESET FRAME
            view.frame = view.frame.offsetBy(dx: 0, dy: -offset)

            UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions(), animations: {

                if directionUp {
                    let fieldCenter = selectedField.center
                    let centerInVisibleRect = CGPoint(x: visibleRect.width / 2, y: visibleRect.height / 2)

                    let y1 = centerInVisibleRect.y
                    let y2 = fieldCenter.y
                    self.offset = (y1 - y2)

                    self.view.frame = self.view.frame.offsetBy(dx: 0, dy: self.offset)
                } else {
                    self.offset = 0.0
                }

            }, completion: nil)
        }
    }

}
