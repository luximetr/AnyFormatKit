//
//  DefaultTextInputFormatter.swift
//
//  Created by Oleksandr Orlov on 12/14/18.
//  Copyright © 2018 Oleksandr Orlov. All rights reserved.
//

import Foundation

open class DefaultTextInputFormatter: DefaultTextFormatter, TextInputFormatter {
  
  private let caretPositionCorrector: CaretPositionCorrector
  
  // MARK: - Init
  /**
   Initializes formatter with patternString
   
   - Parameters:
     - textPattern: String with special characters, that will be used for formatting
     - patternSymbol: Optional parameter, that represent character, that will be replaced in formatted string
     - prefix: String, that always will be at beggining of text during editing
  */
  public override init(textPattern: String,
                       patternSymbol: Character = "#") {
    self.caretPositionCorrector = CaretPositionCorrector(textPattern: textPattern, patternSymbol: patternSymbol)
    super.init(textPattern: textPattern, patternSymbol: patternSymbol)
  }
  
  // MARK: - Format input
  
  open func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
    let unformattedRange = self.unformattedRange(from: range)
    let oldUnformattedText = (unformat(currentText) ?? "") as NSString
    
    let newText = oldUnformattedText.replacingCharacters(in: unformattedRange, with: text)
    let formattedText = self.format(newText) ?? ""
    
    let caretOffset = getCorrectedCaretPosition(range: range, replacementString: text)
    
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
  
  // MARK: - Caret position calculation
  
  private func getCorrectedCaretPosition(range: NSRange, replacementString: String) -> Int {
    let offset = caretPositionCorrector.calculateCaretPositionOffset(originalRange: range, replacementFiltered: replacementString)
    return offset
  }
  
}
