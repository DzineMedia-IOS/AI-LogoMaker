//
//  UiTextField+icon.swift
//  PDF Converter
//
//  Created by MacBook on 08/12/2022.
//

import UIKit

@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
}

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var startColor: UIColor = UIColor.black { // Default light blue
        didSet {
            updateGradientColors()
        }
    }

    @IBInspectable var endColor: UIColor = UIColor.white { // Default darker blue
        didSet {
            updateGradientColors()
        }
    }

    @IBInspectable var startPointX: CGFloat = 0 {
        didSet {
            updateGradientPoints()
        }
    }

    @IBInspectable var startPointY: CGFloat = 0 {
        didSet {
            updateGradientPoints()
        }
    }

    @IBInspectable var endPointX: CGFloat = 1 {
        didSet {
            updateGradientPoints()
        }
    }

    @IBInspectable var endPointY: CGFloat = 1 {
        didSet {
            updateGradientPoints()
        }
    }

    private var gradientLayer: CAGradientLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientLayer()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        layer.insertSublayer(gradientLayer, at: 0)
    }

    private func updateGradientColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }

    private func updateGradientPoints() {
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
    }
}
