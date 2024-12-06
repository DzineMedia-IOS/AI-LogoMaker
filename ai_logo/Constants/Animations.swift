//
//  Animations.swift
//  ai_logo
//
//  Created by LAP__TECH on 12/6/24.
//

import Foundation
import Lottie
enum AnimationFileName: String {
    case banner = "banner"
    case onboard_1 = "1_Onboarding"
    case onboard_2 = "2nd_1_Onboarding"
    case onboard_2_1 = "2nd_2_Onboarding"
    case onboard_3 = "3rd_1_Onboarding"
    case onboard_3_1 = "3rd_2_Onboarding"
    case onboard_4 = "4rth_1_Onboarding"
    case onboard_4_1 = "4rth_2_Onboarding"
    case onboard_5 = "5th_1_Onboarding"
    case onboard_5_1 = "5th_2_Onboarding"
}


extension LottieAnimationView {
    convenience init(name: AnimationFileName) {
        self.init(name: name.rawValue)
    }
}

