//
//  SumTextInputFormatter.swift
//  AnyFormatKit
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

open class SumTextInputFormatter: SumTextFormatter, TextInputFormatter {
  
  // MARK: - Init
  /**
   Initializes formatter with patternString

   - Parameters:
   - textPattern: String with special characters, that will be used for formatting
   - patternSymbol: Optional parameter, that represent character, that will be replaced in formatted string
   */
  private let caretPositionCalculator: SumTextInputFormatterCaretPositionCalculator
  
  public override init(numberFormatter: NumberFormatter) {
    caretPositionCalculator = SumTextInputFormatterCaretPositionCalculator(
      decimalSeparator: numberFormatter.decimalSeparator,
      suffix: numberFormatter.positiveSuffix,
      prefix: numberFormatter.positivePrefix)
    super.init(numberFormatter: numberFormatter)
  }
  
  override open func format(_ unformatted: String?) -> String? {
    guard let unformatted = unformatted else { return nil }
    let minimumFractionDigits = calculateMinimumFractionDigits(unformatted: unformatted, divider: decimalSeparator, maximumFractionDigits: numberFormatter.maximumFractionDigits)
    numberFormatter.minimumFractionDigits = minimumFractionDigits
    
    let needAlwaysShowDecimalSeparator = minimumFractionDigits == 0 && unformatted.contains(decimalSeparator)
    numberFormatter.alwaysShowsDecimalSeparator = needAlwaysShowDecimalSeparator
    
    numberFormatter.minimumIntegerDigits = calculateMinimumIntegerDigits(unformatted: unformatted, decimalSeparator: decimalSeparator)
    if unformatted == decimalSeparator {
      return (prefix ?? "") + decimalSeparator + (suffix ?? "")
    } else {
      return super.format(unformatted)
    }

  }
  
  private func calculateMinimumFractionDigits(unformatted: String, divider: String, maximumFractionDigits: Int) -> Int {
    let currentFractionDigitsCount = getFractionDigitsCount(unformatted: unformatted, divider: divider)
    if currentFractionDigitsCount >= maximumFractionDigits { return maximumFractionDigits }
    return currentFractionDigitsCount
  }
  
  private func getFractionDigitsCount(unformatted: String, divider: String) -> Int {
    let parts = unformatted.components(separatedBy: divider)
    guard parts.count > 1 else { return 0 }
    return parts[1].count
  }
  
  private func calculateMinimumIntegerDigits(unformatted: String, decimalSeparator: String) -> Int {
    let isBeginFromDecimalSeparator = unformatted.hasPrefix(decimalSeparator)
    let hasIntegerPart = !isBeginFromDecimalSeparator
    if hasIntegerPart {
      return 1
    } else {
      return 0
    }
  }

  open func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
    let unformattedCurrentText = unformat(currentText) ?? ""
    let unformattedRange = convertToUnformattedRange(currentText: currentText, unformattedCurrentText: unformattedCurrentText, range: range)
    let newUnformattedText = unformattedCurrentText.replacingCharacters(in: unformattedRange, with: text)
    let newFormattedText = format(newUnformattedText) ?? ""
    
    let caretOffset = caretPositionCalculator.calculateCaretOffset(range: range, replacementText: text, unformattedRange: unformattedRange, currentFormattedText: currentText, newFormattedText: newFormattedText, currentUnformattedText: unformattedCurrentText, newUnformattedText: newUnformattedText)
    return FormattedTextValue(formattedText: newFormattedText, caretBeginOffset: caretOffset)
  }
  
  private func convertToUnformattedRange(currentText: String, unformattedCurrentText: String, range: NSRange) -> NSRange {
    let currentTextBeforeRangeLocation = currentText.leftSlice(limit: range.location)
    let unformattedTextBeforeRangeLocation = removeAllFormatSymbols(text: currentTextBeforeRangeLocation)
    
    
    let textLengthDifference = currentTextBeforeRangeLocation.count - unformattedTextBeforeRangeLocation.count
    var convertedRange = range
    
    convertedRange.location -= textLengthDifference
    if range.length > 0 {
      let rangeSlice = currentText.slice(from: range.location, length: range.length) ?? ""
      let uls = removeAllFormatSymbols(text: rangeSlice)
      convertedRange.length -= rangeSlice.count - uls.count
    }
    
    return convertedRange
  }
}
