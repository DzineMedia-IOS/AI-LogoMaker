//
//  ProVC.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/28/24.
//

import UIKit

class ProVC: UIViewController {
    
    @IBOutlet weak var featureCollectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var priceCollectionView: UICollectionView!
    
    let plans = [
        ["plan": "Weekly Plan", "save": "Saves 10%", "price": "$9.99", "discount": "$6.35 / week"],
        ["plan": "Monthly Plan", "save": "Saves 15%", "price": "$19.99", "discount": "$6.35 / week"],
        ["plan": "Yearly Plan", "save": "Saves 20%", "price": "$29.99", "discount": "$6.35 / week"]
    ]
    
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
        
        applyTextColor(to: lblTitle, firstWordColor: .orange, restOfTextColor: .white)
        
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
        }    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    
}

// MARK: UICOOLECTION VIEW CELL
extension ProVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featureCollectionView{
            return 5
        }
        else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featureCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCell", for: indexPath) as! FeatureCell
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
            
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/5  - 10)
        }
        else
        {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3 - 10)
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
