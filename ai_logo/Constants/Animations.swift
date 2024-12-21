//
//  Animations.swift
//  ai_logo
//
//  Created by LAP__TECH on 12/6/24.
//

import Foundation
import Lottie
enum AnimationFileName: String {
//    case banner = "banner"
//    case onboard_1 = "1_Onboarding"
//    case onboard_2 = "2nd_1_Onboarding"
//    case onboard_2_1 = "2nd_2_Onboarding"
//    case onboard_3 = "3rd_1_Onboarding"
//    case onboard_3_1 = "3rd_2_Onboarding"
//    case onboard_4 = "4rth_1_Onboarding"
//    case onboard_4_1 = "4rth_2_Onboarding"
//    case onboard_5 = "5th_1_Onboarding"
//    case onboard_5_1 = "5th(2)Onboarding"
//    case loader = "loader_ai_1"
    
    case banner = "Generate screen animation"
    case onboard_1 = "1 Onboarding"
    case onboard_2 = "2nd (1) Onboarding"
    case onboard_2_1 = "2nd (2) Onboarding"
    case onboard_3 = "3rd (1) Onboarding"
    case onboard_3_1 = "3rd (2) Onboarding"
    case onboard_4 = "4rth (1) Onboarding"
    case onboard_4_1 = "4rth (2) Onboarding"
    case onboard_5 = "5th (1) Onboarding"
    case onboard_5_1 = "5th (2) Onboarding"
    case loader = "loader_ai_1"
}


extension LottieAnimationView {
    convenience init(name: AnimationFileName) {
        self.init(name: name.rawValue)
    }
}


enum AnimationVideoName: String {
    
    case onboard_1 = "1st Onboarding"
    case onboard_2 = "2nd 1 Onboarding"
    case onboard_2_1 = "2nd 2 Onboardings"
    case onboard_3 = "3rd 1 Onboarding"
    case onboard_3_1 = "3rd 2 Onboarding"
    case onboard_4 = "4rth 1 Onboarding"
    case onboard_4_1 = "4rth 2 OnBoarding"
    case onboard_5 = "5th 1 Onboarding"
    case onboard_5_1 = "5th 2 Onboarding"
}
