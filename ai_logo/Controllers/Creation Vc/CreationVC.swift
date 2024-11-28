//
//  CreationViewController.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit

class CreationVC: UIViewController {
    
    @IBOutlet weak var btnArtWork: UIButton!
    @IBOutlet weak var textBackView: UIView!
    @IBOutlet weak var btnPrompt: UIButton!
    @IBOutlet weak var lblPrompt: UILabel!
    @IBOutlet weak var btnPro: UIButton!
    
    @IBOutlet weak var projectCollectionView: UICollectionView!
    @IBOutlet weak var creationCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creationCollectionView.dataSource = self
        creationCollectionView.delegate = self
        
        projectCollectionView.delegate = self
        projectCollectionView.dataSource = self
        DispatchQueue.main.async { [weak self] in
            
            self?.stylingUI()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.stylingUI()
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


// Styling
extension CreationVC {
    
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
            endPoint: CGPoint(x: 1, y: 1),
            isBottomCorner: true
        )
        
        
        applyGradientToButton(
            button: btnArtWork,
            colors:  [UIColor.accent, UIColor.kRed],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
        
        textBackView.applyGradientBorder(colors: [UIColor.accent, UIColor.kRed], lineWidth: 2)
        btnPrompt.layer.cornerRadius = 20
        btnPrompt.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        btnPrompt.clipsToBounds = true
        
        
    }
}
