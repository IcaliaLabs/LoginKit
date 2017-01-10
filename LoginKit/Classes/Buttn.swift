//
//  Buttn.swift
//  OneUP
//
//  Created by Daniel Lozano on 5/17/16.
//  Copyright © 2016 Icalia Labs. All rights reserved.
//

import UIKit

public enum ButtnBorder: Int {

    case all
    case top
    case bottom
    case left
    case right
    case topBottom
    case leftRight

}

// TO-DO: - Rounded corners should be with a mask, to cover border AND background

public class Buttn: UIButton {

    @IBInspectable public var borderType: Int {
        get {
            return self.border.rawValue
        }
        set (index) {
            self.border = ButtnBorder(rawValue: index) ?? .all
        }
    }

    private var border: ButtnBorder = .all {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var borderWidth: Float = 1.0  {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var borderRadius: Float = 3.0  {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var borderColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5) {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable public var buttnColor: UIColor = UIColor.clear  {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        // TO-DO
    }

    // MARK: UIView

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard border != .all else {
            setLayerProperties()
            return
        }

        resetLayerProperties()

        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(borderColor.cgColor)
        context?.setLineWidth(CGFloat(borderWidth + 1))
        drawBorder(context, rect: rect)
        context?.strokePath()
    }

    func setLayerProperties() {
        layer.backgroundColor = buttnColor.cgColor
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = CGFloat(borderWidth)
        layer.cornerRadius = CGFloat(borderRadius)
    }

    func resetLayerProperties() {
        layer.backgroundColor = buttnColor.cgColor
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0.0
        layer.cornerRadius = 0.0
    }

    // MARK: - Drawing

    func drawBorder(_ context: CGContext?, rect: CGRect) {
        switch border {
        case .top:
            drawTopBorder(context, rect: rect)
        case .bottom:
            drawBottomBorder(context, rect: rect)
        case .right:
            drawRightBorder(context, rect: rect)
        case .left:
            drawLeftBorder(context, rect: rect)
        case .topBottom:
            drawTopBorder(context, rect: rect)
            drawBottomBorder(context, rect: rect)
        case .leftRight:
            drawLeftBorder(context, rect: rect)
            drawRightBorder(context, rect: rect)
        case .all:
            // Handled by default layer properties, no need to draw it ourselves
            break
        }
    }

    func drawTopBorder(_ context: CGContext?, rect: CGRect) {
        context?.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context?.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    }

    func drawBottomBorder(_ context: CGContext?, rect: CGRect) {
        context?.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context?.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    }

    func drawLeftBorder(_ context: CGContext?, rect: CGRect) {
        context?.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context?.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    }

    func drawRightBorder(_ context: CGContext?, rect: CGRect) {
        context?.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        context?.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    }

}
