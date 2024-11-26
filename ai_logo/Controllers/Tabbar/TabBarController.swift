import UIKit

class TabBarController: UITabBarController {
    
    private let customButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        setupCustomCenterButton()
        self.selectedIndex = 1
    }
    
    
    private func setupViewControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let taskBoard = UIStoryboard(name: "Task", bundle: nil)
        
        let homeVc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let taskVc = taskBoard.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        let statVC = storyboard.instantiateViewController(withIdentifier: "StatViewController") as! StatViewController
        let profileVc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        let centerVC = UIViewController()  // This will be the center button, no tab bar item

        
        let homeImage = UIImage(named: "home")?.resizeImage(to: CGSize(width: 25, height: 25))
        let homeSelectedImage = UIImage(named: "s_home")?.resizeImage(to: CGSize(width: 25, height: 25))
        
        let programImage = UIImage(named: "program")?.resizeImage(to: CGSize(width: 25, height: 25))
        let programSelectedImg = UIImage(named: "s_program")?.resizeImage(to: CGSize(width: 25, height: 25))
        
        let statImg = UIImage(named: "stat")?.resizeImage(to: CGSize(width: 25, height: 25))
        let statSelectedImg = UIImage(named: "s_stat")?.resizeImage(to: CGSize(width: 25, height: 25))
      
        let profileImage = UIImage(named: "profile")?.resizeImage(to: CGSize(width: 25, height: 25))
        let profileSelectedImage = UIImage(named: "s_profile")?.resizeImage(to: CGSize(width: 25, height: 25))
      
        
        homeVc.tabBarItem = UITabBarItem(title: "Home", image: homeImage, selectedImage: homeSelectedImage)
        taskVc.tabBarItem = UITabBarItem(title: "Tasks", image: programImage, selectedImage: programSelectedImg)
        statVC.tabBarItem = UITabBarItem(title: "Statistic", image: statImg, selectedImage: statSelectedImg)
        profileVc.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, selectedImage: profileSelectedImage)
        
        centerVC.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
        
        self.viewControllers = [homeVc, taskVc, centerVC, statVC, profileVc]
    }
    
    private func setupCustomCenterButton() {
        customButton.frame = CGRect(x: 0, y: 0, width: 90, height: 50)
        customButton.backgroundColor = .clear
        customButton.layer.masksToBounds = true
        
        let iconImageView = UIImageView(image: UIImage(named: "sleep_now"))
        iconImageView.tintColor = .white
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        customButton.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: customButton.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: customButton.centerYAnchor)
        ])
        
        
        self.view.addSubview(customButton)
        self.view.bringSubviewToFront(customButton)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(centerButtonTapped))
        customButton.addGestureRecognizer(tapGestureRecognizer)
//        customButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        let tabBarItems = tabBar.subviews.filter { $0 is UIControl }
        if tabBarItems.count > 2 {
            tabBarItems[2].isHidden = false
        }
        setupTabBarAppearance()
    }
    
    @objc private func centerButtonTapped() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SleepViewController") as! SleepViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    private func setupTabBarAppearance() {
        let tabBarHeight: CGFloat = tabBar.frame.height * 1.2
        var tabBarFrame = self.tabBar.frame
        tabBarFrame.size.height = tabBarHeight
        tabBarFrame.origin.y = view.frame.height - tabBarHeight
        tabBar.frame = tabBarFrame
        //        customButton.center = CGPoint(x: tabBar.center.x, y: view.frame.height - tabBarHeight + customButton.frame.height  )
        customButton.center = CGPoint(x: tabBar.center.x, y: tabBar.frame.origin.y + (tabBar.frame.origin.y * 0.013) + customButton.frame.height / 2)
        
        tabBar.tintColor = .kWhite
        tabBar.unselectedItemTintColor = .kgrey
        tabBar.backgroundColor = .kDarkBlue
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

