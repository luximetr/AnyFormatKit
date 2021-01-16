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
  
  public init(
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
    guard let swiftRange = Range(range, in: currentText) else { return .zero }
    let oldUnformattedText = textFormatter.unformat(currentText) ?? ""
    
    let unformattedCurrentTextRange = self.unformattedRange1(currentText: currentText, from: swiftRange)
    let unformattedRange = oldUnformattedText.getSameRange(asIn: currentText, sourceRange: unformattedCurrentTextRange)
    
    let newText = oldUnformattedText.replacingCharacters(in: unformattedRange, with: text)
    
    let formattedText = textFormatter.format(newText) ?? ""
    let formattedTextRange = formattedText.getSameRange(asIn: currentText, sourceRange: swiftRange)
    
    let caretOffset = getCorrectedCaretPosition(newText: formattedText, range: formattedTextRange, replacementString: text)
    
    return FormattedTextValue(formattedText: formattedText, caretBeginOffset: caretOffset)
  }
    
    private func unformattedRange1(currentText: String, from range: Range<String.Index>) -> Range<String.Index> {
        let numberOfFormatCharsBeforeRange = getNumberOfFormatChars(text: currentText, before: range.lowerBound)
        let numberOfFormatCharsInRange = getNumberOfFormatChars(text: currentText, in: range)
        
        return currentText.getRangeWithOffsets(
            sourceRange: range,
            lowerBoundOffset: -numberOfFormatCharsBeforeRange,
            upperBoundOffset: -numberOfFormatCharsInRange
        )
    }
  
  private func getNumberOfFormatChars(text: String, before: Int) -> Int {
    let textLeftSlice = text.leftSlice(limit: before)
    var result = 0
    for charIndex in 0..<textLeftSlice.count {
      if getIsFormatCharacter(text: textLeftSlice, textPattern: textPattern, index: charIndex) {
        result += 1
      }
    }
    return result
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
  
  private func getNumberOfFormChars(in text: String, textPattern: String, range: NSRange) -> Int {
    let textInRange = (text as NSString).substring(with: range)
    let textPatternInRange = (textPattern as NSString).substring(with: range)
    var result = 0
    for index in 0..<textInRange.count {
      guard let textChar = textInRange.characterAt(index) else { continue }
      guard let textPatternChar = textPatternInRange.characterAt(index) else { continue }
      if textChar == textPatternChar {
        result += 1
      }
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
  
  private func getIsFormatCharacter(text: String, textPattern: String, index: Int) -> Bool {
    guard let textChar = text.characterAt(index),
          let textPatternChar = textPattern.characterAt(index) else {
      return false
    }
    return textChar == textPatternChar
  }
  
  // MARK: - Caret position calculation
  
  private func getCorrectedCaretPosition(range: NSRange, replacementString: String) -> Int {
    let offset = caretPositionCorrector.calculateCaretPositionOffset(originalRange: range, replacementFiltered: replacementString)
    return offset
  }
    
    private func getCorrectedCaretPosition(newText: String, range: Range<String.Index>, replacementString: String) -> Int {
        return caretPositionCorrector.calculateCaretPositionOffset(
            newText: newText,
            originalRange: range,
            replacementText: replacementString
        )
    }
  
}
