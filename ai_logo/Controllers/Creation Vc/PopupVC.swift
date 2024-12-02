//
//  PopupVc.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/29/24.
//

import UIKit

class PopupVc: UIViewController {

    @IBOutlet weak var btnOffer: UIButton!
    @IBOutlet weak var lbl0ff: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let size = view.frame.height * 0.10
        
        // Do any additional setup after loading the view.
        lbl0ff.font = lbl0ff.font.withSize(size)
        
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
    }
    

    @IBAction func btnCancel(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("popUp"), object: nil)

    }
    
}


extension PopupVc {
    
    private func styleUI(){
        applyGradientToButton(
            button: btnOffer,
            colors: [UIColor.accent, UIColor.kRed],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
    }
}
