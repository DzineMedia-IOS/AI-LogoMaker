import UIKit
import Lottie
import AVKit
import AVFoundation


class OnboardViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var onboardCollectionView: UICollectionView!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var bottomPadding: NSLayoutConstraint!
    var isloopMode: Bool = false
    
    var isFirstScreen: Bool = true
    
    var tagID = 100
    var currentAnimation: Int = 1
    var titlArr = [
        "Welcome to AI Logo Maker",
        "Endless Templates, Endless Possibilities",
        "Perfect for Any Business",
        "Design Like a Pro in Minutes",
        "Generate Artwork with Creative Prompts",
    ]
    
    let subtitles: [String] = [
        "Instant logo designs at your fingertips. Craft professional logos with AI magic",
        "Pick a template, personalize it, and make it yours instantly",
        "From tech to fashion, gaming to tattoos, find stunning logos for every industry",
        "No design skills needed. Let AI make the job easy for you",
        "Transform your ideas into reality with a logo that embodies your vision",
        ]
    
    let videoPairs: [(primary: AnimationVideoName, secondary: AnimationVideoName)] = [
        (.onboard_2, .onboard_2_1),
        (.onboard_3, .onboard_3_1),
        (.onboard_4, .onboard_4_1),
        (.onboard_5, .onboard_5_1)
    ]
    
    let animations: [(primary: AnimationFileName, secondary: AnimationFileName)] = [
        (.onboard_2, .onboard_2_1),
        (.onboard_3, .onboard_3_1),
        (.onboard_4, .onboard_4_1),
        (.onboard_5, .onboard_5_1)
    ]
    
    
    var currentPage: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLottieAnimation()
        configurePageControl()
        configureBottomPadding()
        configureOnboardCollectionView()
        
    }

    override func viewDidLayoutSubviews() {
        configureBottomPadding()

    }
    
    @IBAction func btnTermOfUse(_ sender: Any) {
        if let privacy = URL(string: Url.appTerms) {
            presentURLPages(from: self, url: privacy,height: 400)
        }
    }
    
  
    @IBAction func btnPrivacy(_ sender: Any) {
    
    if let privacy = URL(string: Url.appPrivacy) {
        presentURLPages(from: self, url: privacy,height: 400)
    }
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
       
        /*isFirstScreen ? (cell.lblTitle.text = titlArr[currentPage] ) :*/ (cell.lblTitle.text = titlArr[indexPath.row])
        cell.lblSubtitle.text = subtitles [indexPath.row]
        cell.buttonActionClosure = { [self] in
        
            if !isFirstScreen {
                self.removeSubviews(exceptTag: 10)
                UserDefaults.standard.set(true, forKey: onBoardKey)

                let vc = Storyboard.main.instantiate(TabBarController.self)
                vc.modalPresentationStyle = .fullScreen
//                present(vc, animated: true)
                                if let window = UIApplication.shared.windows.first {
                                        window.rootViewController = vc
                                        window.makeKeyAndVisible()
                                    }
            }
            else{
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
        if isFirstScreen {
            setupLottieAnimation(
                name: .onboard_1
//                loopMode: .playOnce
            ) { [self] finished in
//                finished ? print("Animation Completed!") : print("Animation Interrupted!")
            }
        }
        else {
            onboardCollectionView.isHidden = true
            onboardCollectionView.alpha = 0.0
            setupLottieAnimation(
                name: .onboard_5,
                loopMode: .playOnce
            ) { finished in
//                finished ? print("Animation Completed!") : print("Animation Interrupted!")
                self.animatieOnboarding()
                self.removeSubviews(exceptTag: 10)
                self.setupLottieAnimation(name: .onboard_5_1, completion:{ _ in})
            }
        }
        
        
        
        
        
        //        setupVideoPlayback(videoName: AnimationVideoName.onboard_1, loopMode: true) { [weak self] finished in
        //            print("aniamtion end")
        //        }
        
        
    }
    
    private func configurePageControl() {
        if isFirstScreen {
            pageControl.isHidden = true
            pageControl.numberOfPages = 4
            pageControl.currentPage = 0
            pageControl.hidesForSinglePage = true
        }
        else{
            pageControl.numberOfPages = 4
            pageControl.currentPage = currentPage
            pageControl.hidesForSinglePage = false
            buttonView.isHidden = true
            pageControl.isHidden = false
//            let indexPath = IndexPath(item: currentPage, section: 0)
//            onboardCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        
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
extension OnboardViewController {
    func animatieOnboarding() {
        onboardCollectionView.alpha = 0.0
        onboardCollectionView.isHidden = false
        onboardCollectionView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.onboardCollectionView.alpha = 1.0
            self.onboardCollectionView.transform = .identity
        }, completion: nil)
    }

}
//MARK: LOTTIE ANIMATIONS

extension OnboardViewController {
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
        lottieAnimation.animationSpeed = 0.5
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
        onboardCollectionView.isHidden = true
        animationView.alpha = 0.0
        
        let animations: [(primary: AnimationFileName, secondary: AnimationFileName)] = [
            (.onboard_2, .onboard_2_1),
            (.onboard_3, .onboard_3_1),
            (.onboard_4, .onboard_4_1),
            (.onboard_5, .onboard_5_1)
        ]
        
        guard screen > 0 && screen <= animations.count else { return }
        
        let animationPair = animations[screen - 1]
        
        if screen == 4 {
            
            //                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            //
            //                    setupLottieAnimation(name: animationPair.primary, loopMode: .playOnce) { [weak self] finished in
            //                        guard let self = self, finished else { return }
            //                        self.removeSubviews(exceptTag: 10)
            //                        self.setupLottieAnimation(name: animationPair.secondary, completion:{ _ in})
            //                    }
            //                }
            
            let vc = Storyboard.main.instantiate(OnboardViewController.self)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.currentPage = 4
            vc.isFirstScreen = false
            vc.titlArr[0] = titlArr[4]
            present(vc, animated: true)
            
            
        }
        
        else{
            UIView.animate(withDuration: 0.5, animations: { [self] in
                animationView.alpha = 1.0
            })
            setupLottieAnimation(name: animationPair.primary, loopMode: .playOnce) { [weak self] finished in
                guard let self = self, finished else { return }
                self.removeSubviews(exceptTag: 10)
//
                animatieOnboarding()
                

                self.setupLottieAnimation(name: animationPair.secondary, completion:{ _ in})
            }
        }
    }
    
    private func removeSubviews(exceptTag tag: Int) {
        // Remove all subviews except the ones with the specified tag
        for subview in animationView.subviews where subview.tag != tag {
            subview.removeFromSuperview()
        }
    }
}
