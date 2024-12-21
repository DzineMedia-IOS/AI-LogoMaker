//
//  ProjectCell.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit
import Lottie

class ProjectCell: UICollectionViewCell {

    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tryImg: UIImageView!
    @IBOutlet weak var img: UIImageView!
    
    var tryNowAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        indicator.isHidden = true
        tryImg.isHidden = true
        img.layer.cornerRadius = img.frame.height / 5
        
        tryImg.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            tryImg.addGestureRecognizer(tapGesture)
    }
    
    func setupAnimation(){
        
        let lottieAnimation = LottieAnimationView(name: .loader)
        lottieAnimation.frame = animationView.bounds
        lottieAnimation.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lottieAnimation.contentMode = .scaleAspectFill
        lottieAnimation.tintColor = .white
        lottieAnimation.loopMode = .loop
        animationView.addSubview(lottieAnimation)
        lottieAnimation.play { finished in
        }
    }
    
     func removeSubviews() {
        for subview in animationView.subviews {
            subview.removeFromSuperview()
        }
    }
    func imgBorder(){
        let width = UIDevice.current.userInterfaceIdiom == .pad ? 5 : 2
        img.layer.borderWidth = CGFloat(width)
        img.layer.borderColor = UIColor.kLightBlack.cgColor
//        img.layer.cornerRadius = img.frame.height / 4
    }
    
    @objc func imageTapped() {
        tryNowAction?()
        clickSplashEffect(on: tryImg)

    }
    func clickSplashEffect(on view: UIView) {
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
            view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) // Slightly shrink
            view.alpha = 0.8 // Slightly dim
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           options: [.curveEaseIn, .allowUserInteraction],
                           animations: {
                view.transform = CGAffineTransform.identity // Return to normal
                view.alpha = 1.0 // Restore opacity
            },
                           completion: nil)
        })
    }
    
   
    
//    cell.buttonActionClosure = { [self] in}
}
