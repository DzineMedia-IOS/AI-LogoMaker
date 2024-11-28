//
//  RecentCell.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit

class RecentCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectView: UIView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "ProjectCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ProjectCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
 
        
    }
}


// MARK: - UICOLLECTIONVIEW

extension RecentCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 10

        return CGSize(width: width  , height: 130)
    }
    
    
}
