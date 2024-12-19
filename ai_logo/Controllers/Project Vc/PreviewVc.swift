//
//  PreviewVc.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/28/24.
//

import UIKit

class PreviewVc: UIViewController {
    
    @IBOutlet weak var previewImg: UIImageView!
    @IBOutlet weak var btnExport: UIButton!
    @IBOutlet weak var textBackView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnCopyPrompt: UIButton!
    
    var imgArray : [String]?
    var fontSize : CGFloat?
    var imgUrl: String? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        previewImg.layer.cornerRadius = previewImg.frame.height / 6
        textBackView.layer.cornerRadius = textView.frame.height / 4
        btnCopyPrompt.cornerRadius = btnCopyPrompt.frame.height / 2
        btnCopyPrompt.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            applyGradientToButton(button: self.btnExport, colors: [UIColor.kRed, UIColor.accent])
        }
        fontSize =  view.frame.height * 0.024

        if UIDevice.current.userInterfaceIdiom == .phone {
            let textFontSize = view.frame.height * 0.016
            
            if let currentFont = textView.font {
                textView.font = UIFont(name: currentFont.fontName, size: textFontSize)
            } else {
                textView.font = UIFont.systemFont(ofSize: textFontSize)
            }
        }
        
        btnExport.layer.cornerRadius = btnExport.frame.height / 2.5
        btnShare.layer.cornerRadius = btnShare.frame.height / 2.5
        DispatchQueue.main.async { [weak self] in
            self?.setupFonts()
            
        }
        
    }
    override func viewIsAppearing(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            applyGradientToButton(button: self.btnExport, colors: [UIColor.kRed, UIColor.accent])
            setupFonts()

        }
    }
    
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            applyGradientToButton(button: self.btnExport, colors: [UIColor.kRed, UIColor.accent])
            setupFonts()

        }
    }
  
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
   
    @IBAction func btnExport(_ sender: Any) {
        let vc = Storyboard.aiLogo.instantiate(ExportVC.self)
        vc.modalPresentationStyle = .fullScreen
        vc.isFromPreview = true

        present(vc, animated: true)
        vc.previewImg.image = self.previewImg.image
        vc.lblPrompt.text = self.textView.text
        vc.imgArr = imgArray ?? []
        vc.firstImg = imgUrl
    }
    
    @IBAction func btnShare(_ sender: Any) {

        guard let image = previewImg.image else {
            let alert = UIAlertController(title: "No Image", message: "There is no image to share.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // For iPad: Prevent crash by specifying a popover presentation
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = (sender as? UIView)?.frame ?? CGRect.zero
        }
        present(activityVC, animated: true, completion: nil)
    }

    @IBAction func btnCopyPrompt(_ sender: Any) {
        if let text = textView.text, !text.isEmpty {

            UIPasteboard.general.string = text
             let alert = UIAlertController(title: "Copied", message: "The text has been copied to your clipboard.", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
             present(alert, animated: true, completion: nil)
         }
    }
    
}

extension PreviewVc {
    func setupFonts() {
        if var fontSize = fontSize {
                if UIDevice.current.userInterfaceIdiom != .pad {
                    fontSize = 16
                }
                let boldFont = UIFont(name: "Outfit-Bold", size: fontSize)!
                
                // Define the button states
                let states: [UIControl.State] = [.normal, .highlighted, .selected, .disabled]
                
                // Set titles and font for each state
                for state in states {
                    // For btnExport
                    let exportTitle = btnExport.title(for: state) ?? " Copy Prompt"
                    let exportAttributedTitle = NSAttributedString(string: exportTitle, attributes: [.font: boldFont])
                    btnExport.setAttributedTitle(exportAttributedTitle, for: state)
                    
                    // For btnCopyPrompt
                    let copyTitle = btnCopyPrompt.title(for: state) ?? "Export Logo"
                    let copyAttributedTitle = NSAttributedString(string: copyTitle, attributes: [.font: boldFont])
                    btnCopyPrompt.setAttributedTitle(copyAttributedTitle, for: state)
                    
                    // For btnShare
                    let shareTitle = btnShare.title(for: state) ?? " Share Logo"
                    let shareAttributedTitle = NSAttributedString(string: shareTitle, attributes: [.font: boldFont])
                    btnShare.setAttributedTitle(shareAttributedTitle, for: state)
                }
            
                if UIDevice.current.userInterfaceIdiom == .pad {
                    // Set button corner radius
                btnCopyPrompt.layer.cornerRadius = btnCopyPrompt.frame.height / 1.5
                textBackView.layer.cornerRadius = textView.frame.height / 3
                btnExport.layer.cornerRadius = btnExport.frame.height / 2
                btnShare.layer.cornerRadius = btnShare.frame.height / 2
            }
        }
    }
}
