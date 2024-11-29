//
//  SettingVc.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/28/24.
//

import UIKit
import UIKit

class SettingVc: UIViewController {
    
    let sectionHeaders = ["Plans & Subscriptions", "App", "Support", "About Us"]
    let sectionData = [
        ["Restore Purchase", "Manage Subscription"], // Plans & Subscriptions
        ["Haptic Feedback"],                         // App
        ["Rate Us", "Contact Us", "Share with Friends"], // Support
        ["Terms & Conditions", "Privacy Policy"]    // About Us
    ]
 
    
    let imgArr = [
        ["purchase", "subscription"], // Plans & Subscriptions
        ["haptic"],                         // App
        ["ratue_us", "contact", "share"], // Support
        ["terms", "privacy"]    // About Us
    ]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func hapticFeedbackSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            print("Haptic Feedback Enabled")
        } else {
            print("Haptic Feedback Disabled")
        }
    }
    @IBAction func btnPro(_ sender: Any) {
        let vc = Storyboard.premium.instantiate(ProVC.self)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension SettingVc: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        
        let title = sectionData[indexPath.section][indexPath.row]
        cell.lblTitle.text = title
        cell.img.image = UIImage(named: imgArr[indexPath.section][indexPath.row])
        cell.selectionStyle = .none
        
        if sectionHeaders[indexPath.section] == "App" && title == "Haptic Feedback" {
            cell.farwardImg.isHidden = true
            cell.configureCellWithToggle(isToggleVisible: true, isToggleOn: true) // Default ON
            cell.toggleSwitch?.addTarget(self, action: #selector(hapticFeedbackSwitchChanged(_:)), for: .valueChanged)
        } else {
            cell.configureCellWithToggle(isToggleVisible: false, isToggleOn: false)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected section \(indexPath.section), row \(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel()
        label.text = sectionHeaders[section]
        label.textColor = .lightGray
        label.font = UIFont(name: "Outfit-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
