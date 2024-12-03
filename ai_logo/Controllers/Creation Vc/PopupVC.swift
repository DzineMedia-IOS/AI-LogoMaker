//
//  PopupVc.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/29/24.
//

import UIKit

class PopupVC: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var btnOffer: UIButton!
    @IBOutlet weak var lbl0ff: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self,selector: #selector(animationAction),name: Notification.Name("animation"),object: nil)
        
        let size = view.frame.height * 0.10
        
        // Do any additional setup after loading the view.
        lbl0ff.font = lbl0ff.font.withSize(size)
        lbl0ff.textColor = .kWhite
        
        btnOffer.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == .pad ? btnOffer.frame.height/1.5 : btnOffer.frame.height / 2.5
        
        
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
            self?.startBouncingAnimation()
            
            
        }
        
        //        startBouncingAnimation()
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
            self?.startBouncingAnimation()
              
        }
    }
    
    @objc func animationAction(){
        
        DispatchQueue.main.async { [weak self] in
            self?.startBouncingAnimation()
            self?.styleUI()
            
        }
        
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("popUp"), object: nil)
        
    }
    
}


extension PopupVC {
    
    private func styleUI(){
        applyGradientToButton(
            button: btnOffer,
            colors: [UIColor.accent, UIColor.kRed],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
    }
    
    private func startBouncingAnimation() {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "position")
        
        let initialPosition = backView.layer.position
        let bounceHeight: CGFloat = 10
        
        bounceAnimation.values = [
            NSValue(cgPoint: initialPosition),
            NSValue(cgPoint: CGPoint(x: initialPosition.x, y: initialPosition.y - bounceHeight)),
            NSValue(cgPoint: CGPoint(x: initialPosition.x, y: initialPosition.y + bounceHeight)),
            NSValue(cgPoint: initialPosition)
        ]
        
        // Set animation properties
        bounceAnimation.keyTimes = [0, 0.25, 0.75, 1]
        bounceAnimation.timingFunctions = [
            CAMediaTimingFunction(name: .easeIn),
            CAMediaTimingFunction(name: .easeOut),
            CAMediaTimingFunction(name: .easeIn)
        ]
        bounceAnimation.duration = 1.0  // Duration of one cycle
        bounceAnimation.repeatCount = .infinity  // Infinite loop
        
        // Add the animation to the backView
        backView.layer.add(bounceAnimation, forKey: "bounceAnimation")
    }
    
    
    
    //    private func startInfiniteAnimation() {
    //           // Slightly move the backView off-screen (just a little below the visible area)
    //           let slightOffScreenPosition = CGPoint(x: backView.center.x, y: view.frame.height + 100) // Slight offset below the screen
    //           backView.center = slightOffScreenPosition
    //
    //           // Define the center position where the backView will go
    //           let centerPosition = CGPoint(x: backView.center.x, y: view.frame.height / 2)
    //
    //           // Start an infinite animation loop
    //           animateBackView(toPosition: centerPosition)
    //       }
    //
    //       private func animateBackView(toPosition position: CGPoint) {
    //           // Animate `backView` to come towards the screen or go back to slightly off-screen
    //           UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
    //               // Move the `backView` to the target position
    //               self.backView.center = position
    //           }, completion: { _ in
    //               // Once the animation completes, reverse the animation direction
    //               let newPosition = self.backView.center.y == self.view.frame.height / 2 ?
    //                                 CGPoint(x: self.backView.center.x, y: self.view.frame.height + 100) :
    //                                 CGPoint(x: self.backView.center.x, y: self.view.frame.height / 2)
    //               self.animateBackView(toPosition: newPosition)  // Recursively animate back and forth
    //           })
    //       }
}
