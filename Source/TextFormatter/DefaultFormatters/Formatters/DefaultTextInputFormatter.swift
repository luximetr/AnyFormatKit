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
    
    let oldUnformattedText = textFormatter.unformat(currentText) ?? ""
    
    let unformattedCurrentTextRange = self.unformattedRange(currentText: currentText, from: swiftRange)
    let unformattedRange = oldUnformattedText.getSameRange(asIn: currentText, sourceRange: unformattedCurrentTextRange)
    
    let newText = oldUnformattedText.replacingCharacters(in: unformattedRange, with: text)
    
    let formattedText = textFormatter.format(newText) ?? ""
    let formattedTextRange = formattedText.getSameRange(asIn: currentText, sourceRange: swiftRange)
    
    let caretOffset = getCorrectedCaretPosition(
        newText: formattedText,
        range: formattedTextRange,
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
  private func unformattedRange(currentText: String, from range: Range<String.Index>) -> Range<String.Index> {
    let numberOfFormatCharsBeforeRange = getNumberOfFormatChars(text: currentText, before: range.lowerBound)
    let numberOfFormatCharsInRange = getNumberOfFormatChars(text: currentText, in: range)
    
    return currentText.getRangeWithOffsets(
        sourceRange: range,
        lowerBoundOffset: -numberOfFormatCharsBeforeRange,
        upperBoundOffset: -numberOfFormatCharsInRange
    )
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
    let textPatternRange = textPattern.getSameRange(asIn: text, sourceRange: range)
    let patternSlice = textPattern.slice(in: textPatternRange)
    
    var result = 0
    for (textSliceCharIndex, textSliceChar) in textSlice.enumerated() {
        let isSameCharacter = patternSlice.isSameCharacter(at: textSliceCharIndex, character: textSliceChar)
        if isSameCharacter {
            result += 1
        }
    }
    return result
  }
  
  // MARK: - Caret position calculation
  
    private func getCorrectedCaretPosition(newText: String, range: Range<String.Index>, replacementString: String) -> Int {
        return caretPositionCorrector.calculateCaretPositionOffset(
            newText: newText,
            originalRange: range,
            replacementText: replacementString
        )
    }
  
}
