//
//  AiLogoVC.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit

class AiLogoVC: UIViewController {

    @IBOutlet weak var btnPro: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
        // Do any additional setup after loading the view.
    }
    

    override func viewIsAppearing(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
    }
   
    @IBAction func btnStart(_ sender: Any) {
        let vc = Storyboard.aiLogo.instantiate(LogoTypeVC.self)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func btnPro(_ sender: Any) {
        let vc = Storyboard.premium.instantiate(ProVC.self)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

// MARK: - STYLING UI

extension AiLogoVC {
    
    
    private func styleUI(){
        applyGradientToButton(
       
            button: btnStart,
            colors: [UIColor.kRed, UIColor.accent],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
        
        applyGradientToButton(
            button: btnPro,
            colors: [UIColor.kCream, UIColor.kDarkCream],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
    }
}
