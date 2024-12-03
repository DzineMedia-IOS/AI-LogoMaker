//
//  ProjectCell.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit

class ProjectCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func imgBorder(){
        let width = UIDevice.current.userInterfaceIdiom == .pad ? 5 : 2
        img.layer.borderWidth = CGFloat(width)
        img.layer.borderColor = UIColor.kLightBlack.cgColor
        img.layer.cornerRadius = img.frame.height / 4
    }

}
