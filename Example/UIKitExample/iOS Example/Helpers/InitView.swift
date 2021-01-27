//
//  InitView.swift
//  iOS Example
//
//  Created by Oleksandr Orlov on 24.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit
import SnapKit

class InitView: UIView {
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        intialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        intialSetup()
    }
    
    private func intialSetup() {
        setup()
        prepareLayout()
    }
    
    func prepareLayout() {
        
    }
    
    func setup() {
        
    }
    
}
