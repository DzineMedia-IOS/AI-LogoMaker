//
//  ProVC.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/28/24.
//

import UIKit
import Lottie

class ProVC: UIViewController {
    
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var featureCollectionView: UICollectionView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var priceCollectionView: UICollectionView!
    
    let plans = [
        ["plan": "Weekly", "save": "Saves 10%", "price": "US $4.99", "discount": "$6.35 / week"],
        ["plan": "Monthly", "save": "Saves 15%", "price": "US $5.99", "discount": "$6.35 / week"],
        ["plan": "Yearly Plan", "save": "Saves 20%", "price": "$29.99", "discount": "$6.35 / week"]
    ]
    
    let imges = ["endless","creative","ai_gen","style", "down"]
    let titles = ["Endless Generation", "Creative Suggestions", "AI Gen Artwork","Creative Styles", "HD Download"]
    
    var selectedIndex: Int = 0
    var isOnbarodingVC: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let lottieAnimation = LottieAnimationView(name: .banner)
        lottieAnimation.frame = animationView.bounds
        lottieAnimation.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lottieAnimation.contentMode = .scaleAspectFill
        lottieAnimation.tintColor = .white
        lottieAnimation.loopMode = .loop
        lottieAnimation.animationSpeed = 0.5

        animationView.addSubview(lottieAnimation)
        lottieAnimation.play { finished in
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
        
        let nib = UINib(nibName: "FeatureCell", bundle: nil)
        featureCollectionView.register(nib, forCellWithReuseIdentifier: "FeatureCell")
        featureCollectionView.delegate = self
        featureCollectionView.dataSource = self
        
        let priceNib = UINib(nibName: "PriceCell", bundle: nil)
        priceCollectionView.register(priceNib, forCellWithReuseIdentifier: "PriceCell")
        priceCollectionView.delegate = self
        priceCollectionView.dataSource = self
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        if isOnbarodingVC {
            let tabbar = Storyboard.main.instantiate(TabBarController.self)
            tabbar.modalPresentationStyle = .fullScreen
            present(tabbar, animated: false)
        }
        else{
            isPopup = true
            self.dismiss(animated: false)
        }
    }
    
    
    @IBAction func btnPrivacy(_ sender: Any) {
        if let tnc = URL(string: Url.appPrivacy) {
            presentURLPages(from: self, url: tnc, height: 400)
        }
        
    }
    
    @IBAction func btnTermOfUse(_ sender: Any) {
        
        if let privacy = URL(string: Url.appTerms) {
            presentURLPages(from: self, url: privacy,height: 400)
        }
    }
    
    
    @IBAction func btnBuy(_ sender: Any) {
        isProUser = true
        self.dismiss(animated: true)
    }
    
    @IBAction func btnRestore(_ sender: Any) {
    }
}

// MARK: UICOOLECTION VIEW CELL
extension ProVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featureCollectionView{
            return imges.count
        }
        else{
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featureCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCell", for: indexPath) as! FeatureCell
            cell.img.image = UIImage(named: imges[indexPath.item])
            cell.lblFeature.text = titles[indexPath.item]
            
            let fontSize = self.view.frame.width * 0.0267
            cell.lblFeature.font = cell.lblFeature.font.withSize(fontSize)

            return cell
        }
        else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceCell", for: indexPath) as! PriceCell
            
            let plan = plans[indexPath.item]
            cell.lblPrice.text = plan["price"]
            cell.lblSave.text = plan["save"]
            cell.lblPlanName.text = plan["plan"]
            cell.lblweek.text = plan["discount"]
            
            if indexPath.row == selectedIndex {
                cell.selectedCellConfig()
            }
            else{
                cell.unSelectedCellConfig()
            }
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hapticFeedBackAction()
        if collectionView == priceCollectionView{
            selectedIndex = indexPath.row
            priceCollectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == featureCollectionView{
            
            return CGSize(width: collectionView.frame.width / CGFloat(imges.count) - 10, height: collectionView.frame.height)
        }
        else
        {
            return CGSize(width: collectionView.frame.width/2 - 10, height: collectionView.frame.height)
        }
    }
    
    
    
}

// MARK: - UI STYLING
extension ProVC {
    
    func applyTextColor(to label: UILabel, firstWordColor: UIColor, restOfTextColor: UIColor) {
        guard let fullText = label.text, !fullText.isEmpty else { return }
        let attributedString = NSMutableAttributedString(string: fullText)
        
        if let firstSpaceIndex = fullText.firstIndex(of: " ") {
            let firstWordRange = NSRange(fullText.startIndex..<firstSpaceIndex, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: firstWordColor, range: firstWordRange)
            
            let restOfTextRange = NSRange(firstSpaceIndex..<fullText.endIndex, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: restOfTextColor, range: restOfTextRange)
        } else {
            let entireRange = NSRange(fullText.startIndex..<fullText.endIndex, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: firstWordColor, range: entireRange)
        }
        
        label.attributedText = attributedString
    }
    
    
    func styleUI(){
        let corner = btnStart.frame.height
        btnStart.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == .pad ? corner/2 : corner/3
        applyGradientToButton(button: btnStart, colors: [UIColor.accent, UIColor.kRed])
        
        
    }
    
}
