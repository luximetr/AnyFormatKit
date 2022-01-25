//
//  InitView.swift
//  AnyFormatKitSPMExample
//
//  Created by Oleksandr Orlov on 25.01.2022.
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
