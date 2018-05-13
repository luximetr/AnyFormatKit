//
//  TextInputFormatter.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 18.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

/// Class, that represent formatter for TextInput in real-time (using shouldChangeTextIn method)
open class TextInputFormatter: TextFormatter, TextInputFormatterProtocol {
  // MARK: - Fields
  
  /// String, that always will be at beggining of text
  private(set) open var prefix: String?
  
  /// String, that represent current prefix with current format
  open var formattedPrefix: String? {
    return formattedText(from: prefix)
  }
  
  // Regular expression, that discript allowed characters for input
  open var allowedSymbolsRegex: String? = nil
  
  private let caretPositionCorrector: CaretPositionCorrector
  
  // MARK: - Init
  /**
   Initializes formatter with patternString
   
   - Parameters:
     - textPattern: String with special characters, that will be used for formatting
     - patternSymbol: Optional parameter, that represent character, that will be replaced in formatted string
     - prefix: String, that always will be at beggining of text during editing
  */
  public init(textPattern: String,
       patternSymbol: Character = TextFormatterConstants.defaultPatternSymbol,
       prefix: String? = nil) {
    self.prefix = prefix
    caretPositionCorrector = CaretPositionCorrector(textPattern: textPattern,
                                                    patternSymbol: patternSymbol)
    super.init(textPattern: textPattern, patternSymbol: patternSymbol)
  }
  
  // MARK: - open
  /**
   Method, that allow correct character by character input with specified format
   
   - Parameters:
     - textInput: Object, that conform to TextInput protocol and represent input field with correcting content
     - range: Range, that determine which symbols must to be replaced
     - replacementString: String, that will replace old content in determined range
   
     - Returns: Always return false (correct of textInput's content in method's body)
  */
  open func shouldChangeTextIn(
    textInput: TextInput, range: NSRange, replacementString text: String) -> Bool {
    if let formattedPrefix = formattedText(from: prefix),
      !formattedPrefix.isEmpty,
      range.location < formattedPrefix.count {
      return false
    }
    let replacementFiltered = text.filter(regex: allowedSymbolsRegex)
    let newContent = correctedContent(
      currentContent: textInput.text, range: range, replacementFiltered: replacementFiltered)
    
    textInput.text = newContent
    correctCaretPosition(in: textInput, originalRange: range, replacementFiltered: replacementFiltered)
    
    return false
  }
}

// MARK: - Private
private extension TextInputFormatter {
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
    let oldUnformatted = unformattedText(from: oldText) as NSString?
    
    let newText = oldUnformatted?.replacingCharacters(in: correctedRange, with: replacementFiltered)
    return formattedText(from: newText)
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
  
  /**
   Find and correct of new caret position

   - Parameters:
     - textInput: Text input, that caret position need to correct
     - originalRange: Range of characters in textInput, that will replaced
     - replacementFiltered: Filtered string, that will replace characters in range
  */
  func correctCaretPosition(
    in textInput: TextInput, originalRange range: NSRange, replacementFiltered: String) {
    let offset = caretPositionCorrector.calculateCaretPositionOffset(
      originalRange: range, replacementFiltered: replacementFiltered)
    if let cursorLocation = textInput.position(from: textInput.beginningOfDocument,
                                               offset: offset) {
      DispatchQueue.main.async {
        textInput.selectedTextRange = textInput.textRange(from: cursorLocation, to: cursorLocation)
      }
    }
  }
}
