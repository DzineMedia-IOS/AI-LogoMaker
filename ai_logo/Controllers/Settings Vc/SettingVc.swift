//
//  SettingVc.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/28/24.
//

import UIKit
import UIKit

class SettingVc: UIViewController {
    
    @IBOutlet weak var btnPro: UIButton!
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
        
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isPopup {
            isPopup = false
            let vc = Storyboard.creation.instantiate(PopupVC.self)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    @objc func hapticFeedbackSwitchChanged(_ sender: UISwitch) {
        let isEnabled = sender.isOn
        UserDefaults.standard.set(isEnabled, forKey: hapticFeedbackKey)
        print("Haptic Feedback \(isEnabled ? "Enabled" : "Disabled")")
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
        let hapticState = isHapticFeedbackEnabled()
        cell.lblTitle.text = title
        cell.img.image = UIImage(named: imgArr[indexPath.section][indexPath.row])
        cell.selectionStyle = .none
      

        if sectionHeaders[indexPath.section] == "App" && title == "Haptic Feedback" {
            cell.farwardImg.isHidden = true

            cell.configureCellWithToggle(isToggleVisible: true, isToggleOn: hapticState) // Default ON
            cell.toggleSwitch?.addTarget(self, action: #selector(hapticFeedbackSwitchChanged(_:)), for: .valueChanged)
        } else {
            cell.configureCellWithToggle(isToggleVisible: false, isToggleOn: false)
            cell.farwardImg.isHidden = false

        }
        
        
        

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected section \(indexPath.section), row \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)

        hapticFeedBackAction()
        let index = indexPath.row
        let section = indexPath.section
        switch section {
        case 2:
            switch index {
            case 2:
                if let privacy = URL(string: Url.dzmAppStoreUrl) {
                    presentURLPages(from: self, url: privacy,height: 400)
                }
            default:
                break
                
            }
        case 3 :
            switch index {
            case 0:
               
                if let tnc = URL(string: Url.appTerms) {
                    presentURLPages(from: self, url: tnc, height: 400)
                }
                case 1:
                if let privacy = URL(string: Url.appPrivacy) {
                    presentURLPages(from: self, url: privacy,height: 400)
                }
            default:
                break
            }
        default :
            break
        }

    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        var fontSize = 18
        var constraint = 16
        if ( UIDevice.current.userInterfaceIdiom == .pad ){
            fontSize = 27
            constraint = 24
        }
        let label = UILabel()
        label.text = sectionHeaders[section]
        label.textColor = .lightGray
        label.font = UIFont(name: "Outfit-Medium", size: CGFloat(fontSize))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: CGFloat(constraint)),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  UIDevice.current.userInterfaceIdiom == .pad ? 45 : 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UIDevice.current.userInterfaceIdiom == .pad ? 90 : 60
    }
}




// MARK: - STYLING UI

extension SettingVc {
    
    private func styleUI(){
        
        btnPro.layer.cornerRadius = btnPro.frame.height/2
        applyGradientToButton(
            button: btnPro,
            colors: [UIColor.kCream, UIColor.kDarkCream],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
        if isProUser{
            btnPro.isHidden = true
        }
    }
}
