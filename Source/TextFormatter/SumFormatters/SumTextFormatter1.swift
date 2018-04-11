//
//  SumTextFormatter1.swift
//  AnyFormatKit
//
//  Created by branderstudio on 28.03.2018.
//  Copyright © 2018 BRANDERSTUDIO. All rights reserved.
//

import Foundation

class SumTextFormatter1: TextFormatter {
  // MARK: - Public fields
  open var decimalSeparator = DefaultValues.decimalSeparator
  open var groupingSeparator = DefaultValues.groupingSeparator
  open var groupingSize = DefaultValues.groupingSize
  
  // MARK: - Private fields
  
  // MARK: - Public
  open override func formattedText(from unformatted: String?) -> String? {
    guard let unformatted = unformatted else { return nil }
    return super.formattedText(from: unformatted)
  }
  
  open override func unformattedText(from formatted: String?) -> String? {
    guard let formatted = formatted else { return nil }
    return super.unformattedText(from: formatted)
  }
}

// MARK: - Constants
private extension SumTextFormatter1 {
  struct DefaultValues {
    static let decimalSeparator = "."
    static let groupingSeparator = ","
    static let groupingSize = 3
  }
}
