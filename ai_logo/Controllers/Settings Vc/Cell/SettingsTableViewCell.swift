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
    var toggleSwitch: UISwitch?

    @IBOutlet weak var farwardImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if toggleSwitch == nil {
            toggleSwitch = UISwitch()
            toggleSwitch?.translatesAutoresizingMaskIntoConstraints = false
            toggleSwitch?.onTintColor = UIColor.orange
            contentView.addSubview(toggleSwitch!)
            
            NSLayoutConstraint.activate([
                toggleSwitch!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                toggleSwitch!.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
    }

    func configureCellWithToggle(isToggleVisible: Bool, isToggleOn: Bool) {
        toggleSwitch?.isHidden = !isToggleVisible
        toggleSwitch?.isOn = isToggleOn
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        toggleSwitch?.isHidden = true
        toggleSwitch?.removeTarget(nil, action: nil, for: .allEvents)
    }
}

