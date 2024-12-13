//
//  FormatCell.swift
//  ai_logo
//
//  Created by LAP__TECH on 12/12/24.
//

import UIKit

class FormatCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.backgroundColor = .clear
        // Initialization code
    }

}
