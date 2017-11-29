//
//  SumTextFormatter.swift
//  AnyFormatKit
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

open class SumTextFormatter: TextFormatterProtocol {
  private static let maxIntSize = String(Int.max).count - 1
  
  open var maximumDecimalCharacters: Int = 2
  open var maximumIntegerCharacters: Int = 14 {
    didSet {
      if maximumIntegerCharacters > SumTextFormatter.maxIntSize { maximumIntegerCharacters = SumTextFormatter.maxIntSize }
    }
  }
  
  var prefixStr: String?
  var suffixStr: String?
  var decimalSeparator: String = "."
  var groupingSeparator: String = ","
  var numberOfCharactersInGroup = 3
  
  /*
   A mask, used for formatting input data. Can has a prefix (optional),
   an integer part with separator,
   a decimal part with separator(optional)
   and a suffix(optional)
   Examples (special symbol == "#"):
   "Suf #,###.# $" -> "Suf 1,234,567.12 $"
   "# ##$" -> "12 34 56$"
   "# ###.#" -> "123 456.78"
   */
  var textPattern: String
  
  // Symbol that will be replace by input symbols
  var patternSymbol: Character
  
  private let possibleDividers = CharacterSet(charactersIn: ".,")
  
  public init(textPattern: String, patternSymbol: Character = "#") {
    self.textPattern = textPattern
    self.patternSymbol = patternSymbol
    extractDataFromPattern()
  }
  
  private func extractDataFromPattern() {
    self.suffixStr = getSuffix(from: textPattern, specialSymbol: patternSymbol)
    self.prefixStr = getPrefix(from: textPattern, specialSymbol: patternSymbol)
    self.decimalSeparator = getDecimalSeparator(from: textPattern, specialSymbol: patternSymbol)
    self.groupingSeparator = getGroupingSeparator(from: textPattern, specialSymbol: patternSymbol)
    self.numberOfCharactersInGroup = getNumberOfCharactersInGroup(from: textPattern, specialSymbol: patternSymbol)
  }
  
  private func getPrefix(from pattern: String, specialSymbol: Character) -> String {
    var result = ""
    for i in pattern.enumerated() {
      if i.element == specialSymbol {
        let index = pattern.index(pattern.startIndex, offsetBy: i.offset)
        result = String(pattern[pattern.startIndex..<index])
        break
      }
    }
    return result
  }
  
  private func getSuffix(from pattern: String, specialSymbol: Character) -> String {
    var result = ""
    var i = pattern.count
    while (i > 0) {
      i -= 1
      if let currentChar = pattern.characterAt(i), currentChar == specialSymbol {
        let index = pattern.index(pattern.endIndex, offsetBy: -(pattern.count - i - 1))
        result = String(pattern[index..<pattern.endIndex])
        break
      }
    }
    return result
  }
  
  private func getDecimalSeparator(from pattern: String, specialSymbol: Character) -> String {
    var result = ""
    var i = pattern.count - (suffixStr?.count ?? 0)
    while (i > 0) {
      i -= 1
      if let currentChar = pattern.characterAt(i), currentChar != specialSymbol {
        var tmpResult = ""
        var j = i
        
        while (pattern.characterAt(j) != specialSymbol) {
          guard let char = pattern.characterAt(j) else { break }
          tmpResult.append(char)
          j -= 1
        }
        
        result = String(tmpResult.reversed())
        break
      }
    }
    return result
  }
  
  private func getGroupingSeparator(from pattern: String, specialSymbol: Character) -> String {
    var result = ""
    var i = prefixStr?.count ?? 0
    while (i < pattern.count) {
      if let currentChar = pattern.characterAt(i), currentChar != specialSymbol {
        var j = i
        while (pattern.characterAt(j) != specialSymbol) {
          guard let char = pattern.characterAt(j) else { break }
          result.append(char)
          j += 1
        }
        break
      }
      i+=1
    }
    return result
  }
  
  private func getNumberOfCharactersInGroup(from pattern: String, specialSymbol: Character) -> Int {
    var result = 0
    var i = prefixStr?.count ?? 0
    while (i < pattern.count) {
      if let currentChar = pattern.characterAt(i), currentChar.description == groupingSeparator {
        var j = i + 1
        while (pattern.characterAt(j) == specialSymbol && j < pattern.count) {
          result += 1
          j += 1
        }
        break
      }
      i+=1
    }
    return result
  }
  
  func isRequireSubstitute(symbol: Character) -> Bool {
    return symbol == patternSymbol
  }
  
  private func stringForDecimal(decimal: Int) -> String {
    var result = ""
    let reversString = String(String(decimal).reversed())
    let isNegative = decimal < 0
    var reversLenght = reversString.count
    if isNegative {
      // for minus symbol
      reversLenght -= 1
    }
    for i in 0..<reversLenght {
      guard let currentChar = reversString.characterAt(i) else { continue }
      result.append(currentChar)
      if i % numberOfCharactersInGroup == (numberOfCharactersInGroup - 1), i != reversLenght - 1 {
        result.append(groupingSeparator)
      }
    }
    if isNegative {
      result.append("-")
    }
    return String(result.reversed())
  }
  
  
  open func formattedText(from unformatted: String?) -> String? {
    
    guard var unformattedString = unformatted else { return nil }
    guard !(unformattedString.isEmpty) else { return "\(prefixStr ?? "")\(suffixStr ?? "")" }
    
    unformattedString = correctedIntegers(from: unformattedString)
    
    var resultString = ""
    var hasIncompletedDecimal = false
    var isSpecialFormat = false // Decimal separator other than '.'
    
    resultString.append(prefixStr ?? "")
    
    var doubleStringValue = unformattedString.components(separatedBy: possibleDividers).joined(separator: decimalSeparator)
    if doubleStringValue.characterAt(0) == Character(decimalSeparator) {
      doubleStringValue.insert("0", at: doubleStringValue.startIndex)
    }
    
    if doubleStringValue.characterAt(doubleStringValue.count - 1) == Character(decimalSeparator) {
      doubleStringValue.append("0")
      hasIncompletedDecimal = true
    }
    
    if !(decimalSeparator.isEmpty), decimalSeparator != "." {
      isSpecialFormat = true
      doubleStringValue = specialFormatted(string: doubleStringValue, shouldFormat: true)
    }
    
    guard let doubleValue = Double(doubleStringValue) else { return unformattedString }
    
    if isSpecialFormat { doubleStringValue = specialFormatted(string: doubleStringValue, shouldFormat: false) }
    
    let decimalValue = Int(doubleValue)
    resultString.append(stringForDecimal(decimal: decimalValue))
    
    if doubleStringValue.contains(decimalSeparator) {
      resultString.append(decimalSeparator)
      if doubleStringValue.characterAt(doubleStringValue.count - 1) != Character(decimalSeparator) {
        let floatString = doubleStringValue.components(separatedBy: decimalSeparator)[1]
        resultString.append(correctedDecimalPart(from: floatString))
        
      }
    }
    
    if hasIncompletedDecimal { resultString.removeLast() }
    resultString.append(suffixStr ?? "")
    return resultString
  }
  
  open func unformattedText(from formatted: String?) -> String? {
    guard let formattedString = formatted else { return nil }
    
    let unformattedString = formattedString
      .replacingOccurrences(of: suffixStr ?? "", with: "")
      .replacingOccurrences(of: prefixStr ?? "", with: "")
      .replacingOccurrences(of: " ", with: "")
      .replacingOccurrences(of: groupingSeparator, with: "")
    
    return unformattedString
  }
  
  private func correctedDecimalPart(from string: String) -> String {
    if string.count <= maximumDecimalCharacters { return string }
    var tmpString = string
    let numberOfExcessSymbols = tmpString.count - maximumDecimalCharacters
    tmpString.removeLast(numberOfExcessSymbols)
    return tmpString
  }
  
  private func specialFormatted(string: String, shouldFormat: Bool) -> String {
    if shouldFormat {
      return string.replacingOccurrences(of: decimalSeparator, with: ".")
    } else {
      return string.replacingOccurrences(of: ".", with: decimalSeparator)
    }
  }
    
    private func correctedIntegers(from string: String) -> String {
        var decimalPart = ""
        var integerPart = ""
        
        if string.contains(decimalSeparator) {
            guard let position = string.index(of: decimalSeparator.first ?? ".") else { return string }
            decimalPart = String(string[position..<string.endIndex])
            integerPart = String(string[string.startIndex..<position])
        } else {
            integerPart = string
        }
        
        if integerPart.count > maximumIntegerCharacters {
            let diff = integerPart.count - maximumIntegerCharacters
            integerPart.removeLast(diff)
        }
        
        let result = integerPart + decimalPart
        return result
    }
}
