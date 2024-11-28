//
//  TabBarController.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/26/24.
//


import UIKit

class TabBarController: UITabBarController {
    
    private let customButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
       
        self.selectedIndex = 1
        
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTabBarAppearance()
        
    }
    

    
    private func setupViewControllers() {
        
        let homeVc = Storyboard.creation.instantiate(CreationVC.self)
        let aiLogoVc = Storyboard.aiLogo.instantiate(AiLogoVC.self)
        let projects = Storyboard.projects.instantiate(ProjectViewController.self)
        let profileVc = UIViewController()
//        let centerVC = UIViewController()  // This will be the center button, no tab bar item

        
        homeVc.view.backgroundColor = .red
        aiLogoVc.view.backgroundColor = .accent
        
        let homeImage = UIImage(named: "creation")?.resizeImage(to: CGSize(width: 25, height: 25))
        let homeSelectedImage = UIImage(named: "s_creation")?.resizeImage(to: CGSize(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal)
        
        let programImage = UIImage(named: "ai_logo")?.resizeImage(to: CGSize(width: 25, height: 25))
        let programSelectedImg = UIImage(named: "s_ai_logo")?.resizeImage(to: CGSize(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal)
        
        let statImg = UIImage(named: "projects")?.resizeImage(to: CGSize(width: 25, height: 25))
        let statSelectedImg = UIImage(named: "s_projects")?.resizeImage(to: CGSize(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal)
      
        let profileImage = UIImage(named: "settings")?.resizeImage(to: CGSize(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal)
        let profileSelectedImage = UIImage(named: "s_settings")?.resizeImage(to: CGSize(width: 25, height: 25))?.withRenderingMode(.alwaysOriginal)
      
        
        homeVc.tabBarItem = UITabBarItem(title: "Creation", image: homeImage, selectedImage: homeSelectedImage)
        aiLogoVc.tabBarItem = UITabBarItem(title: "AI logo", image: programImage, selectedImage: programSelectedImg)
        projects.tabBarItem = UITabBarItem(title: "Projects", image: statImg, selectedImage: statSelectedImg)
        profileVc.tabBarItem = UITabBarItem(title: "Settings", image: profileImage, selectedImage: profileSelectedImage)
                
        self.viewControllers = [homeVc, aiLogoVc,  projects, profileVc]
    }
    
   
    
   
    
    private func setupTabBarAppearance() {
        let tabBarHeight: CGFloat = tabBar.frame.height * 1.2 
        var tabBarFrame = self.tabBar.frame
        tabBarFrame.size.height = tabBarHeight
        tabBarFrame.origin.y = view.frame.height - tabBarHeight
        tabBar.frame = tabBarFrame
        //        customButton.center = CGPoint(x: tabBar.center.x, y: view.frame.height - tabBarHeight + customButton.frame.height  )
        customButton.center = CGPoint(x: tabBar.center.x, y: tabBar.frame.origin.y + (tabBar.frame.origin.y * 0.013) + customButton.frame.height / 2)
        
//        tabBar.tintColor = .kRed
        tabBar.unselectedItemTintColor = .kLightWhite
        tabBar.backgroundColor = .kBlack
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

extension UIImage {
    func resizeImage(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

