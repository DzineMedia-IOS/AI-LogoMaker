//
//  PreviewVc.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/28/24.
//

import UIKit

class PreviewVc: UIViewController {
    @IBOutlet weak var btnExport: UIButton!
    
    @IBOutlet weak var btnCopyPrompt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnCopyPrompt.cornerRadius = 20
        btnCopyPrompt.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    
        applyGradientToButton(button: btnExport, colors: [UIColor.kRed,UIColor.accent])


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
