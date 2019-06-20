//
//  DefaultTextInputFormatter.swift
//
//  Created by branderstudio on 12/14/18.
//  Copyright © 2018 branderstudio. All rights reserved.
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
  
  // MARK: - open
  
  open func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
    let unformattedRange = self.unformattedRange(from: range)
    let oldUnformattedText = (unformat(currentText) ?? "") as NSString
    
    let newText = oldUnformattedText.replacingCharacters(in: unformattedRange, with: text)
    let formattedText = self.format(newText) ?? ""
    
    let caretOffset = getCorrectedCaretPosition(range: range, replacementString: text)
    
    return FormattedTextValue(formattedText: formattedText, caretBeginOffset: caretOffset)
  }
  
}

// MARK: - Private
private extension DefaultTextInputFormatter {
  /**
   Correcting content with current content, range and replacement string
   
   - Parameters:
     - currentContent: String, that will replace with characters in range
     - range: Range of characters, that will replace
     - replacementFiltered: String, filtered with RegEx, that will replace characters in range
   
   - Returns: New String with replaced characters in range from old string
  */
  func correctedContent(currentContent: String?, range: NSRange, replacementFiltered: String) -> String? {
    let oldText = currentContent ?? String()
    
    let correctedRange = unformattedRange(from: range)
    let oldUnformatted = unformat(oldText) as NSString?
    
    let newText = oldUnformatted?.replacingCharacters(in: correctedRange, with: replacementFiltered)
    return format(newText)
  }
  
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
