//
//  Constants.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import Foundation

import UIKit

enum Storyboard: String {
    case main = "Main"
    case creation = "Creation"
//    case profile = "Profile"
    case projects = "Projects"
    case aiLogo = "AiLogo"
    case settings = "Settings"
    case premium = "Premium"
    
    

    /// Instantiate a view controller from the storyboard.
    /// - Parameters:
    ///   - viewController: The type of the view controller to instantiate.
    ///   - bundle: The bundle containing the storyboard file. Defaults to `nil`.
    func instantiate<T: UIViewController>(_ viewController: T.Type, bundle: Bundle? = nil) -> T {
        let storyboard = UIStoryboard(name: self.rawValue, bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not instantiate view controller \(T.self) from storyboard \(self.rawValue).")
        }
        return viewController
    }
}


// usage
//class SettingsViewController: UIViewController {
//    func showSettings() {
//        let settingsVC = Storyboard.settings.instantiate(SettingsViewController.self)
//        settingsVC.modalPresentationStyle = .fullScreen
//        present(settingsVC, animated: true, completion: nil)
//    }
//}

