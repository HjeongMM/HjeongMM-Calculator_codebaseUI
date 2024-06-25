//
//  ButtonHandlers.swift
//  Calculator_codebaseUI
//
//  Created by 임혜정 on 6/25/24.
//

import UIKit

// MARK: - Button Action
struct ButtonHandlers {
    static func buttonTapped(_ sender: UIButton, viewController: ViewController) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        switch buttonTitle {
        case "=":
            viewController.calculateResult()
        case "AC":
            viewController.clearExpression()
        case "+", "-", "*", "/":
            viewController.appendOperator(buttonTitle)
        default:
            viewController.appendToExpression(buttonTitle)
        }
        
        viewController.updateLabel()
    }
    
}
