//
//SettingsTableViewCell.swift
// ai_logo
//
//  Created by LAP__TECH on 11/28/24.
//


import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    var toggleSwitch: UISwitch?
    
    @IBOutlet weak var farwardImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let corner =  UIDevice.current.userInterfaceIdiom == .pad ? (backView.frame.height / 2) :( backView.frame.height / 3)
        backView.layer.cornerRadius = corner
        
        if toggleSwitch == nil {
            toggleSwitch = UISwitch()
            toggleSwitch?.translatesAutoresizingMaskIntoConstraints = false
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                toggleSwitch?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5) // Increase size
            } else {
                toggleSwitch?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0) // Default size
            }
            
            toggleSwitch?.onTintColor = UIColor.orange
            contentView.addSubview(toggleSwitch!)
            
            NSLayoutConstraint.activate([
                toggleSwitch!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? -60 : -20),
                toggleSwitch!.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
    }
    
    
    func configureCellWithToggle(isToggleVisible: Bool, isToggleOn: Bool) {
        toggleSwitch?.isHidden = !isToggleVisible
        toggleSwitch?.isOn = isToggleOn
        if isToggleVisible == true {
            farwardImg.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        toggleSwitch?.isHidden = true
        toggleSwitch?.removeTarget(nil, action: nil, for: .allEvents)
    }
}

