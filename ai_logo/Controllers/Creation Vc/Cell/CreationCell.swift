//
//  CreationCell.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/27/24.
//

import UIKit

class CreationCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectView: UIView!
    var selectedIndex: IndexPath? = IndexPath(row: 0, section: 0)

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "StyleCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "StyleCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    
    
}


// MARK: - UICOLLECTION VIEW
extension CreationCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return styleArray.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "StyleCell", for: indexPath) as!
        StyleCell
        
        let style = styleArray[indexPath.row]
        cell.img.image = UIImage(named: style.img)
        cell.lblTitle.text = style.title
        
        if selectedIndex == indexPath {
            
            DispatchQueue.main.async { [weak self] in
                cell.applyBorder()
                
            }
        }
        else{
            cell.backView.layer.sublayers?.removeAll { $0 is CAGradientLayer }
            
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = max (collectionView.frame.width / 4 , 100)
        var height = min( collectionView.frame.height, 140)
        if (UIDevice.current.userInterfaceIdiom == .pad){
            height = min( collectionView.frame.height, 280)
            width = min (collectionView.frame.width / 4 , 200)

        }
        return CGSize(width:  width , height: height)
//        return CGSize(width:  width , height: 130)
        
    }
    
}




