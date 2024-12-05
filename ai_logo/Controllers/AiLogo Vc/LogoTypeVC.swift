//
//  LogoTypeVC.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit
class LogoTypeVC: UIViewController {
    
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
    
    var isTextLogo : Bool = false
    var screen: Int = 1
    var selectedIndex: IndexPath?
    var selectedStyle: IndexPath?
    let logoType: [String] = ["Graphic logo" , "Text Logo"]
    let logoImage: [String] = ["graphic_logo" , "text_logo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isTextLogo {
            brandView.isHidden = true
            topHeight.constant = 20
        }
        
        if ( UIDevice.current.userInterfaceIdiom == .pad){
            btnPrompt.titleLabel?.font = UIFont(name: "Outfit-Bold", size: 40)
        }
        
        promptView.isHidden = true
        LogoView.isHidden = true
        
        
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
            self?.updateUI()
        }
        
        loadNibFiles()
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
            self?.updateUI()
        }
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
            UIView.animate(withDuration: 0.3, animations: {
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
                    self.bar_3.backgroundColor = .white
                    self.hideView(self.promptView)
                    self.showView(self.LogoView)
                    self.btnContinue.setTitle("Generate Logo", for: .normal)
                    
                default:
                    break
                }
            })
            updateUI()
            animateTopView()
        }
        else{
            let vc = Storyboard.aiLogo.instantiate(ExportVC.self)
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
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
}



// MARK: - UICOLLECTION VIEW DATA SOURCE
extension LogoTypeVC: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == logoCollectionView {
            return 2
        }
        else{
            
            return 10
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
        if collectionView == logoCollectionView {
            
            self.selectedIndex = indexPath
            if indexPath.row == 0 {
                brandView.isHidden = true
                topHeight.constant = 20
            }
            else{
                
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
        brandTfView.cornerRadius = brandTfView.frame.height / 3
        configureCornerRadius(for: btnContinue)
        btnPrompt.layer.cornerRadius = btnPrompt.frame.height / 2
        btnPrompt.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        btnPrompt.clipsToBounds = true
        
        applyGradientToButton(
            
            button: btnContinue,
            colors: [UIColor.accent, UIColor.kRed],
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
        
        var  width = 2
        if ( UIDevice.current.userInterfaceIdiom == .pad) {
            width = 5
            textBackView.layer.cornerRadius = 20
        }
        
        textBackView.applyGradientBorder(colors: [UIColor.accent, UIColor.kRed], lineWidth: CGFloat(width))
        
        
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
    
}
