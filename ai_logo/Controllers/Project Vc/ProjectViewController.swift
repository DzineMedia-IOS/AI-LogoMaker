//
//  ProjectViewController.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/26/24.
//

import UIKit

class ProjectViewController: UIViewController {
    
    
    @IBOutlet weak var noDocView: UIView!
    @IBOutlet weak var projectCollectionView: UICollectionView!
    @IBOutlet weak var btnPro: UIButton!
    var projects: [Projects] = []
    var docPath : String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        noDocView.isHidden = true
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
        
        let nib = UINib(nibName: "ProjectCell", bundle: nil)
        projectCollectionView.register(nib, forCellWithReuseIdentifier: "ProjectCell")
        projectCollectionView.delegate = self
        projectCollectionView.dataSource = self
        
        
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        projects = CoreDataManager.shared.fetchRecords()
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
        (projects.count == 0) ? (noDocView.isHidden = false ) : (noDocView.isHidden = true)
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
//         let project = projects[indexPath.item]
//       
         let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//        if let imgName = project.imgPath {
//            let imagePath = documentsDirectory.appendingPathComponent(imgName + ".jpg").path
//            
//            if fileManager.fileExists(atPath: imagePath) {
//                if let image = UIImage(contentsOfFile: imagePath) {
//                    cell.img.image = image
//                } else {
//                    print("Failed to load image from path: \(imagePath)")
//                }
//            } else {
//                print("Image does not exist at path: \(imagePath)")
//            }
//        } else {
//            print("imgName is nil for project at index \(indexPath.item)")
//        }
        let project = projects[indexPath.row]

        if let imgPathsString = project.imgPath,
             let imgPathsData = imgPathsString.data(using: .utf8),
             let imageURLs = try? JSONSerialization.jsonObject(with: imgPathsData, options: []) as? [String] {
            let imagePath = documentsDirectory.appendingPathComponent(imageURLs[3] + ".jpg").path
            cell.img.image = UIImage(named: imagePath)
          } else {
              print("No image found")
          }
        
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hapticFeedBackAction()
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let vc = Storyboard.projects.instantiate(PreviewVc.self)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        let project = projects[indexPath.item]
        
//        if let imgName = project.imgPath {
//            let imagePath = documentsDirectory.appendingPathComponent(imgName + ".jpg").path
//            if fileManager.fileExists(atPath: imagePath) {
//                if let image = UIImage(contentsOfFile: imagePath) {
//                    present(vc, animated: true)
//                    vc.previewImg.image = image
//                    vc.textView.text = project.prompt
//                }
//            }
//
//        } else {
//            print("imgPath is nil for project at index \(indexPath.item)")
//        }

        
        if let imgPathsString = project.imgPath,
             let imgPathsData = imgPathsString.data(using: .utf8),
             let imageURLs = try? JSONSerialization.jsonObject(with: imgPathsData, options: []) as? [String] {
            present(vc, animated: true)
            let imagePath = documentsDirectory.appendingPathComponent(imageURLs[3] + ".jpg").path

            vc.previewImg.image = UIImage(named: imagePath)
            vc.textView.text = project.prompt
            vc.imgArray = imageURLs
            vc.imgUrl = imageURLs[3]
          }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = collectionView.frame.width/3 - 10
        if (UIDevice.current.userInterfaceIdiom == .pad){
            size = collectionView.frame.width/4  - 10
        }
        
        return CGSize(width: size, height: size)
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
       
        if isProUser {
            btnPro.isHidden = true
        }
    }
}
