//
//  ViewController.swift
//  Calculator_codebaseUI
//
//  Created by 임혜정 on 6/24/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - UI Components
    private lazy var label: UILabel = UIComponents.makeLabel()
    private lazy var verticalStackView: UIStackView = UIComponents.makeVerticalStackView()
    
    // MARK: - Properties
    private var currentExpression: String = ""
    private var lastInputWasOperator: Bool = false
    private var finished: Bool = false
    
    // MARK: - Constants
    enum Constants {
        static let buttonSize: CGFloat = 80
        static let buttonCornerRadius: CGFloat = 40
        static let stackViewSpacing: CGFloat = 10
        static let labelWidth: CGFloat = 200
        static let labelHeight: CGFloat = 80
        static let labelTopOffset: CGFloat = 200
        static let labelRightOffset: CGFloat = -30
        static let stackViewWidth: CGFloat = 350
        static let stackViewTopOffset: CGFloat = 60
    }
    
    let buttonContents: [[ButtonContent]] = [
        [("7", .number), ("8", .number), ("9", .number), ("+", .operator)],
        [("4", .number), ("5", .number), ("6", .number), ("-", .operator)],
        [("1", .number), ("2", .number), ("3", .number), ("*", .operator)],
        [("AC", .function), ("0", .number), ("=", .function), ("/", .operator)]
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - UI Setup
    private func configureUI() {
        view.backgroundColor = .black
        setupLabel()
        setupVerticalStackView()
    }
    
    private func setupLabel() {
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.width.equalTo(Constants.labelWidth)
            $0.height.equalTo(Constants.labelHeight)
            $0.right.equalTo(view).offset(Constants.labelRightOffset)
            $0.top.equalTo(view).offset(Constants.labelTopOffset)
        }
    }
    
    private func setupVerticalStackView() {
        buttonContents.forEach { row in
            let horizontalStackView = UIComponents.createHorizontalStackView(with: row, target: self, action: #selector(buttonTapped(_:)))
            verticalStackView.addArrangedSubview(horizontalStackView)
        }
        
        view.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints {
            $0.width.equalTo(Constants.stackViewWidth)
            $0.top.equalTo(label.snp.bottom).offset(Constants.stackViewTopOffset)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Button Action
    @objc private func buttonTapped(_ sender: UIButton) {
        ButtonHandlers.buttonTapped(sender, viewController: self)
    }
    
    func appendToExpression(_ value: String) {
        if finished { //연산끝나고 새로운 값이 들어올 시 이전 결과값 초기화
            currentExpression = ""
            finished = false
        }
        currentExpression += value
        lastInputWasOperator = false
    }
    func appendOperator(_ op: String) {
        if !lastInputWasOperator && !currentExpression.isEmpty {
            currentExpression += op
            lastInputWasOperator = true
        }
    }
    func clearExpression() {
        currentExpression = ""
        lastInputWasOperator = false
    }
    
    func calculateResult() {
        guard !currentExpression.isEmpty else { return }
        
        // 마지막 문자가 연산자인 경우 제거, 첫번째 0일 경우 제거
        if "+-*/".contains(currentExpression.last!) {
            currentExpression.removeLast()
        } else if "0".contains(currentExpression.first!) {
            currentExpression.removeFirst()
        }
        
        guard let result = calculate(expression: currentExpression) else {
            label.text = "Error"
            return
        }
        currentExpression = String(result)
        lastInputWasOperator = false
        finished = true
    }
    
    func updateLabel() {
        label.text = currentExpression.isEmpty ? "0" : currentExpression
    }
    
    // MARK: - Calculation
    private func calculate(expression: String) -> Int? {
        // 유효성 검사
        guard expression.range(of: "^[0-9+\\-*/]+$", options: .regularExpression) != nil else {
            return nil
        }
        
        let expr = NSExpression(format: expression)
        if let result = expr.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
    
}
