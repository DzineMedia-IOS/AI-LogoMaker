//
//  SplashVC.swift
//  ai_logo
//
//  Created by LAP__TECH on 12/3/24.
//

import UIKit

import UIKit

class SplashVC: UIViewController {

    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbltitle.alpha = 0
        img.alpha = 0
        
        UIView.animate(withDuration: 1.5, delay: 0.5, options: [.curveEaseInOut], animations: {
            self.lbltitle.alpha = 1
            self.img.alpha = 1
            self.img.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let vc = Storyboard.main.instantiate(OnboardViewController.self)
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .flipHorizontal
                self.present(vc, animated: true, completion: nil)
            }
        })
    }
}

