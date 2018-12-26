//
//  DefaultTextFormatter.swift
//  AnyFormatKit2
//
//  Created by branderstudio on 11/14/18.
//  Copyright © 2018 branderstudio. All rights reserved.
//

import Foundation

public class DefaultTextFormatter: TextFormatter {
  
  // MARK: - Fields
  
  /// String, that will use for formatting of string replacing patter symbol, example: patternSymbol - "#", format - "### (###) ###-##-##"
  public let textPattern: String
  
  /// Symbol that will be replace by input symbols
  public let patternSymbol: Character
  
  // MARK: - Init
  /**
   Initializes formatter with pattern
   
   - Parameters:
   - textPatterm: String, that will use for formatting of string replacing patter symbol
   - patternSymbol: Character, that will be replaced by input characters in textPattern
   */
  public init(textPattern: String,
              patternSymbol: Character = Constants.defaultPatternSymbol) {
    self.textPattern = textPattern
    self.patternSymbol = patternSymbol
  }
  
  public func format(text unformatted: String) -> String {
    var formatted = ""
    var unformattedIndex = 0
    var patternIndex = 0
    
    while patternIndex < textPattern.count && unformattedIndex < unformatted.count {
      guard let patternCharacter = textPattern.characterAt(patternIndex) else { break }
      if patternCharacter == patternSymbol {
        if let unformattedCharacter = unformatted.characterAt(unformattedIndex) {
          formatted.append(unformattedCharacter)
        }
        unformattedIndex += 1
      } else {
        formatted.append(patternCharacter)
      }
      patternIndex += 1
    }
    return formatted
  }
  
  public func unformat(from formatted: String) -> String {
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
  
  public struct Constants {
    public static let defaultPatternSymbol: Character = "#"
  }
}
