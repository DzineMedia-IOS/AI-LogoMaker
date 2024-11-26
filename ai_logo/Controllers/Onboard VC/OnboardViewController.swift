import UIKit

class OnboardViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var onboardCollectionView: UICollectionView!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var bottomPadding: NSLayoutConstraint!
    let titlArr = [
        "Welcome to AI Logo Maker",
        "Your Logo, AI-Powered",
        "See Your Brand Shine",
        "Generate Various Logos With One Click",
        "Generate Artwork With Creative Prompts",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.isHidden = true
        bottomPadding.constant = 40
        
        
        let nib = UINib(nibName: "OnboardCell", bundle: nil)
        onboardCollectionView.register(nib, forCellWithReuseIdentifier: "OnboardCell")
        
        onboardCollectionView.delegate = self
        onboardCollectionView.dataSource = self
        onboardCollectionView.isPagingEnabled = true
        onboardCollectionView.showsHorizontalScrollIndicator = false
        onboardCollectionView.contentInsetAdjustmentBehavior = .never
        
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
        
        if let layout = onboardCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.itemSize = CGSize(width: onboardCollectionView.frame.width, height: onboardCollectionView.frame.height)
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
       
        pageControl.currentPage = Int(pageIndex - 1)
        
        if pageIndex > 0{
            buttonView.isHidden = true
            pageControl.isHidden = false
        }
         
        else{
            buttonView.isHidden = false
            pageControl.isHidden = true
        }
    }
}

extension OnboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titlArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardCell", for: indexPath) as! OnboardCell
        cell.buttonActionClosure = { [self] in
            print("Button tapped at index: \(indexPath.item)")
            
            cell.lblTitle.text = titlArr[indexPath.row]
            let nextPage = pageControl.currentPage + 1
            if nextPage < titlArr.count {
                pageControl.currentPage = nextPage
                DispatchQueue.main.async { [self] in
                    let xOffset = CGFloat(nextPage) * collectionView.frame.width
                    collectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
                    
                }
            }
            if indexPath.row > 0{
                buttonView.isHidden = true
                pageControl.isHidden = false
            }
            else{
                buttonView.isHidden = false
                pageControl.isHidden = true
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)  // Ensure cell takes full screen width
    }
}
