//
//  DefaultTextInputFormatter.swift
//
//  Created by Oleksandr Orlov on 12/14/18.
//  Copyright © 2018 Oleksandr Orlov. All rights reserved.
//

import Foundation

open class DefaultTextInputFormatter: TextInputFormatter {
  
  // MARK: - Dependencies
  
  private let caretPositionCorrector: CaretPositionCorrector
  private let textFormatter: DefaultTextFormatter
  
  // MARK: - Properties
  
  private var textPattern: String { textFormatter.textPattern }
  private var patternSymbol: Character { textFormatter.patternSymbol }
  
  // MARK: - Life cycle
  /**
   Initializes formatter with patternString
   
   - Parameters:
   - textPattern: String with special characters, that will be used for formatting
   - patternSymbol: Optional parameter, that represent character, that will be replaced in formatted string
   - prefix: String, that always will be at beggining of text during editing
   */
  public init(
    textPattern: String,
    patternSymbol: Character = "#"
  ) {
    self.caretPositionCorrector = CaretPositionCorrector(
      textPattern: textPattern,
      patternSymbol: patternSymbol
    )
    self.textFormatter = DefaultTextFormatter(
      textPattern: textPattern,
      patternSymbol: patternSymbol
    )
  }
  
  // MARK: - Format input
  
  open func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
    guard let swiftRange = Range(range, in: currentText) else { return .zero }
    
    let unformattedRange = self.unformattedRange(from: range)
    let unformattedRange1 = self.unformattedRange1(currentText: currentText, from: swiftRange)
    
    let oldUnformattedText = (textFormatter.unformat(currentText) ?? "") as NSString
    
    let newText = oldUnformattedText.replacingCharacters(in: unformattedRange, with: text)
    let formattedText = textFormatter.format(newText) ?? ""
    
    let caretOffset = getCorrectedCaretPosition(
      range: swiftRange,
      replacementString: text
    )
    
    return FormattedTextValue(formattedText: formattedText, caretBeginOffset: caretOffset)
  }
  
  // MARK: - Private
  
  /**
   Convert range in formatted string to range in unformatted string
   
   - Parameters:
   - range: Range in formatted (with current textPattern) string
   
   - Returns: Range in unformatted (with current textPattern) string
   */
  func unformattedRange(from range: NSRange) -> NSRange {
    let newRange = NSRange(
      location: range.location - textPattern[..<textPattern.index(textPattern.startIndex, offsetBy: range.location)]
        .replacingOccurrences(of: String(patternSymbol), with: "").count,
      length: range.length - (textPattern as NSString).substring(with: range)
        .replacingOccurrences(of: String(patternSymbol), with: "").count)
    return newRange
  }
  
  func unformattedRange1(currentText: String, from range: Range<String.Index>) -> Range<String.Index> {
    let number1 = getNumberOfFormatChars(text: currentText, before: range.lowerBound)
    
    let number2 = getNumberOfFormatChars(text: currentText, in: range)
    
    return range
  }
  
  private func getNumberOfFormatChars(text: String, before: String.Index) -> Int {
    let textLeftSlice = text.leftSlice(end: before)
    let patternLeftSlice = textPattern.leftSlice(limit: textLeftSlice.count)
    var result = 0
    for (textSliceChar, patternSliceChar) in zip(textLeftSlice, patternLeftSlice) {
      if textSliceChar == patternSliceChar { result += 1 }
    }
    return result
  }
  
  private func getNumberOfFormatChars(text: String, in range: Range<String.Index>) -> Int {
    let textSlice = text.slice(in: range)
    let patternSlice = textPattern.slice(in: range)
    
    return 0
  }
  
  // MARK: - Caret position calculation
  
//  private func getCorrectedCaretPosition(range: NSRange, replacementString: String) -> Int {
//    return caretPositionCorrector.calculateCaretPositionOffset(
//      originalRange: range,
//      replacementFiltered: replacementString
//    )
//  }
  
  private func getCorrectedCaretPosition(range: Range<String.Index>, replacementString: String) -> Int {
    return caretPositionCorrector.calculateCaretPositionOffset(
      originalRange: range,
      replacementText: replacementString
    )
  }
  
}
