//
//  ExampleView.swift
//  iOS Example
//
//  Created by Oleksandr Orlov on 24.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

class ExampleView: InitView {
    
    // UI elements
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let phoneNumberInputView = TitleTextFieldView()
    let cardNumberInputView = CardInfoView()
    let moneyInputView = TitleTextFieldView()
    
    private let verticalOffset = 20
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        setupScrollView()
        setupContentView()
        setupPhoneNumberInputView()
        setupCardNumberInputView()
        setupMoneyInputView()
    }
    
    // MARK: - Prepare layout
    
    override func prepareLayout() {
        super.prepareLayout()
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(phoneNumberInputView)
        contentView.addSubview(cardNumberInputView)
        contentView.addSubview(moneyInputView)
        prepareLayoutScrollView()
        prepareLayoutContentView()
        prepareLayoutPhoneNumberInputView()
        prepareLayoutCardNumberInputView()
        prepareLayoutMoneyInputView()
    }
    
    // MARK: - Setup scrollView
    
    private func setupScrollView() {
        
    }
    
    private func prepareLayoutScrollView() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().inset(40)
            make.trailing.leading.equalToSuperview()
        }
    }
    
    // MARK: - Setup contentView
    
    private func setupContentView() {
        
    }
    
    private func prepareLayoutContentView() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // MARK: - Setup phoneNumberInputView
    
    private func setupPhoneNumberInputView() {
        phoneNumberInputView.titleLabel.text = "Phone number"
    }
    
    private func prepareLayoutPhoneNumberInputView() {
        phoneNumberInputView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
        }
    }
    
    // MARK: - Setup cardNumberInputView
    
    private func setupCardNumberInputView() {
        cardNumberInputView.titleLabel.text = "Card number"
    }
    
    private func prepareLayoutCardNumberInputView() {
        cardNumberInputView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(phoneNumberInputView)
            make.top.equalTo(phoneNumberInputView.snp.bottom).offset(verticalOffset)
        }
    }
    
    // MARK: - Setup sumInputView
    
    private func setupMoneyInputView() {
        moneyInputView.titleLabel.text = "Money"
    }
    
    private func prepareLayoutMoneyInputView() {
        moneyInputView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(cardNumberInputView)
            make.top.equalTo(cardNumberInputView.snp.bottom).offset(verticalOffset)
            make.bottom.equalToSuperview()
        }
    }
}
