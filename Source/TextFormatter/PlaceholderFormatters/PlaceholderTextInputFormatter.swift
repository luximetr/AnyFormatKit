//
//  PlaceholderTextInputFormatter.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

open class PlaceholderTextInputFormatter: TextInputFormatter {
  
  // MARK: - Dependencies
  
  private let caretPositionCorrector: CaretPositionCorrector
  private let textFormatter: PlaceholderTextFormatter
  
  // MARK: - Properties
  
  var textPattern: String { textFormatter.textPattern }
  var patternSymbol: Character { textFormatter.patternSymbol }
  
  // MARK: - Life cycle
  
  init(
    textPattern: String,
    patternSymbol: Character = "#"
  ) {
    self.caretPositionCorrector = CaretPositionCorrector(
      textPattern: textPattern,
      patternSymbol: patternSymbol
    )
    self.textFormatter = PlaceholderTextFormatter(
      textPattern: textPattern,
      patternSymbol: patternSymbol
    )
  }
  
  // MARK: - Format input
  
  public func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
    let unformattedRange = self.unformattedRange(currentText: currentText, from: range)
    let oldUnformattedText = (textFormatter.unformat(currentText) ?? "") as NSString
    let newText = oldUnformattedText.replacingCharacters(in: unformattedRange, with: text)
    let formattedText = textFormatter.format(newText) ?? ""
    let caretOffset = getCorrectedCaretPosition(range: range, replacementString: text)
    return FormattedTextValue(formattedText: formattedText, caretBeginOffset: caretOffset)
  }
  
  private func unformattedRange(currentText: String, from range: NSRange) -> NSRange {
    guard currentText != textPattern else { return NSRange(location: 0, length: 0) }
    let newRange = NSRange(
      location: range.location - textPattern[..<textPattern.index(textPattern.startIndex, offsetBy: range.location)]
        .replacingOccurrences(of: String(patternSymbol), with: "").count,
      length: range.length - (textPattern as NSString).substring(with: range)
        .replacingOccurrences(of: String(patternSymbol), with: "").count
    )
    return newRange
  }
  
  // MARK: - Caret position calculation
  
  private func getCorrectedCaretPosition(range: NSRange, replacementString: String) -> Int {
    let offset = caretPositionCorrector.calculateCaretPositionOffset(originalRange: range, replacementFiltered: replacementString)
    return offset
  }
  
}
