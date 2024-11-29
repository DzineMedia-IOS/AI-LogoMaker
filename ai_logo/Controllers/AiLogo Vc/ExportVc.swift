//
//  ExportVc.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/28/24.
//

import UIKit

class ExportVc: UIViewController {
    
    @IBOutlet weak var quality: UISegmentedControl!
    @IBOutlet weak var format: UISegmentedControl!
    @IBOutlet weak var exportView: UIView!
    @IBOutlet weak var collectionVIew: UICollectionView!
    @IBOutlet weak var btnPro: UIButton!
    @IBOutlet weak var downloadView: UIView!
    
    @IBOutlet weak var previewImg: UIImageView!
    @IBOutlet weak var mockWidth: NSLayoutConstraint!
    
    @IBOutlet weak var textViewWidth: NSLayoutConstraint!
    let imgArr = ["mock_1","mock_2", "mock_3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ProjectCell", bundle: nil)
        collectionVIew.register(nib, forCellWithReuseIdentifier: "ProjectCell")
        collectionVIew.delegate = self
        collectionVIew.dataSource = self
       
        let imageViewWidth = previewImg.bounds.width
        mockWidth.constant = imageViewWidth * 0.1
        textViewWidth.constant = imageViewWidth * 0.1
        
        DispatchQueue.main.async { [weak self] in
           
            self?.styleUI()
        }
        
        exportView.cornerRadius = 20
        exportView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        configureSegmentedControlAppearance(for: format)
        configureSegmentedControlAppearance(for: quality)
        addGestureDetector()
        
      
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        collectionVIew.reloadData()
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func downloadViewTapped() {
        animateTopView()
    }
    
    @IBAction func btnPro(_ sender: Any) {
        let vc = Storyboard.premium.instantiate(ProVC.self)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    
    }
    
    func animateTopView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.downloadView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.downloadView.transform = .identity
            }
        }
    }
    
}

//  MARK: - UICOLLECTIONVIEW CELL
extension ExportVc: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        cell.img.image = UIImage(named: imgArr[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/3 - 30, height: collectionView.frame.height - 20)
    }
    
}


// MARK: - STYLING UI

extension ExportVc {
    
    private func styleUI(){
        applyGradientToButton(
            button: btnPro,
            colors: [UIColor.kCream, UIColor.kDarkCream],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
    }
    
    func configureSegmentedControlAppearance(for segmentedControl: UISegmentedControl) {
        
        var fontSize = 14
        if ( UIDevice.current.userInterfaceIdiom == .pad ){
            fontSize = 28
        }
        let unselectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Outfit-Medium", size: CGFloat(fontSize)) ?? UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
        ]
        segmentedControl.setTitleTextAttributes(unselectedAttributes, for: .normal)
       
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "Outfit-Medium", size: CGFloat(fontSize)) ?? UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
        ]
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
    }
    
    func addGestureDetector(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(downloadViewTapped))
            downloadView.addGestureRecognizer(tapGesture)
    }
    
}
