//
//  HapticManager.swift
//  ai_logo
//
//  Created by LAP__TECH on 12/11/24.
//


import UIKit

class HapticManager {
    static func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}

// usage
//HapticManager.triggerHapticFeedback(style: .light)



func isHapticFeedbackEnabled() -> Bool {
    return UserDefaults.standard.bool(forKey: hapticFeedbackKey) ?? false
}

extension UIButton {
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if UserDefaults.standard.bool(forKey: hapticFeedbackKey) {
            HapticManager.triggerHapticFeedback(style: .medium)
        }
    }
}

func hapticFeedBackAction() {
    if UserDefaults.standard.bool(forKey: hapticFeedbackKey) {
               HapticManager.triggerHapticFeedback(style: .medium)
           }
}

