//
//  Utilis.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import Foundation
import UIKit
import ProgressHUD
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
        gradientLayer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
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



extension UIView {
    func applyGradientBorder(colors: [UIColor], lineWidth: CGFloat) {
        // Remove existing gradient layers to avoid duplication
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Top-left corner
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)   // Bottom-right corner
//        gradientLayer.frame = self.bounds.insetBy(dx: -lineWidth, dy: -lineWidth) // Slightly larger frame for better blending
        gradientLayer.frame = self.bounds

        // For iPads, ensure proper bounds
        if UIDevice.current.userInterfaceIdiom == .pad {
//            gradientLayer.frame = self.bounds.insetBy(dx: -lineWidth, dy: -lineWidth)
            gradientLayer.frame = self.bounds
            
        }

        // Create a shape layer for the border path
        let maskLayer = CAShapeLayer()
        let roundedPath = UIBezierPath(roundedRect: self.bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2), cornerRadius: self.layer.cornerRadius)
        maskLayer.path = roundedPath.cgPath
        maskLayer.lineWidth = lineWidth
        maskLayer.strokeColor = UIColor.kRed.cgColor // Mask layer stroke (acts as the border outline)
        maskLayer.fillColor = UIColor.clear.cgColor

        // Apply mask to the gradient layer
        gradientLayer.mask = maskLayer

        // Add the gradient layer to the view's layer
        self.layer.addSublayer(gradientLayer)
    }

}


func configProgressHud() {
    ProgressHUD.animationType = .circleArcDotSpin
    ProgressHUD.colorBannerTitle = UIColor.white
    ProgressHUD.colorProgress = UIColor.white
    ProgressHUD.colorHUD = UIColor.red
    ProgressHUD.colorBackground = UIColor.black.withAlphaComponent(0.5)
    
}
