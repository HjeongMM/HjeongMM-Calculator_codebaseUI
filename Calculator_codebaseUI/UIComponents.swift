//
//  UIComponents.swift
//  Calculator_codebaseUI
//
//  Created by 임혜정 on 6/25/24.
//

import UIKit
import SnapKit

struct UIComponents {
    
    static func makeLabel() -> UILabel {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 60, weight: .bold)
        return label
    }
    
    static func makeVerticalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .black
        stackView.spacing = ViewController.Constants.stackViewSpacing
        stackView.distribution = .fillEqually
        return stackView
    }
    
    static func createHorizontalStackView(with contents: [ViewController.ButtonContent], target: Any?, action: Selector) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = ViewController.Constants.stackViewSpacing
        stackView.distribution = .fillEqually
        
        contents.forEach { content in
            let button = createButton(with: content, target: target, action: action)
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }
    
    static func createButton(with content: ViewController.ButtonContent, target: Any?, action: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(content.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .light)
        button.backgroundColor = backgroundColor(for: content.type)
        button.layer.cornerRadius = ViewController.Constants.buttonCornerRadius
        button.clipsToBounds = true
        button.applyTouchAnimation()
        button.addTarget(target, action: action, for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.width.height.equalTo(ViewController.Constants.buttonSize)
        }
        return button
    }
    
    private static func backgroundColor(for type: ViewController.ButtonType) -> UIColor {
        switch type {
        case .number:
            return UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
        case .operator:
            return .orange
        case .function:
            return .orange
        }
    }
}
