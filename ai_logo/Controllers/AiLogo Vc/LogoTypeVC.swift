//
//  LogoTypeVC.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit
import Lottie

class LogoTypeVC: UIViewController,UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var lblBrnadName: UILabel!
    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var brandTfView: UIView!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var segmentBar: UIView!
    @IBOutlet weak var bar_3: UIView!
    @IBOutlet weak var bar_2: UIView!
    @IBOutlet weak var bar_1: UIView!
    @IBOutlet weak var lblScreenNO: UILabel!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStep: UILabel!
    @IBOutlet weak var logoTypeView: UIView!
    @IBOutlet weak var logoCollectionView: UICollectionView!
    @IBOutlet weak var selectLogoCollectionView: UICollectionView!
    @IBOutlet weak var promptView: UIView!
    @IBOutlet weak var LogoView: UIView!
    @IBOutlet weak var textBackView: UIView!
    @IBOutlet weak var btnPrompt: UIButton!
    @IBOutlet weak var lblPrompt: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var topHeight: NSLayoutConstraint!
    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var btnClear: UIButton!
    
    // Animation outlets
    @IBOutlet weak var mainAnimationView: UIView!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var lblSec: UILabel!
    
    private var timer: Timer?
    private var startTime: Date?
    
    private var isTextLogo : Bool = false
    private var screen: Int = 1
    private var selectedIndex: IndexPath? = IndexPath(row: 0, section: 0)
    private  var selectedStyle: IndexPath? = IndexPath(row: 0, section: 0)
    
    let logoType: [String] = ["Graphic logo" , "Text Logo"]
    let logoImage: [String] = ["graphic_logo" , "text_logo"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtView.delegate = self
        brandTextField.delegate = self
        btnClear.isHidden = true
        
        if !isTextLogo {
            brandView.isHidden = true
            topHeight.constant = 20
        }
        
        if ( UIDevice.current.userInterfaceIdiom == .pad){
            btnPrompt.titleLabel?.font = UIFont(name: "Outfit-Bold", size: 26)
        }
        
        promptView.isHidden = true
        LogoView.isHidden = true
        brandTextField.autocorrectionType = .no
        mainAnimationView.isHidden = true
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
            self?.updateUI()
        }
        loadNibFiles()
        
        if let originalImage = UIImage(named: "star") {
            let templateImage = originalImage.withRenderingMode(.alwaysTemplate)
            starImg.image = templateImage
            starImg.tintColor = .kWhite
        }
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        selectLogoCollectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
            self?.updateUI()
        }
    }
    
    override func viewDidLayoutSubviews() {
        selectLogoCollectionView.reloadData()
        super.viewDidLayoutSubviews()
        //        brandTfView.layer.cornerRadius = brandTfView.frame.height / 3
        //        brandTfView.clipsToBounds = true
    }
    
    deinit {
        timer?.invalidate()
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        if screen > 1 {
            screen -= 1
            UIView.animate(withDuration: 0.3, animations: {
                switch self.screen {
                case 0:
                    self.bar_1.backgroundColor = .kLightWhite
                    
                case 1:
                    self.bar_2.backgroundColor = .kLightWhite
                    self.showView(self.logoTypeView)
                    self.hideView(self.promptView)
                    self.hideView(self.LogoView)
                    self.btnContinue.setTitle("Continue", for: .normal)
                    
                case 2:
                    self.bar_3.backgroundColor = .kLightWhite
                    self.hideView(self.logoTypeView)
                    self.showView(self.promptView)
                    self.hideView(self.LogoView)
                    self.btnContinue.setTitle("Continue", for: .normal)
                    self.selectLogoCollectionView.reloadData()
                    
                default:
                    break
                }
            })
            updateUI()
            animateTopView()
        }
        else{
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        if screen < 3 {
            screen += 1
            UIView.animate(withDuration: 0.3, animations: { [self] in
                switch self.screen {
                case 1:
                    self.bar_1.backgroundColor = .white
                    self.showView(self.logoTypeView)
                    self.btnContinue.setTitle("Continue", for: .normal)
                    
                case 2:
                    
                    
                    self.bar_2.backgroundColor = .white
                    self.hideView(self.logoTypeView)
                    self.showView(self.promptView)
                    self.btnContinue.setTitle("Continue", for: .normal)
                    
                    
                case 3:
                    let isTextEmpty = brandTextField.text?.isEmpty ?? true
                    let isPromptEmpty = txtView.text?.isEmpty ?? true
                    
                    if isTextLogo && (isTextEmpty || isPromptEmpty) {
                        screen -= 1
                        let message = isTextEmpty ? "Brand name cannot be empty." : "Prompt cannot be empty."
                        self.showToast(message: message, font: .systemFont(ofSize: 12.0))
                    } else if !isTextLogo && isPromptEmpty {
                        screen -= 1
                        self.showToast(message: "Prompt cannot be empty.", font: .systemFont(ofSize: 12.0))
                    }
                    else if txtView.text == logoPrompt{
                        screen -= 1
                        self.showToast(message: "Please enter the prompt!", font: .systemFont(ofSize: 12.0))
                    }
                    else {
                        self.bar_3.backgroundColor = .white
                        self.hideView(self.promptView)
                        self.showView(self.LogoView)
                        self.btnContinue.setTitle("Generate Logo", for: .normal)
                    }                default:
                    break
                }
            })
            updateUI()
            animateTopView()
        }
        else{
            let logoType = isTextLogo ? "text-based logo" : "Graphic-based logo"
            let brandName = isTextLogo ? "for \(String(describing: brandTextField.text))" : ""
            let style = logoStylePrompts[selectedStyle?.item ?? 0]
            var prompt = "A modern \(logoType) \(brandName),the style should be \(style),"
            prompt = prompt + self.txtView.text
            
            setupAnimation()
            startTimer()
            
            self.generateLogo(prompt: prompt)
           
        }
    }
    
    @IBAction func btnPrompt(_ sender: Any) {
        let randomIndex = Int.random(in: 0..<PromptGenerator.logoPrompts.count)
        let prompt = PromptGenerator.logoPrompts[randomIndex]
        txtView.text = prompt
        
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        txtView.text = ""
    }
    
    @objc private func updateSeconds() {
        guard let startTime = startTime else { return }
        let elapsedTime = Date().timeIntervalSince(startTime)
        lblSec.text = String(format: "%.2fs", elapsedTime)
    }
    //MARK: text fields Delegate Methods
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Remove placeholder text when editing begins
        let width: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 5 : 2
        removeGradientBorder(from: brandTfView)
        lblBrnadName.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        lblBrnadName.textColor = .kWhite

        textBackView.applyGradientBorder(colors: [UIColor.accent, UIColor.kRed], lineWidth: CGFloat(width))
        
        btnClear.isHidden = false
        if txtView.text == logoPrompt {
            txtView.text = ""
            txtView.textColor = .kPrompt
        }
        if let originalImage = UIImage(named: "star") {
            starImg.image = originalImage.withRenderingMode(.alwaysOriginal)
            
        }
        lblPrompt.applyGradient(
            colors: [UIColor.accent, UIColor.kRed],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        btnClear.isHidden = true
        if txtView.text.isEmpty {
            txtView.text = logoPrompt
            txtView.textColor = .kPrompt
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == brandTextField {
            lblPrompt.layer.sublayers?.removeAll { $0 is CAGradientLayer }
            lblPrompt.textColor = .kWhite
            removeGradientBorder(from: textBackView)
            let width: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 5 : 2
            brandTfView.applyGradientBorder(colors: [UIColor.accent, UIColor.kRed], lineWidth: CGFloat(width))
            if let originalImage = UIImage(named: "star") {
                
                let templateImage = originalImage.withRenderingMode(.alwaysTemplate)
                starImg.image = templateImage
                starImg.tintColor = .kWhite
            }
        }
        lblBrnadName.applyGradient(
            colors: [UIColor.accent, UIColor.kRed],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == brandTextField {
        }
    }
    
}

// MARK: - UICOLLECTION VIEW DATA SOURCE
extension LogoTypeVC: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == logoCollectionView {
            return 2
        }
        else{
            return styleArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == logoCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LogoTypeCell", for: indexPath) as! LogoTypeCell
            
            cell.img.image = UIImage(named: logoImage[indexPath.row])
            cell.lblTitle.text = logoType[indexPath.row]
            if selectedIndex == indexPath {
                DispatchQueue.main.async { [weak self] in
                    cell.applyGradientToBackView()
                    cell.applyGradientToLbl()
                }
            }
            
            else {
                cell.backView.layer.sublayers?.removeAll { $0 is CAGradientLayer }
                cell.lblTitle.layer.sublayers?.removeAll { $0 is CAGradientLayer }
                cell.lblTitle.textColor = .kWhite
            }
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StyleCell", for: indexPath) as! StyleCell
            let style = styleArray[indexPath.row]
            cell.img.image = UIImage(named: style.img)
            cell.lblTitle.text = style.title
            if selectedStyle == indexPath {
                cell.applyBorder()
            }
            else{
                cell.backView.layer.sublayers?.removeAll { $0 is CAGradientLayer }
                
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hapticFeedBackAction()
        if collectionView == logoCollectionView {
            
            self.selectedIndex = indexPath
            if indexPath.row == 0 {
                brandView.isHidden = true
                topHeight.constant = 20
                isTextLogo = false
            }
            else {
                isTextLogo = true
                brandView.isHidden = false
                topHeight.constant = UIDevice.current.userInterfaceIdiom == .pad  ? 150 : 90
            }
            logoCollectionView.reloadData()
        }
        else{
            self.selectedStyle = indexPath
            selectLogoCollectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == logoCollectionView {
            let width =  collectionView.frame.width/2 - 20
            var height = UIDevice.current.userInterfaceIdiom == .pad  ? collectionView.frame.height : collectionView.frame.height/1.6
            
            if (UIDevice.current.userInterfaceIdiom != .pad ){
                height = min(height,250)
            }
            return CGSize(width: width, height: height)
        }
        
        else {
            var width =  collectionView.frame.width/3 - 10
            let height = collectionView.frame.height/2 - 10
            var size = min(height,180)
            
            if (UIDevice.current.userInterfaceIdiom == .pad){
                size = min(width, height)
                width = collectionView.frame.width/4 - 10
            }
            
            return  CGSize(width: width , height: size)
        }
    }
    
    
}

// MARK: - STYLING UI & load nib files
extension LogoTypeVC {
    
    private func styleUI(){
        
        //        brandTfView.layer.cornerRadius = brandTfView.frame.height / 3
        btnPrompt.clipsToBounds = true
        
        configureCornerRadius(for: btnContinue)
        btnPrompt.layer.cornerRadius = btnPrompt.frame.height / 2
        
        
        applyGradientToButton(
            
            button: btnContinue,
            colors: [UIColor.accent, UIColor.kRed],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
        
//        lblPrompt.applyGradient(
//            colors: [UIColor.accent, UIColor.kRed],
//            startPoint: CGPoint(x: 0, y: 0),
//            endPoint: CGPoint(x: 1, y: 1)
//        )
        
        
        var  width = 2
        if ( UIDevice.current.userInterfaceIdiom == .pad) {
            width = 5
            textBackView.layer.cornerRadius = 20
            brandTfView.layer.cornerRadius = 20
            
        }
        
        
        
        
    }
    
    private func loadNibFiles(){
        let nib = UINib(nibName: "LogoTypeCell", bundle: nil)
        logoCollectionView.register(nib, forCellWithReuseIdentifier: "LogoTypeCell")
        logoCollectionView.delegate = self
        logoCollectionView.dataSource = self
        
        let styleNib = UINib(nibName: "StyleCell", bundle: nil)
        selectLogoCollectionView.register(styleNib, forCellWithReuseIdentifier: "StyleCell")
        selectLogoCollectionView.dataSource = self
        selectLogoCollectionView.delegate = self
    }
    
    func showView(_ view: UIView) {
        view.isHidden = false
        view.alpha = 0
        UIView.animate(withDuration: 0.3) {
            view.alpha = 1
        }
        
    }
    
    func hideView(_ view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0
        }) { _ in
            view.isHidden = true
        }
    }
    
    func updateUI() {
        lblStep.text = "Step \(screen) of 3"
        lblScreenNO.text = String(format: "0%d", screen)
        
        // Update title based on screen number
        switch screen {
        case 1:
            lblTitle.text = "Select the type of \n your logo"
        case 2:
            lblTitle.text = "Generate unique logos \n for your brand"
        case 3:
            lblTitle.text = "Pick your logo style"
        default:
            break
        }
    }
    
    func animateTopView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.TopView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.TopView.transform = .identity
            }
        }
    }
    
    private func configureCornerRadius(for button: UIButton) {
        let cornerRadius = button.frame.height
        button.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == .pad ? cornerRadius/2 : cornerRadius / 2
    }
    
    func removeGradientBorder(from view: UIView) {
        view.layer.sublayers?.forEach { sublayer in
            if sublayer is CAGradientLayer {
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
}

// MARK: LOADER ANIMATION
extension LogoTypeVC {
    private func startTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSeconds), userInfo: nil, repeats: true)
    }
    private func setupAnimation(){
        mainAnimationView.isHidden = false
        let lottieAnimation = LottieAnimationView(name: .loader)
        lottieAnimation.frame = animationView.bounds
        lottieAnimation.contentMode = .scaleAspectFit
        lottieAnimation.loopMode = .loop
        animationView.addSubview(lottieAnimation)
        lottieAnimation.play { finished in
        }
    }
}

// MARK: API function
extension LogoTypeVC {
    
    private func generateLogo(prompt: String) {
        tabBarController?.tabBar.isHidden = true

        APIManager.shared.generateLogo(prompt: prompt) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let response):
                    let imgName = UUID().uuidString

                    CoreDataManager.shared.saveImageFromURLToDocumentsDirectory(response.url, withName: imgName) { [self] savedPath in
                        if let path = savedPath {
                            DispatchQueue.main.async { [self] in
                                  let vc = Storyboard.aiLogo.instantiate(ExportVC.self)
                                  vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true)
                                
                                vc.lblPrompt.text = txtView.text
                                vc.prompt = prompt
                                    vc.previewImg.image = UIImage(contentsOfFile: path)
                                  // remove animation
                                    vc.imgPath = imgName
                                    vc.firstImg = path

                                  self.mainAnimationView.isHidden = true
                                  for subview in animationView.subviews {
                                      subview.removeFromSuperview()
                                  }
                                  self.lblSec.text = "0.0"
                                  tabBarController?.tabBar.isHidden = false

                                }
                            stopTimer()
                        }
                    }
                    
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                    showAlert(title: "Error!", message: "Something went wrong. Please check your internet connection, and Try again!", viewController: self)
                    self.mainAnimationView.isHidden = true
                  for subview in animationView.subviews {
                      subview.removeFromSuperview()
                  }
                    // Show an alert to the user if needed
                }
            }
        }
    }

    
//    private func generateLogo(prompt: String) {
//        APIManager.shared.generateLogo(prompt: prompt) { result in
//            DispatchQueue.main.async { [self] in
//                switch result {
//                case .success(let response):
//                    print("Logo Generation Results:")
//                    print("Cost:", response.cost)
//                    print("Seed:", response.seed)
//                    print("Logo URL:", response.url)
//                    
//                    
//                    let imgName = UUID().uuidString
//                    
//                    CoreDataManager.shared.saveImageFromURLToDocumentsDirectory(response.url, withName: imgName) { [self] savedPath in
//                        if let path = savedPath {
//                            DispatchQueue.main.async {
//                                let vc = Storyboard.aiLogo.instantiate(ExportVC.self)
//                                vc.modalPresentationStyle = .fullScreen
//                                vc.imgPath = path
//
//                                self.present(vc, animated: true)
//                                vc.lblPrompt.text = self.txtView.text
//                                vc.previewImg.image = UIImage(contentsOfFile: path)
//                                self.mainAnimationView.isHidden = true
//                                for subview in animationView.subviews {
//                                    subview.removeFromSuperview()
//                                }
//                                self.lblSec.text = "0.0"
//                            }
//                            stopTimer()
//                            
//                        }
////                        CoreDataManager.shared.saveRecord(prompt: prompt, imageURL: response.url)
//                        
//                    }
//                case .failure(let error):
//                    print("Error:", error.localizedDescription)
//                    
//                    // Show an alert to the user if needed
//                }
//            }
//        }
//    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
