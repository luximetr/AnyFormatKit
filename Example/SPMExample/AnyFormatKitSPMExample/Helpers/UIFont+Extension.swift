//
//  UIFont+Extension.swift
//  AnyFormatKitSPMExample
//
//  Created by Oleksandr Orlov on 25.01.2022.
//

import UIKit

extension UIFont {
    
    static func monospaced(ofSize: CGFloat) -> UIFont {
        if #available(iOS 13.0, *) {
            return UIFont.monospacedSystemFont(ofSize: ofSize, weight: .regular)
        } else {
            return UIFont.monospacedDigitSystemFont(ofSize: ofSize, weight: .regular)
        }
    }
}
