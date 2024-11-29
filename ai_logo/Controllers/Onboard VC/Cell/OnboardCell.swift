//
//  OnboardCell.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/25/24.
//

import UIKit

class OnboardCell: UICollectionViewCell {

    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    var buttonActionClosure: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async { [weak self] in
            
            self?.applyGradientToButton()

        }
    }
    
    
    @IBAction func btnStart(_ sender: Any) {
        buttonActionClosure?()
    }
    

    private func applyGradientToButton() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.accent.cgColor, UIColor.kRed.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)   // Bottom-right corner
        gradientLayer.frame = btnStart.bounds
        gradientLayer.cornerRadius = btnStart.layer.cornerRadius
        btnStart.layer.masksToBounds = true

        // Remove any existing gradient layers to avoid layering multiple gradients
        btnStart.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        btnStart.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}
