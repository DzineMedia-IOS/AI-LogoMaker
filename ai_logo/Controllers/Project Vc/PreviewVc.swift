//
//  PreviewVc.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/28/24.
//

import UIKit

class PreviewVc: UIViewController {
    @IBOutlet weak var btnExport: UIButton!
    
    @IBOutlet weak var textBackView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnCopyPrompt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        textBackView.layer.cornerRadius = textView.frame.height / 4
        btnCopyPrompt.cornerRadius = btnCopyPrompt.frame.height / 2
        btnCopyPrompt.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            applyGradientToButton(button: self.btnExport, colors: [UIColor.kRed, UIColor.accent])
        }
        
        let fontSize = view.frame.height * 0.025
        let textFontSize = view.frame.height * 0.016
        
        if let currentFont = textView.font {
            textView.font = UIFont(name: currentFont.fontName, size: textFontSize)
        } else {
            textView.font = UIFont.systemFont(ofSize: textFontSize)
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            btnExport.titleLabel?.font = UIFont(name: "Outfit-Bold", size: fontSize)
            btnCopyPrompt.titleLabel?.font = UIFont(name: "Outfit-Bold", size: fontSize)
            btnShare.titleLabel?.font = UIFont(name: "Outfit-Bold", size: fontSize)
            
            btnExport.layer.cornerRadius = btnExport.frame.height / 2
            btnShare.layer.cornerRadius = btnShare.frame.height / 2
            btnCopyPrompt.cornerRadius = btnCopyPrompt.frame.height / 1.5
            textBackView.layer.cornerRadius = textView.frame.height / 3


            
        }
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
