//
//  LoaderVC.swift
//  ai_logo
//
//  Created by LAP__TECH on 12/11/24.
//

import UIKit
import Lottie

class LoaderVC: UIViewController {
    @IBOutlet weak var lblSec: UILabel!
    @IBOutlet weak var animationView: UIView!
    
    var prompt: String = ""
    private var timer: Timer?
    private var startTime: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        setupAnimation()
        generateLogo(prompt: prompt)
    }
    
    private func startTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSeconds), userInfo: nil, repeats: true)
    }
    
    @objc private func updateSeconds() {
        guard let startTime = startTime else { return }
        let elapsedTime = Date().timeIntervalSince(startTime)
        lblSec.text = String(format: "%.2fs", elapsedTime)
    }
    private func setupAnimation(){
        let lottieAnimation = LottieAnimationView(name: "loader")
        lottieAnimation.frame = animationView.bounds
        lottieAnimation.contentMode = .scaleAspectFit
        lottieAnimation.loopMode = .loop
        animationView.addSubview(lottieAnimation)
        lottieAnimation.play { finished in
            
        }
        
    }
    
    private func generateLogo(prompt: String) {
        APIManager.shared.generateLogo(prompt: prompt) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let response):
                    print("Logo Generation Results:")
                    print("Cost:", response.cost)
                    print("Seed:", response.seed)
                    print("Logo URL:", response.url)
                    
                    
                    
                    CoreDataManager.shared.saveImageFromURLToDocumentsDirectory(response.url, withName: "1") { [self] savedPath in
                        if let path = savedPath {
                            let vc = Storyboard.aiLogo.instantiate(ExportVC.self)
                            vc.modalPresentationStyle = .fullScreen
                            DispatchQueue.main.async {
                                self.present(vc, animated: true) {
                                    vc.lblPrompt.text = prompt
                                    vc.previewImg.image = UIImage(contentsOfFile: path)
                                    
                                }
                            }
                        }
//                        CoreDataManager.shared.saveRecord(prompt: prompt, imageURL: response.url)
                    }
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                    
                    // Show an alert to the user if needed
                }
            }
        }
    }
    
    
    deinit {
        timer?.invalidate()
    }
    
    
}
