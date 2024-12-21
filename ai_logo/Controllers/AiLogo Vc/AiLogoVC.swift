//
//  AiLogoVC.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit
import Lottie

class AiLogoVC: UIViewController {
    
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var btnPro: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let lottieAnimation = LottieAnimationView(name: .banner)
        lottieAnimation.frame = animationView.bounds
        lottieAnimation.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lottieAnimation.contentMode = .scaleAspectFill
        lottieAnimation.tintColor = .white
        lottieAnimation.animationSpeed = 0.5
        lottieAnimation.loopMode = .loop
        animationView.addSubview(lottieAnimation)
        lottieAnimation.play { finished in
        }

        
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
    
    override func viewDidAppear(_ animated: Bool) {
        if isPopup {
            isPopup = false
            let vc = Storyboard.creation.instantiate(PopupVC.self)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
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
    
    
    private func configureCornerRadius(for button: UIButton) {
        let cornerRadius = button.frame.height
        button.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == .pad ? cornerRadius/2 : cornerRadius / 2
    }
}

// MARK: - STYLING UI

extension AiLogoVC {
    
    
    private func styleUI(){
        
        configureCornerRadius(for: btnPro)
        configureCornerRadius(for: btnStart)
        
        applyGradientToButton(
            
            button: btnStart,
            colors: [UIColor.accent, UIColor.kRed],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
        
        applyGradientToButton(
            button: btnPro,
            colors: [UIColor.kCream, UIColor.kDarkCream],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
        
        if isProUser {
            btnPro.isHidden = true
        }
    }
}
