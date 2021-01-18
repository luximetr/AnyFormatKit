//
//  PlaceholderTextFormatter.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

open class PlaceholderTextFormatter: TextFormatter, TextUnformatter {
  
  // MARK: - Properties
  
  /// String, that will use for formatting of string replacing patter symbol, example: patternSymbol - "#", format - "### (###) ###-##-##"
  public let textPattern: String
  
  /// Symbol that will be replace by input symbols
  public let patternSymbol: Character
  
  // MARK: - Life cycle
  
  /**
   Initializes formatter with pattern
   
   - Parameters:
   - textPatterm: String, that will use for formatting of string replacing patter symbol
   - patternSymbol: Character, that will be replaced by input characters in textPattern
   */
  public init(
    textPattern: String,
    patternSymbol: Character = "#"
  ) {
    self.textPattern = textPattern
    self.patternSymbol = patternSymbol
  }
  
  // MARK: - TextFormatter
  
  open func format(_ unformattedText: String?) -> String? {
    guard let unformattedText = unformattedText, !unformattedText.isEmpty else { return textPattern }
    var formatted = ""
    var unformattedIndex = 0
    var patternIndex = 0
    
    while patternIndex < textPattern.count && unformattedIndex < unformattedText.count {
      guard let patternCharacter = textPattern.characterAt(patternIndex) else { break }
      if patternCharacter == patternSymbol {
        if let unformattedCharacter = unformattedText.characterAt(unformattedIndex) {
          formatted.append(unformattedCharacter)
        }
        unformattedIndex += 1
      } else {
        formatted.append(patternCharacter)
      }
      patternIndex += 1
    }
    if formatted.count < textPattern.count {
      let start = textPattern.index(textPattern.startIndex, offsetBy: formatted.count)
      let end = textPattern.endIndex
      formatted = formatted + textPattern[start..<end]
    }
    return formatted
  }
  
  // MARK: - TextUnformatter
  
  open func unformat(_ formattedText: String?) -> String? {
    guard let formatted = formattedText else { return nil }
    var unformatted = String()
    var formattedIndex = 0
    
    while formattedIndex < formatted.count {
      if let formattedCharacter = formatted.characterAt(formattedIndex) {
        if formattedIndex >= textPattern.count {
          unformatted.append(formattedCharacter)
        } else if formattedCharacter != textPattern.characterAt(formattedIndex) {
          unformatted.append(formattedCharacter)
        }
        formattedIndex += 1
      }
    }
    return unformatted
  }
}
