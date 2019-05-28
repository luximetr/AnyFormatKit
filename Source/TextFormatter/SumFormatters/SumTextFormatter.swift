//
//  SumTextFormatter.swift
//  AnyFormatKit
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

open class SumTextFormatter: TextFormatterProtocol {
  
  private let numberFormatter: NumberFormatter
  
  public init(numberFormatter: NumberFormatter) {
    self.numberFormatter = numberFormatter
  }
  
  public init(textPattern: String, patternSymbol: Character = "#") {
    let formatParser = SumFormatParser()
    let result = formatParser.parse(format: textPattern, patternSymbol: patternSymbol)
    let numberFormatter = NumberFormatter()
    numberFormatter.positivePrefix = result.prefix
    numberFormatter.positiveSuffix = result.suffix
    numberFormatter.groupingSeparator = result.groupingSeparator
    numberFormatter.decimalSeparator = result.decimalSeparator
    numberFormatter.groupingSize = result.groupingSize
    numberFormatter.maximumFractionDigits = result.maximumFractionDigits
    numberFormatter.minimumIntegerDigits = 1
    numberFormatter.allowsFloats = true
    numberFormatter.usesGroupingSeparator = true
    self.numberFormatter = numberFormatter
  }
  
  open func formattedText(from unformatted: String?) -> String? {
    guard let unformatted = unformatted else { return nil }
    guard !unformatted.isEmpty else { return "" }
    let correctedUnformatted = unformatted.replacingOccurrences(of: ",", with: unformattedDecimalSeparator)
    let number = NSDecimalNumber(string: correctedUnformatted)
    return numberFormatter.string(from: number)
  }
  
  private let unformattedDecimalSeparator = "."
  private var unformattedNumberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.allowsFloats = true
    numberFormatter.maximumFractionDigits = Int.max
    numberFormatter.maximumIntegerDigits = Int.max
    numberFormatter.decimalSeparator = "."
    return numberFormatter
  }()
  
  open func unformattedText(from formatted: String?) -> String? {
    guard let number = numberFormatter.number(from: formatted ?? "") else { return nil }
    return String(number.floatValue)
  }
}
