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
  public override init(textPattern: String, patternSymbol: Character = "#") {
    super.init(textPattern: textPattern, patternSymbol: patternSymbol)
  }

  open func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
    let unformattedCurrentText = unformat(currentText) ?? ""
    let unformattedRange = convertToUnformattedRange(currentText: currentText, unformattedCurrentText: unformattedCurrentText, range: range)
    let newUnformattedText = unformattedCurrentText.replacingCharacters(in: unformattedRange, with: text)
    let newFormattedText = format(newUnformattedText) ?? ""
    
    var lowerBound = unformattedCurrentText.distance(from: unformattedCurrentText.startIndex, to: unformattedRange.lowerBound)
    lowerBound += text.count
    lowerBound += newFormattedText.leftSlice(limit: lowerBound).components(separatedBy: groupingSeparator).count - 1
    
    let caretOffset = calculateCaretOffset(replacementString: text, range: range)
    return FormattedTextValue(formattedText: newFormattedText, caretBeginOffset: lowerBound)
  }
  
  private func convertToUnformattedRange(currentText: String, unformattedCurrentText: String, range: NSRange) -> Range<String.Index> {
    let currentTextBeforeRangeLocation = currentText.leftSlice(limit: range.location)
    let unformattedTextBeforeRangeLocation = removeAllFormatSymbols(text: currentTextBeforeRangeLocation)
    
    
    let textLengthDifference = currentTextBeforeRangeLocation.count - unformattedTextBeforeRangeLocation.count
    var convertedRange = range
    
    convertedRange.location -= textLengthDifference
    guard let convertedResultRange = Range(convertedRange, in: currentText) else {
      return currentText.startIndex..<currentText.startIndex
    }
    
    return convertedResultRange
  }
  
  // MARK: - Caret offset calculation
  
  private func calculateCaretOffset(replacementString: String, range: NSRange) -> Int {
    return replacementString.count + range.location
  }
}
