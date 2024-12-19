//
//  FeatureCell.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/29/24.
//

import UIKit

class FeatureCell: UICollectionViewCell {

    @IBOutlet weak var imgBackView: UIView!
    @IBOutlet weak var lblFeature: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgBackView.layer.cornerRadius = imgBackView.frame.height / 4
//        adjustFontSize()
    }

    private func adjustFontSize() {
            let cellWidth = self.bounds.height
            let fontSize = cellWidth * 0.1
        print(fontSize)
            lblFeature.font = lblFeature.font.withSize(fontSize)
        }

}
