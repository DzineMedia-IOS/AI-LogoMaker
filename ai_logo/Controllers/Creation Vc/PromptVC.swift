//
//  PromptVC.swift
//  ai_logo
//
//  Created by LAP__TECH on 12/10/24.
//

import UIKit

class PromptVC: UIViewController {
    
    @IBOutlet weak var overlayImg: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblPrompt: UITextView!
    @IBOutlet weak var lblStyle: UILabel!
    @IBOutlet weak var btnPrompt: UIButton!
    @IBOutlet weak var textBackView: UIView!
    @IBOutlet weak var btnCopy: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
      
        textBackView.layer.cornerRadius = lblPrompt.frame.height / 4
        btnCopy.cornerRadius = btnCopy.frame.height / 2
        btnCopy.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        DispatchQueue.main.async { [weak self] in
            
            self?.stylingUI()
        }
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.stylingUI()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Ensure img.image exists
        if UIDevice.current.userInterfaceIdiom == .pad {
            overlayImg.isHidden = true
        }
        else{
            guard let currentImage = img.image else { return }
            
            let newWidth = view.frame.width
            let newHeight = newWidth
            img.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
            //        img.center = view.center
            overlayImg.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
            let resizedImage = currentImage.resizeImage(to: CGSize(width: newWidth, height: newHeight))
            img.image = resizedImage
        }
    }


    
    @IBAction func btnCopy(_ sender: Any) {
        if let text = lblPrompt.text, !text.isEmpty {
            
            UIPasteboard.general.string = text
            let alert = UIAlertController(title: "Copied", message: "The text has been copied to your clipboard.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnPrompt(_ sender: Any) {
        self.dismiss(animated: true)
        NotificationCenter.default.post(name: .tryPrompt, object: nil, userInfo: ["prompt": lblPrompt.text])
    }
    
    
}
//MARK: - Styling
extension PromptVC {
    private func stylingUI(){
        btnPrompt.layer.cornerRadius = btnPrompt.frame.height / 2
        applyGradientToButton(
            button: btnPrompt,
            colors:  [UIColor.accent, UIColor.kRed],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
    }
}
