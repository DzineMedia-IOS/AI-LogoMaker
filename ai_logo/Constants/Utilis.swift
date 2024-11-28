//
//  Utilis.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import Foundation
import UIKit
func applyGradientToButton(
    button: UIButton,
    colors: [UIColor],
    startPoint: CGPoint = CGPoint(x: 0, y: 0),
    endPoint: CGPoint = CGPoint(x: 1, y: 1),
    isBottomCorner: Bool? = false
) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = colors.map { $0.cgColor }
    gradientLayer.startPoint = startPoint
    gradientLayer.endPoint = endPoint
    gradientLayer.frame = button.bounds
    gradientLayer.cornerRadius = button.layer.cornerRadius
    button.layer.masksToBounds = true
    
    if isBottomCorner == true{
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }


    // Remove any existing gradient layers to avoid layering multiple gradients
    button.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

    // Insert the gradient layer
    button.layer.insertSublayer(gradientLayer, at: 0)
}


extension UILabel {
    func applyGradient(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
        
        // Apply the gradient layer
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        // Ensure the text remains visible
        self.textColor = .clear
        self.layer.masksToBounds = true
        
        // Add a mask to apply gradient to text only
        let textMask = CATextLayer()
        textMask.string = self.text
        textMask.font = self.font
        textMask.fontSize = self.font.pointSize
        textMask.frame = self.bounds
        textMask.alignmentMode = .center
        textMask.contentsScale = UIScreen.main.scale
        gradientLayer.mask = textMask
    }
}


import UIKit

extension UIView {
    func applyGradientBorder(colors: [UIColor], lineWidth: CGFloat) {
        // Remove any existing gradient layers to avoid duplication
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds.insetBy(dx: -lineWidth, dy: -lineWidth) // Slightly larger frame
//        gradientLayer.frame = self.bounds


        // Create a shape layer for the precise border path
        let maskLayer = CAShapeLayer()
        let roundedPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius)
        maskLayer.path = roundedPath.cgPath
        maskLayer.lineWidth = lineWidth
        maskLayer.strokeColor = UIColor.black.cgColor
        maskLayer.fillColor = UIColor.clear.cgColor

        // Apply mask to gradient
        let borderLayer = CAShapeLayer()
        borderLayer.path = roundedPath.cgPath
        borderLayer.lineWidth = lineWidth
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        gradientLayer.mask = borderLayer


        // Add the gradient layer to the view
        self.layer.addSublayer(gradientLayer)
    }
}
