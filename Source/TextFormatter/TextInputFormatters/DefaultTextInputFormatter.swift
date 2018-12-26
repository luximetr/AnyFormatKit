//
//  DefaultTextInputFormatter.swift
//  AnyFormatKit2
//
//  Created by branderstudio on 12/14/18.
//  Copyright © 2018 branderstudio. All rights reserved.
//

import Foundation


public class DefaultTextInputFormatter: DefaultTextFormatter, TextInputFormatter {
  
  // MARK: - Private variables
  
  private let caretPositionCorrector: CaretPositionCorrector
  
  // MARK: - Life cycle
  
  public override init(textPattern: String,
                       patternSymbol: Character = Constants.defaultPatternSymbol) {
    caretPositionCorrector = CaretPositionCorrector(textPattern: textPattern, patternSymbol: patternSymbol)
    super.init(textPattern: textPattern, patternSymbol: patternSymbol)
  }
  
  // MARK: - Formatting
  
  public func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
    
    let unformattedRange = unformatRange(from: range)
    let oldUnformattedText = unformat(from: currentText) as NSString
    
    let newText = oldUnformattedText.replacingCharacters(in: unformattedRange, with: text)
    let formattedText = format(text: newText)
    
    let corretOffset = getCorrectedCaretPosition(range: range, replacementString: text)
    
    return (formattedText: formattedText, caretBeginOffset: corretOffset)
  }
  
  // MARK: - Range operations
  
  private func unformatRange(from range: NSRange) -> NSRange {
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
