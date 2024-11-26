//
//  radiusView.swift
//  PDF Converter
//
//  Created by MacBook on 12/01/2023.
//

import Foundation
import UIKit

class BorderAndRad: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRadiusAndShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setRadiusAndShadow()
        
    }
    
    func setRadiusAndShadow (){
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.masksToBounds = false
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1.5
        
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 1, height: 0)
        layer.shadowColor = UIColor.darkGray.cgColor
        
        
    }
    
}
extension UIView{
    func designViews (borderWidth: CGFloat = 1, borderColor: UIColor = UIColor.gray.self){
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    
    }
}

