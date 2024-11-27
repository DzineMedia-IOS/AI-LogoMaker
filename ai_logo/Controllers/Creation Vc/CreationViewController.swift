//
//  CreationViewController.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit

class CreationViewController: UIViewController {
    
    @IBOutlet weak var textBackView: UIView!
    @IBOutlet weak var btnPrompt: UIButton!
    @IBOutlet weak var lblPrompt: UILabel!
    @IBOutlet weak var btnPro: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stylingUI()


    }
 override func viewDidAppear(_ animated: Bool) {
     textBackView.applyGradientBorder(colors: [UIColor.accent, UIColor.kRed], lineWidth: 2)
    }
    
 
}




extension CreationViewController{
    
    
    // Styling
    private func stylingUI(){
        applyGradientToButton(
               button: btnPro,
               colors: [UIColor.kCream, UIColor.kDarkCream],
               startPoint: CGPoint(x: 0, y: 0),
               endPoint: CGPoint(x: 1, y: 1)
           )
        
        lblPrompt.applyGradient(
            colors: [UIColor.accent, UIColor.kRed],
                startPoint: CGPoint(x: 0, y: 0),
                endPoint: CGPoint(x: 1, y: 1)
            )
        
        applyGradientToButton(
            button: btnPrompt,
               colors:  [UIColor.accent, UIColor.kRed],
               startPoint: CGPoint(x: 0, y: 0),
               endPoint: CGPoint(x: 1, y: 1)
           )
        
        
        btnPrompt.layer.cornerRadius = 20
        btnPrompt.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        btnPrompt.clipsToBounds = true
        
    
    }
}
