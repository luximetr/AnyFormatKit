//
//  TextFormatter.swift
//  TextInput
//
//  Created by Oleksandr Orlov on 18.10.2017.
//  Copyright © 2017 Oleksandr Orlov. All rights reserved.
//

import Foundation

/// Interface of text formatter
public protocol TextFormatter {
  /**
   Formatting text with current textPattern
   
   - Parameters:
     - unformatted: String to convert
   
   - Returns: Formatted text
   */
  func format(_ unformattedText: String?) -> String?
}


