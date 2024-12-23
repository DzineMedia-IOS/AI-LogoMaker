//
//  LogoTypeCell.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit

class LogoTypeCell: UICollectionViewCell {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        backView.applyGradientBorder(colors: [UIColor.kRed,UIColor.accent], lineWidth: 2)
        
        if (UIDevice.current.userInterfaceIdiom == .pad){
            backView.layer.cornerRadius = backView.frame.height/3
            outerView.layer.cornerRadius = outerView.frame.height/3
            
            
        }
        //        backView.layer.cornerRadius = backView.frame.height/6
        
    }
    
    
    
    func applyGradientToBackView() {
        backView.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        var width = 2
        if ( UIDevice.current.userInterfaceIdiom == .pad ){
            width = 4
        }
        backView.applyGradientBorder(colors: [UIColor.accent, UIColor.kRed], lineWidth: CGFloat(width))
    }
    
    func applyGradientToLbl(){
        lblTitle.applyGradient(
            colors: [UIColor.accent, UIColor.kRed],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1))
        
    }
    
    
}
