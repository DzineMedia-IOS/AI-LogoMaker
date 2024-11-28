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
    }
    func applyBorder(){
        backView.applyGradientBorder(colors: [UIColor.kRed, UIColor.accent], lineWidth: 2)
    }

}
