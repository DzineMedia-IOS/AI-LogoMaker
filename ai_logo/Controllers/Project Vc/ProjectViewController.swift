//
//  ProjectViewController.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/26/24.
//

import UIKit

class ProjectViewController: UIViewController {

   
    @IBOutlet weak var projectCollectionView: UICollectionView!
    @IBOutlet weak var btnPro: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        applyGradientToButton(
               button: btnPro,
               colors: [UIColor.kCream, UIColor.kDarkCream],
               startPoint: CGPoint(x: 0, y: 0),
               endPoint: CGPoint(x: 1, y: 1)
           )
        
        let nib = UINib(nibName: "ProjectCell", bundle: nil)
        projectCollectionView.register(nib, forCellWithReuseIdentifier: "ProjectCell")

         
        projectCollectionView.delegate = self
        projectCollectionView.dataSource = self
       
    }
    


}

extension ProjectViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width/3 - 10
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = Storyboard.projects.instantiate(PreviewVc.self)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    
}
