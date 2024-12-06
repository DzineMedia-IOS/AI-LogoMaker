import UIKit
import Lottie

class OnboardViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var onboardCollectionView: UICollectionView!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var bottomPadding: NSLayoutConstraint!
    var tagID = 100
    let titlArr = [
        "Welcome to AI Logo Maker",
        "Your Logo, AI-Powered",
        "See Your Brand Shine",
        "Generate Various Logos With One Click",
        "Generate Artwork With Creative Prompts",
    ]
    //
    
    var currentPage: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupLottieAnimation(
            name: .onboard_1,
            loopMode: .playOnce
        ) { finished in
            if finished {
                print("Animation Completed!")
            } else {
                print("Animation Interrupted!")
            }
        }
        
        pageControl.isHidden = true
        UIDevice.current.userInterfaceIdiom == .pad ? (bottomPadding.constant = 80) : (bottomPadding.constant = 40)
        
        
        
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
        
        pageControl.currentPage = Int(pageIndex) - 1
        currentPage = pageControl.currentPage
        self.animationFlow(screen: Int(pageIndex))

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
        cell.lblTitle.text = titlArr[indexPath.row]
        
        cell.buttonActionClosure = { [self] in
            cell.lblTitle.text = titlArr[indexPath.row]
            let nextPage = currentPage + 1

            if nextPage < titlArr.count {
                if indexPath.row < titlArr.count - 1{
                    
                    
                    let nextIndexPath = IndexPath(item: indexPath.row + 1, section: 0)
                    self.onboardCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                }
                pageControl.currentPage = nextPage
                currentPage = pageControl.currentPage

                self.animationFlow(screen: currentPage)
            }
            if indexPath.row > 0{
                buttonView.isHidden = true
                pageControl.isHidden = false
            }
            else{
                buttonView.isHidden = false
                pageControl.isHidden = true
            }
            
            
            
            
            if indexPath.item == titlArr.count - 1 {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                let tabbar = Storyboard.main.instantiate(TabBarController.self)
                tabbar.modalPresentationStyle = .fullScreen
//                present(tabbar, animated: true)
                if let window = UIApplication.shared.windows.first {
                        window.rootViewController = tabbar
                        window.makeKeyAndVisible()
                    }
            }
            
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)  // Ensure cell takes full screen width
    }
}





// MARK: - ANIMATION
extension  OnboardViewController {
   
    
    func setupLottieAnimation(
        name: AnimationFileName,
        loopMode: LottieLoopMode = .loop,
        completion: @escaping (Bool) -> Void
    ) {
        
        let lottieAnimation = LottieAnimationView(name: name)
        lottieAnimation.frame = animationView.bounds
        lottieAnimation.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lottieAnimation.contentMode = .scaleAspectFill
        lottieAnimation.loopMode = loopMode
        lottieAnimation.tag = tagID
        tagID += 1
        animationView.addSubview(lottieAnimation)
        
        // Start playing the animation
        lottieAnimation.play { finished in
            completion(finished)
        }
    }
    
    func animationFlow(screen: Int) {
        switch screen {
        case 0:
            for subview in animationView.subviews where subview.tag != 100 {
                subview.removeFromSuperview()
            }
        case 1:
            for subview in animationView.subviews where subview.tag != 100 {
                subview.removeFromSuperview()
            }
            
            setupLottieAnimation(
                name: .onboard_2,
                loopMode: .playOnce
            ) { [weak self] finished in
                guard let self = self else { return }
                if finished {
                    for subview in self.animationView.subviews where subview.tag != 100 {
                        subview.removeFromSuperview()
                    }
                    
                    self.setupLottieAnimation(
                        name: .onboard_2_1
                    ) { _ in }
                }
            }
           
        case 2:
            
            for subview in animationView.subviews where subview.tag != 100 {
                subview.removeFromSuperview()
            }
            
            setupLottieAnimation(
                name: .onboard_3,
                loopMode: .playOnce
            ) { [weak self] finished in
                guard let self = self else { return }
                if finished {
                    for subview in self.animationView.subviews where subview.tag != 100 {
                        subview.removeFromSuperview()
                    }
                    
                    self.setupLottieAnimation(
                        name: .onboard_3_1
                    ) { _ in }
                }
            }
           
        case 3:
            
            for subview in animationView.subviews where subview.tag != 100 {
                subview.removeFromSuperview()
            }
            
            setupLottieAnimation(
                name: .onboard_4,
                loopMode: .playOnce
            ) { [weak self] finished in
                guard let self = self else { return }
                if finished {
                    for subview in self.animationView.subviews where subview.tag != 100 {
                        subview.removeFromSuperview()
                    }
                    
                    self.setupLottieAnimation(
                        name: .onboard_4_1
                    ) { _ in }
                }
            }
           
        case 4:
            
            for subview in animationView.subviews where subview.tag != 100 {
                subview.removeFromSuperview()
            }
            
            setupLottieAnimation(
                name: .onboard_5,
                loopMode: .playOnce
            ) { [weak self] finished in
                guard let self = self else { return }
                if finished {
                    for subview in self.animationView.subviews where subview.tag != 100 {
                        subview.removeFromSuperview()
                    }
                    
                    self.setupLottieAnimation(
                        name: .onboard_5_1
                    ) { _ in }
                }
            }
           
        default:
            break
        }
    }

}
