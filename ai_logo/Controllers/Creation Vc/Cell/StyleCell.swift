//
//  StyleCell.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit

class StyleCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        (UIDevice.current.userInterfaceIdiom == .pad ) ? (backView.cornerRadius = 30 ): (backView.cornerRadius = 20)
        (UIDevice.current.userInterfaceIdiom == .pad ) ? (img.cornerRadius = 30 ): (img.cornerRadius = 16)
    }
    
    func applyBorder(){
        var width = 2
        if ( UIDevice.current.userInterfaceIdiom == .pad ){
            width = 5
        }
        backView.applyGradientBorder(colors: [UIColor.accent, UIColor.kRed], lineWidth: CGFloat(width))
       
    }

}
