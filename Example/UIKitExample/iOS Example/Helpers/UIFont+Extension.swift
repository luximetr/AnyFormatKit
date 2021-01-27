//
//  UIFont+Extension.swift
//  iOS Example
//
//  Created by Oleksandr Orlov on 24.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func monospaced(ofSize: CGFloat) -> UIFont {
        if #available(iOS 13.0, *) {
            return UIFont.monospacedSystemFont(ofSize: ofSize, weight: .regular)
        } else if #available(iOS 9.0, *) {
            return UIFont.monospacedDigitSystemFont(ofSize: ofSize, weight: .regular)
        } else if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: ofSize)
        } else {
            return UIFont.init(name: "Helvetica Neue", size: ofSize) ?? UIFont()
        }
    }
}
