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
    var projects: [Projects] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
        
        let nib = UINib(nibName: "ProjectCell", bundle: nil)
        projectCollectionView.register(nib, forCellWithReuseIdentifier: "ProjectCell")
        
        
        projectCollectionView.delegate = self
        projectCollectionView.dataSource = self
        
        projects = CoreDataManager.shared.fetchRecords()
        
        
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        projectCollectionView.reloadData()
        
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        projectCollectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
    }
    
    
    @IBAction func btnPro(_ sender: Any) {
        let vc = Storyboard.premium.instantiate(ProVC.self)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

extension ProjectViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
         let project = projects[indexPath.item]
       
        if let imgPath = project.imgPath, !imgPath.isEmpty {
                cell.img.image = UIImage(contentsOfFile: imgPath)
            } else {
                cell.img.image = nil
            }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = collectionView.frame.width/3 - 10
        if (UIDevice.current.userInterfaceIdiom == .pad){
            size = collectionView.frame.width/4  - 10
        }
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = Storyboard.projects.instantiate(PreviewVc.self)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
        vc.previewImg.image = UIImage(named: "project_\(indexPath.row)")
    }
}




// MARK: - STYLING UI

extension ProjectViewController {
    
    private func styleUI(){
        
        btnPro.layer.cornerRadius = btnPro.frame.height/2
        applyGradientToButton(
            button: btnPro,
            colors: [UIColor.kCream, UIColor.kDarkCream],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
    }
}
