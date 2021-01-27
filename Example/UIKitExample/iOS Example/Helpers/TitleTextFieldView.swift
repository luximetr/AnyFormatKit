//
//  TitleTextFieldView.swift
//  iOS Example
//
//  Created by Oleksandr Orlov on 24.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

class TitleTextFieldView: InitView {
    
    // MARK: - UI elements
    
    let titleLabel = UILabel()
    let textField = UITextField()
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        setupTitleLabel()
        setupTextField()
    }
    
    // MARK: - Prepare layout
    
    override func prepareLayout() {
        super.prepareLayout()
        addSubview(titleLabel)
        addSubview(textField)
        prepareLayoutTitleLabel()
        prepareLayoutTextField()
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
    
    // MARK: - Setup textField
    
    private func setupTextField() {
        textField.textColor = .white
        textField.backgroundColor = .darkGray
        textField.font = .monospaced(ofSize: 18)
    }
    
    private func prepareLayoutTextField() {
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
    }
}
