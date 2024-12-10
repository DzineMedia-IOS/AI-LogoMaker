//
//  CreationViewController.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit
import ProgressHUD


class CreationVC: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnArtWork: UIButton!
    @IBOutlet weak var textBackView: UIView!
    @IBOutlet weak var btnPrompt: UIButton!
    @IBOutlet weak var lblPrompt: UILabel!
    @IBOutlet weak var btnPro: UIButton!
    @IBOutlet weak var projectCollectionView: UICollectionView!
    @IBOutlet weak var creationCollectionView: UICollectionView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    
    var selectedStyle : String = "No Style"
    override func viewDidLoad() {
        super.viewDidLoad()
   
        notificationObservers()
        popUpView.isHidden = true

        creationCollectionView.dataSource = self
        creationCollectionView.delegate = self
        
        projectCollectionView.delegate = self
        projectCollectionView.dataSource = self
        DispatchQueue.main.async { [weak self] in
            
            self?.stylingUI()
        }
        

    }
    override func viewIsAppearing(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.stylingUI()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            self?.stylingUI()
        }
    }
    
    override func viewDidLayoutSubviews() {
        projectCollectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            self?.stylingUI()
        }
    }
    
    @IBAction func btnPrompt(_ sender: Any) {
        let randomIndex = Int.random(in: 0..<PromptGenerator.aiImagePrompts.count)
        let prompt = PromptGenerator.aiImagePrompts[randomIndex]
        textView.text = prompt
    }


    
    @objc func popUpAction(){
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("popUp"), object: nil)
        popUpView.isHidden = true
 }
    
    @IBAction func btnPro(_ sender: Any) {
        let vc = Storyboard.premium.instantiate(ProVC.self)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func btnArtWork(_ sender: Any) {
        
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(popUpAction),
//                                               name: Notification.Name("popUp"),
//                                               object: nil)
//        NotificationCenter.default.post(name: Notification.Name("animation"), object: nil)
//        popUpView.isHidden = false
        
        let prompt = self.textView.text ?? ""
        self.generateLogo(prompt: prompt)
    }
    
    @objc private func handlePromptNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo, let message = userInfo["prompt"] as? String, let img = userInfo["img"] as? String {
            
            let vc = Storyboard.creation.instantiate(PromptVC.self)
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            vc.lblPrompt.text = message
            vc.img.image = UIImage(named: img)
            vc.lblStyle.text = selectedStyle
        }
    }
    @objc private func tryPromptAction(_ notification: Notification) {
        if let userInfo = notification.userInfo,let message = userInfo["prompt"] as? String{
            textView.text = message
            showToast(message: "Prompt added", font: UIFont.systemFont(ofSize: 12))
        }
    }
    @objc private func styleAction(_ notification: Notification) {
        if let userInfo = notification.userInfo,let style = userInfo["style"] as? String{
            selectedStyle = style
        }
    }
    
}



// MARK: - UICOLLECTION VIEW
extension CreationVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == creationCollectionView {
            return 1
        }
        else {
            return 1
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == creationCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreationCell", for: indexPath) as! CreationCell
            
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCell", for: indexPath) as! RecentCell
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == creationCollectionView {
            
            
            return  CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else{
            
            return  CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        
    }
    
    
}

// MARK: - API CALL

extension CreationVC {
    private func generateLogo(prompt: String) {
        ProgressHUD.animate("Some text...", interaction: false)
        APIManager.shared.generateLogo(prompt: prompt) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let response):
                    print("Logo Generation Results:")
                    print("Cost:", response.cost)
                    print("Seed:", response.seed)
                    print("Logo URL:", response.url)
                    ProgressHUD.dismiss()
                    let vc = Storyboard.aiLogo.instantiate(ExportVC.self)
                    vc.modalPresentationStyle = .fullScreen
                    vc.imgUrl = response.url
                    self.present(vc, animated: true)
                    vc.lblPrompt.text = textView.text
                
                    CoreDataManager.shared.saveRecord(prompt: textView.text, imageURL: response.url)
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                    ProgressHUD.dismiss()
                    
                    // Show an alert to the user if needed
                }
            }
        }
    }

}

//MARK: - Styling
extension CreationVC {
    
    private func stylingUI(){
        
        
        textBackView.layer.cornerRadius = textBackView.frame.height / 5
      
        let width : CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2

        textBackView.applyGradientBorder(colors: [UIColor.accent, UIColor.kRed], lineWidth: width)
        btnPrompt.layer.cornerRadius = btnPrompt.frame.height / 2
        btnPrompt.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        btnPrompt.clipsToBounds = true
       
        btnPro.layer.cornerRadius = btnPro.frame.height / 2
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
            endPoint: CGPoint(x: 1, y: 1),
            isBottomCorner: true
        )
        
        btnArtWork.layer.cornerRadius = btnArtWork.frame.height / 2
        applyGradientToButton(
            button: btnArtWork,
            colors:  [UIColor.accent, UIColor.kRed],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
       
        
       
    }
    
    private func notificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handlePromptNotification(_:)), name: .prompt, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tryPromptAction(_:)), name: .tryPrompt, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(styleAction(_:)), name: .style, object: nil)
    }
    
}




