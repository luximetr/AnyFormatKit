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
    let oldUnformattedText = (textFormatter.unformat(currentText) ?? "") as NSString
    let unformattedRange = self.unformattedRange(currentText: currentText, from: range)
    let newText = oldUnformattedText.replacingCharacters(in: unformattedRange, with: text)
    let formattedText = textFormatter.format(newText) ?? ""
    let caretOffset = getCorrectedCaretPosition(range: range, replacementString: text)
    return FormattedTextValue(formattedText: formattedText, caretBeginOffset: caretOffset)
  }
  
  private func unformattedRange(currentText: String, from range: NSRange) -> NSRange {
    var location = 0
    var length = 0
    let currentTextInRange = (currentText as NSString).substring(with: range)
    if let currentTextChar = currentTextInRange.characterAt(0),
       currentTextChar == patternSymbol {
      let currentUnformattedText = textFormatter.unformat(currentText) ?? ""
      location = currentUnformattedText.count
    } else {
      location = range.location - getNumberOfFormatChars(text: currentText, before: range.location)
    }
    length = range.length - getNumberOfFormChars(in: currentText, textPattern: textPattern, range: range)
    return NSRange(location: location, length: length)
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
  
}
