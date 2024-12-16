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
    
    let imgArr = ["idea_1", "idea_2", "idea_2"]
  
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
        return discoverArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        cell.tryImg.isHidden = false
        let discover = discoverArr[indexPath.row]
        cell.img.image = UIImage(named: discover.img)
        cell.tryNowAction = {
            NotificationCenter.default.post(name: .tryPrompt, object: nil, userInfo: ["prompt": discover.title])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hapticFeedBackAction()
        let discover = discoverArr[indexPath.row]
        NotificationCenter.default.post(name: .prompt, object: nil, userInfo: ["prompt": discover.title, "img": discover.img])

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 10

        return CGSize(width: width  , height: width)
    }
    
    
}
