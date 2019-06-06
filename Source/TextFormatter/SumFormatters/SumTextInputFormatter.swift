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
    var internalRange = range
    var isDecimalSeparatorInsertion = false
    let emptyResult = (currentText, range.upperBound)
    
    if text.isEmpty {
      let newRange = correctRangeForDeleting(from: currentText, at: internalRange)
      guard let newRangeUnwrapped = newRange else { return emptyResult }
      internalRange = newRangeUnwrapped
    } else if text == "," || text == "." {
      isDecimalSeparatorInsertion = true
      if !isCorrectSeparatorInserting() { return emptyResult }
    } else {
      if !isCorrectInserting(from: currentText, at: internalRange) { return emptyResult }
    }
    let oldString = currentText as NSString
    let newString = oldString.replacingCharacters(in: internalRange, with: isDecimalSeparatorInsertion ? decimalSeparator : text)
    
    if decimalSeparator != groupingSeparator {
      guard newString.components(separatedBy: decimalSeparator).count < 3 else { return emptyResult }
    }
    guard let newUnformatted = unformat(newString) else { return emptyResult }
    
    let newFormatted = format(newUnformatted) ?? ""
    
    let caretOffset = rangeOffset(range: internalRange, oldString: String(oldString), newString: newFormatted)
    
    return (newFormatted, caretOffset)
  }

  // MARK: - Private
  private func rangeOffset(range: NSRange, oldString: String, newString: String) -> Int {
    var offset = range.location + range.length + (newString.count - oldString.count)
    if oldString.isEmpty {
      offset -= suffix?.count ?? 0
    }
    if offset < prefix?.count ?? 0 {
      offset = prefix?.count ?? 0
    }
    return offset
  }

  private func correctRangeForDeleting(from string: String?, at range: NSRange) -> NSRange? {
    guard let unformatted = unformat(string), !unformatted.isEmpty else { return nil }
    guard let text = string else { return nil }

    if range.length == 1 {
      if range.location > text.count - (suffix?.count ?? 0) - 1 ||
        range.location < (prefix?.count ?? 0)
      {
        return nil
      } else if let deleteRange = Range(range, in: text), text[deleteRange] == groupingSeparator {
        let newRange = NSRange(location: range.location - 1, length: range.length )
        return newRange
      }
    } else {

      var lowerBound = range.lowerBound
      var upperBound = range.upperBound

      if range.lowerBound < (prefix?.count ?? 0) {
        lowerBound = (prefix?.count ?? 0)
      }

      if range.upperBound > text.count - (suffix?.count ?? 0)  {
        upperBound = text.count - (suffix?.count ?? 0)
      }

      let newRange = NSRange(location: lowerBound, length: upperBound - lowerBound)
      return newRange
    }

    return range
  }

  private func isCorrectInserting(from string: String?, at range: NSRange) -> Bool {
    guard let text = string else { return false }
    guard let unformated = unformat(string) else { return false }

    if range.location > (text.count - (suffix?.count ?? 0)) ||
      range.location < (prefix?.count ?? 0)
    { return false }

    guard let integerPart = unformated.components(separatedBy: decimalSeparator).first,
      integerPart.count <= maximumIntegerCharacters
      else { return false }

    return true
  }

  private func isCorrectSeparatorInserting() -> Bool {
    if decimalSeparator.isEmpty || decimalSeparator == groupingSeparator { return false } //Decimal not allowed
    return true
  }
}
