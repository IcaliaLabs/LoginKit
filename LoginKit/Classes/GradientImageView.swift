//
//  GradientImageView.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 12/12/16.
//
//

import UIKit

class GradientImageView: UIImageView {

    @IBInspectable public var gradientColor: UIColor = UIColor.black {
        didSet { self.drawBackground() }
    }

    @IBInspectable public var fadeColor: UIColor = UIColor.black {
        didSet { self.drawBackground() }
    }

    @IBInspectable public var fadeAlpha: Float = 0.3 {
        didSet { self.drawBackground() }
    }

    var hasDrawnBackground = false

    private let clearColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

    private var alphaLayer: CALayer?

    private var gradientLayer: CAGradientLayer?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // drawBackground()
    }

    override init(image: UIImage?) {
        super.init(image: image)
        // drawBackground()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        // drawBackground()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        drawBackground()
    }

    func drawBackground() {
        guard hasDrawnBackground == false else {
            return
        }

        gradientLayer?.removeFromSuperlayer()
        alphaLayer?.removeFromSuperlayer()

        gradientLayer = CAGradientLayer()
        alphaLayer = CALayer()

        //gradientLayer!.frame = bounds
        //gradientLayer!.colors = [gradientColor.cgColor, clearColor.cgColor]
        // gradientLayer!.locations = [0.8, 1]
        //gradientLayer!.locations = [0, 0.4]

        alphaLayer!.frame = bounds
        alphaLayer!.backgroundColor = fadeColor.cgColor
        alphaLayer!.opacity = fadeAlpha

        layer.insertSublayer(gradientLayer!, at: 0)
        layer.insertSublayer(alphaLayer!, above: gradientLayer)

        hasDrawnBackground = true
    }
    
}

