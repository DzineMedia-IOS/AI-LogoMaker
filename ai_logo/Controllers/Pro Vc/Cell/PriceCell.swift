//
//  PriceCell.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/29/24.
//

import UIKit

class PriceCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var lblSave: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblweek: UILabel!
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var selectedImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if ( UIDevice.current.userInterfaceIdiom == .pad){
            saveView.layer.cornerRadius = saveView.frame.height / 1.4
            backView.layer.cornerRadius = backView.frame.height / 2
            backView.borderWidth = 4
            saveView.borderWidth = 4
        }
        else{
            saveView.layer.cornerRadius = saveView.frame.height / 3
            backView.layer.cornerRadius = backView.frame.height / 3
        }
        
    }
    

    func selectedCellConfig(){
        selectedImg.image = UIImage(named: "selected")
        backView.backgroundColor = .kOrange.withAlphaComponent(0.2)
        backView.borderColor = .kOrange
        saveView.borderWidth = .zero
        saveView.backgroundColor = .kOrange
        lblPrice.textColor = .kOrange
    }
    
    
    func unSelectedCellConfig(){
        selectedImg.image = UIImage(named: "unselected")
        backView.backgroundColor = .kLightBlack
        backView.borderColor = .kLightWhite.withAlphaComponent(0.5)
        saveView.borderWidth = UIDevice.current.userInterfaceIdiom == .pad ? 4 : 1
        saveView.backgroundColor = .kLightBlack
        lblPrice.textColor = .kWhite
    }

}
