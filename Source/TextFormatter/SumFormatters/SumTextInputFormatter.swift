//
//  SumTextInputFormatter.swift
//  AnyFormatKit
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

open class SumTextInputFormatter: SumTextFormatter, TextInputFormatterProtocol {
  open var prefix: String?
  
  open var formattedPrefix: String?
  
  open var allowedSymbolsRegex: String?
  
  
  // MARK: - Init
  /**
   Initializes formatter with patternString
   
   - Parameters:
   - textPattern: String with special characters, that will be used for formatting
   - patternSymbol: Optional parameter, that represent character, that will be replaced in formatted string
   */
  public override init(textPattern: String, patternSymbol: Character = "#") {
    super.init(textPattern: textPattern, patternSymbol: patternSymbol)
    self.prefix = prefixStr
    self.formattedPrefix = prefixStr
  }
  
  // MARK: - Public
  /**
   Method, that called when textInput starts editing
   
   - Parameters:
   - textInput: Object, that conform to TextInput protocol and represent input field with correcting content
   
   */
  open func didBeginEditing(_ textInput: TextInput) {
    guard let suffix = suffixStr else { return }
    
    let offset = (textInput.content?.count ?? 0) - suffix.count
    
    let newCursorLocation = textInput.position(from: textInput.beginningOfDocument, offset: offset)
    
    if let cursor = newCursorLocation {
      textInput.selectedTextRange = textInput.textRange(from: cursor, to: cursor)
    }
  }
  
  
  /**
   Method, that allow correct character by character input with specified format
   
   - Parameters:
   - textInput: Object, that conform to TextInput protocol and represent input field with correcting content
   - range: Range, that determine which symbols must to be replaced
   - replacementString: String, that will replace old content in determined range
   
   - Returns: Always return false (correct of textInput's content in method's body)
   */
  open func shouldChangeTextIn(textInput: TextInput, range: NSRange, replacementString text: String) -> Bool {
    
    var internalRange = range
    var isDecimalSeparatorInsertion = false
    
    if text.isEmpty {
      let newRange = correctRangeForDeleting(from: textInput.content, at: internalRange)
      guard let newRangeUnwrapped = newRange else { return false }
      internalRange = newRangeUnwrapped
    } else if text == "," || text == "." {
      isDecimalSeparatorInsertion = true
      if !isCorrectSeparatorInserting() { return false }
    } else {
      if !isCorrectInserting(from: textInput.content, at: internalRange) { return false }
    }
    
    guard let oldString = textInput.content as NSString? else { return false }
    let newString = oldString.replacingCharacters(in: internalRange, with: isDecimalSeparatorInsertion ? decimalSeparator : text)
    
    if decimalSeparator != groupingSeparator {
      guard newString.components(separatedBy: decimalSeparator).count < 3 else { return false }
    }
    guard var newUnformatted = unformattedText(from: newString) else { return false }
    
    newUnformatted = stringOnlyWithAllowedSymbols(from: newUnformatted)
    let newFormatted = formattedText(from: newUnformatted)
    
    textInput.content = newFormatted
    
    guard let newFormattedUnwrapped = newFormatted else { return false }
    correctCarretPosition(textInput: textInput, range: internalRange, oldString: String(oldString), newString: newFormattedUnwrapped)
    
    return false
  }
  
  // MARK: - Private
  private func rangeOffset(range: NSRange, oldString: String, newString: String) -> Int {
    var offset = range.location + range.length + (newString.count - oldString.count)
    if oldString.isEmpty {
      offset -= suffixStr?.count ?? 0
    }
    if offset < prefix?.count ?? 0 {
      offset = prefix?.count ?? 0
    }
    return offset
  }
  
  private func correctCarretPosition(textInput: TextInput, range: NSRange, oldString: String, newString: String) {
    let beginning = textInput.beginningOfDocument
    let offset = rangeOffset(range: range, oldString: String(oldString), newString: newString)
    let cursorLocation = textInput.position(from: beginning, offset: offset)
    if let cursor = cursorLocation {
      textInput.selectedTextRange = textInput.textRange(from: cursor, to: cursor)
    }
  }
  
  private func stringOnlyWithAllowedSymbols(from string: String) -> String {
    var result = ""
    if let regex = allowedSymbolsRegex {
      let regexPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
      
      for character in string {
        if regexPredicate.evaluate(with: String(character)) {
          result.append(character)
        }
      }
    } else {
      return string
    }
    return result
  }
  
  private func correctRangeForDeleting(from string: String?, at range: NSRange) -> NSRange? {
    guard let unformatted = unformattedText(from: string), !unformatted.isEmpty else { return nil }
    guard let text = string else { return nil }
    
    if range.length == 1 {
      if range.location > text.count - (suffixStr?.count ?? 0) - 1 ||
        range.location < (prefix?.count ?? 0)
      { return nil }
    } else {
      
      var lowerBound = range.lowerBound
      var upperBound = range.upperBound
      
      if range.lowerBound < (prefix?.count ?? 0) {
        lowerBound = (prefix?.count ?? 0)
      }
      
      if range.upperBound > text.count - (suffixStr?.count ?? 0)  {
        upperBound = text.count - (suffixStr?.count ?? 0)
      }
      
      let newRange = NSRange(location: lowerBound, length: upperBound - lowerBound)
      return newRange
    }
    
    return range
  }
  
  private func isCorrectInserting(from string: String?, at range: NSRange) -> Bool {
    guard let text = string else { return false }
    guard let unformated = unformattedText(from: string) else { return false }
    
    if range.location > (text.count - (suffixStr?.count ?? 0)) ||
      range.location < (prefix?.count ?? 0)
    { return false }
    
    guard let integerPart = unformated.components(separatedBy: decimalSeparator).first,
      integerPart.count < maximumIntegerCharacters
      else { return false }
    
    return true
  }
  
  private func isCorrectSeparatorInserting() -> Bool {
    if decimalSeparator.isEmpty || decimalSeparator == groupingSeparator { return false } //Decimal not allowed
    return true
  }
}
