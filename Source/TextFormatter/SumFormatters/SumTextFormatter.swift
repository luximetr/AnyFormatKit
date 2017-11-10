//
//  SumTextFormatter.swift
//  AnyFormatKit
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

class SumTextFormatter: TextFormatterProtocol {
  var allowsFloats: Bool
  var prefix: String?
  var suffix: String?
  
  var decimalSeparator: String
  var groupingSeparator: String
  
  var minimumIntegerDigits: Int
  var maximumIntegerDigits: Int
  var minimumFractionDigits: Int
  var maximumFractionDigits: Int
  
  var minusSign: String
  var groupingSize: Int
  
  internal let numberFormatter = NumberFormatter()
  
  public init() {
    allowsFloats = numberFormatter.allowsFloats
    decimalSeparator = numberFormatter.decimalSeparator
    groupingSeparator = numberFormatter.groupingSeparator
    minimumIntegerDigits = numberFormatter.minimumIntegerDigits
    maximumIntegerDigits = numberFormatter.maximumIntegerDigits
    minimumFractionDigits = numberFormatter.minimumFractionDigits
    maximumFractionDigits = numberFormatter.maximumFractionDigits
    minusSign = numberFormatter.minusSign
    groupingSize = numberFormatter.groupingSize
  }
  
  func formattedText(from unformatted: String?) -> String? {
    return unformatted
  }
  
  func unformattedText(from formatted: String?) -> String? {
    return formatted
  }
}
