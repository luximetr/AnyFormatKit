//
//  AnyFormatKitUITextField.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 28.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

open class AnyFormatUITextField: UITextField {
    
    private let controller = TextFieldInputController()
    
    open var formatter: TextInputFormatter? {
        didSet { controller.formatter = formatter }
    }
    
    // MARK: - Life cycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        delegate = controller
    }
}
