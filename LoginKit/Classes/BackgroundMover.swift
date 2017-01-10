//
//  BackgroundMover.swift
//  OneUP
//
//  Created by Daniel Lozano on 4/26/16.
//  Copyright © 2016 Icalia Labs. All rights reserved.
//

import Foundation
import UIKit

protocol BackgroundMovable: class {

    var movableBackground: UIView { get }

}

extension BackgroundMovable {

    var verticalMotionEffect: UIInterpolatingMotionEffect {
        let effect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        effect.minimumRelativeValue = -20
        effect.maximumRelativeValue = 20
        return effect
    }

    var horizontalMotionEffect: UIInterpolatingMotionEffect {
        let effect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        effect.minimumRelativeValue = -20
        effect.maximumRelativeValue = 20
        return effect
    }

    func initBackgroundMover() {
        let group = UIMotionEffectGroup()
        group.motionEffects = [verticalMotionEffect, horizontalMotionEffect]
        movableBackground.addMotionEffect(group)
    }
    
}
