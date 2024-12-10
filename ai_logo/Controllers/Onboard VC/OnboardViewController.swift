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
        
        configureLottieAnimation()
        configurePageControl()
        configureBottomPadding()
        configureOnboardCollectionView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        
        pageControl.currentPage = Int(pageIndex) - 1
        currentPage = pageControl.currentPage
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        //            self.animationFlow(screen: Int(pageIndex))
        //        }
        
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
                let tabbar = Storyboard.main.instantiate(TabBarController.self)
                tabbar.modalPresentationStyle = .fullScreen
                self.removeSubviews(exceptTag: 10)
                
                present(tabbar, animated: true)
                //                if let window = UIApplication.shared.windows.first {
                //                        window.rootViewController = tabbar
                //                        window.makeKeyAndVisible()
                //                    }
            }
            
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)  // Ensure cell takes full screen width
    }
}

// MARK: - Configuration Methods

extension OnboardViewController {
    
    private func configureLottieAnimation() {
        setupLottieAnimation(
            name: .onboard_1,
            loopMode: .playOnce
        ) { finished in
            finished ? print("Animation Completed!") : print("Animation Interrupted!")
        }
    }
    
    private func configurePageControl() {
        pageControl.isHidden = true
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
    }
    
    private func configureBottomPadding() {
        bottomPadding.constant = UIDevice.current.userInterfaceIdiom == .pad ? 80 : 40
    }
    
    private func configureOnboardCollectionView() {
        let nib = UINib(nibName: "OnboardCell", bundle: nil)
        onboardCollectionView.register(nib, forCellWithReuseIdentifier: "OnboardCell")
        
        onboardCollectionView.delegate = self
        onboardCollectionView.dataSource = self
        onboardCollectionView.isPagingEnabled = true
        onboardCollectionView.showsHorizontalScrollIndicator = false
        onboardCollectionView.contentInsetAdjustmentBehavior = .never
        
        if let layout = onboardCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.itemSize = CGSize(
                width: onboardCollectionView.frame.width,
                height: onboardCollectionView.frame.height
            )
        }
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
        removeSubviews(exceptTag: 10)
        
        let animations: [(primary: AnimationFileName, secondary: AnimationFileName)] = [
            (.onboard_2, .onboard_2_1),
            (.onboard_3, .onboard_3_1),
            (.onboard_4, .onboard_4_1),
            //            (.onboard_3, .onboard_3_1),
            (.onboard_5, .onboard_5_1)
        ]

        guard screen > 0 && screen <= animations.count else { return }
        
        let animationPair = animations[screen - 1]
        
        if screen == 4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in

                setupLottieAnimation(name: animationPair.primary, loopMode: .playOnce) { [weak self] finished in
                    guard let self = self, finished else { return }
                    self.removeSubviews(exceptTag: 10)
                    self.setupLottieAnimation(name: animationPair.secondary, completion:{ _ in})
                }
            }
            
            
        }
        
        else{
            setupLottieAnimation(name: animationPair.primary, loopMode: .playOnce) { [weak self] finished in
                guard let self = self, finished else { return }
                self.removeSubviews(exceptTag: 10)
                self.setupLottieAnimation(name: animationPair.secondary, completion:{ _ in})
            }
        }
    }
    
    private func removeSubviews(exceptTag tag: Int) {
        for subview in animationView.subviews where subview.tag != tag {
            subview.removeFromSuperview()
        }
    }
    
}
