//
//  LogoTypeCell.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit

class LogoTypeCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        backView.applyGradientBorder(colors: [UIColor.kRed,UIColor.accent], lineWidth: 2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Ensure the gradient is applied to the correct size of `backView`
        //           DispatchQueue.main.async { [weak self] in
        //               self?.applyGradientToBackView()
        //           }
    }
    
    func applyGradientToBackView() {
        backView.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        backView.applyGradientBorder(colors: [UIColor.kRed, UIColor.accent], lineWidth: 2)
    }
    
    func applyGradientToLbl(){
        lblTitle.applyGradient(
            colors: [UIColor.kRed, UIColor.accent],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1))
        
    }
    
    
}
