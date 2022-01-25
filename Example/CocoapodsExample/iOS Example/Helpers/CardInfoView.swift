//
//  CardInfoView.swift
//  iOS Example
//
//  Created by Oleksandr Orlov on 24.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

class CardInfoView: InitView {
    
    // MARK: - UI elements
    
    let titleLabel = UILabel()
    let cardNumberTextField = UITextField()
    let expirationTextField = UITextField()
    let cvvTextField = UITextField()
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        setupTitleLabel()
        setupCardNumberTextField()
        setupExpirationTextField()
        setupCvvTextField()
    }
    
    // MARK: - Prepare layout
    
    override func prepareLayout() {
        super.prepareLayout()
        addSubview(titleLabel)
        addSubview(cardNumberTextField)
        addSubview(expirationTextField)
        addSubview(cvvTextField)
        prepareLayoutTitleLabel()
        prepareLayoutCardNumberTextField()
        prepareLayoutExpirationTextField()
        prepareLayoutCvvTextField()
    }
    
    // MARK: - Setup titleLabel
    
    private func setupTitleLabel() {
        titleLabel.textColor = .white
    }
    
    private func prepareLayoutTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Setup cardNumberTextField
    
    private func setupCardNumberTextField() {
        cardNumberTextField.backgroundColor = .darkGray
        cardNumberTextField.textColor = .white
        cardNumberTextField.font = UIFont.monospaced(ofSize: 18)
    }
    
    private func prepareLayoutCardNumberTextField() {
        cardNumberTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.height.equalTo(44)
        }
    }
    
    // MARK: - Setup expirationTextField
    
    private func setupExpirationTextField() {
        expirationTextField.backgroundColor = .darkGray
        expirationTextField.textColor = .white
        expirationTextField.font = UIFont.monospaced(ofSize: 18)
    }
    
    private func prepareLayoutExpirationTextField() {
        expirationTextField.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(44)
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(1)
        }
    }
    
    // MARK: - Setup cvvTextField
    
    private func setupCvvTextField() {
        cvvTextField.backgroundColor = .darkGray
        cvvTextField.textColor = .white
        cvvTextField.font = UIFont.monospaced(ofSize: 18)
    }
    
    private func prepareLayoutCvvTextField() {
        cvvTextField.snp.makeConstraints { make in
            make.bottom.height.equalTo(expirationTextField)
            make.leading.equalTo(expirationTextField.snp.trailing).offset(1)
            make.width.equalTo(70)
        }
    }
    
}
