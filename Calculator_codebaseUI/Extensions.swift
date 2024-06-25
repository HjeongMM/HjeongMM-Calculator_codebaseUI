//
//  Extensions.swift
//  Calculator_codebaseUI
//
//  Created by 임혜정 on 6/25/24.
//

import UIKit


// MARK: - Types
extension ViewController {
    typealias ButtonContent = (title: String, type: ButtonType)
    
    enum ButtonType {
        case number
        case `operator`
        case function
    }
}
// MARK: - ButtonAnimation
extension UIButton {
    func applyTouchAnimation() {
        self.addTarget(self, action: #selector(animateButtonDown), for: .touchDown)
        self.addTarget(self, action: #selector(animateButtonUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    @objc private func animateButtonDown(sender: UIButton) {
        animateButton(sender, alpha: 0.5)
    }
    
    @objc private func animateButtonUp(sender: UIButton) {
        animateButton(sender, alpha: 1.0)
    }
    
    private func animateButton(_ button: UIButton, alpha: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            button.alpha = alpha
        })
    }
}

