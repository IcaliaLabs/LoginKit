//
//  GradientImageView.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 12/12/16.
//
//

import UIKit

class GradientImageView: UIImageView {

	var gradientType: GradientType = .normalGradient {
		didSet {
			updateBackground()
		}
	}

	enum GradientType {
		case normalGradient
		case none
	}

    @IBInspectable public var gradientColor: UIColor = UIColor.black {
        didSet {
            updateBackground()
        }
    }

    @IBInspectable public var fadeColor: UIColor = UIColor.black {
        didSet {
            updateBackground()
        }
    }

    @IBInspectable public var fadeAlpha: Float = 0.3 {
        didSet {
            updateBackground()
        }
    }

    private var alphaLayer: CALayer?
    private var gradientLayer: CAGradientLayer?
    private let clearColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateBackground()
    }

    override init(image: UIImage?) {
        super.init(image: image)
        updateBackground()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        updateBackground()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        alphaLayer?.frame = self.bounds
        gradientLayer?.frame = self.bounds
    }

    func updateBackground() {
        gradientLayer?.removeFromSuperlayer()
        alphaLayer?.removeFromSuperlayer()

		guard gradientType == .normalGradient else {
			return
		}

        gradientLayer = CAGradientLayer()
        alphaLayer = CALayer()

        gradientLayer!.frame = bounds
        gradientLayer!.colors = [clearColor.cgColor, gradientColor.cgColor]
        gradientLayer!.locations = [0, 0.8]

        alphaLayer!.frame = bounds
        alphaLayer!.backgroundColor = fadeColor.cgColor
        alphaLayer!.opacity = fadeAlpha

        layer.insertSublayer(gradientLayer!, at: 0)
        layer.insertSublayer(alphaLayer!, above: gradientLayer)
    }
    
}

