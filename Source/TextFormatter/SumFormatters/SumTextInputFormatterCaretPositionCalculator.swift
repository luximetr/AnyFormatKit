//
//  SumTextInputFormatterCaretPositionCalculator.swift
//  AnyFormatKit
//
//  Created by branderstudio on 20.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import Foundation

class SumTextInputFormatterCaretPositionCalculator {
  
  let prefix: String?
  let suffix: String?
  let decimalSeparator: String
  let groupingSeparator: String
  
  init(decimalSeparator: String, suffix: String?, prefix: String?, groupingSeparator: String) {
    self.prefix = prefix
    self.suffix = suffix
    self.decimalSeparator = decimalSeparator
    self.groupingSeparator = groupingSeparator
  }
  
  func calculateCaretOffset(
    range: NSRange,
    replacementText: String,
    unformattedRange: NSRange,
    currentFormattedText: String,
    newFormattedText: String,
    currentUnformattedText: String,
    newUnformattedText: String) -> Int {
    let isInsert = range.length == 0 && !replacementText.isEmpty
    let isDelete = range.length != 0 && replacementText.isEmpty
    
    
    if isInsert {
      return calculateCaretPositionForInsert(range: range, replacementText: replacementText, unformattedRange: unformattedRange, currentFormattedText: currentFormattedText, newFormattedText: newFormattedText, currentUnformattedText: currentUnformattedText, newUnformattedText: newUnformattedText)
    } else if isDelete {
      return calculateCaretPositionForDelete(range: range, newFormattedText: newFormattedText, unformattedRange: unformattedRange)
    } else { // isReplace
      return calculateCaretPositionForReplace(range: range, currentFormattedText: currentFormattedText, newFormattedText: newFormattedText)
    }
  }
  
  // for insert
  private func calculateCaretPositionForInsert(
      range: NSRange,
      replacementText: String,
      unformattedRange: NSRange,
      currentFormattedText: String,
      newFormattedText: String,
      currentUnformattedText: String,
      newUnformattedText: String) -> Int {
    let differenceCount = newFormattedText.count - currentFormattedText.count
    if differenceCount == 0 {
      if currentFormattedText == newFormattedText {
        return range.location
      } else {
        if range.location + replacementText.count > (newFormattedText.count - (suffix ?? "").count) {
          return newFormattedText.count - (suffix ?? "").count
        } else {
          if currentUnformattedText.hasPrefix("0") {
            return range.location
          } else {
            return range.location + replacementText.count
          }
        }
      }
    } else {
      let prefixLength = prefix?.count ?? 0
      var result = 0
      if let suffix = suffix, !suffix.isEmpty, newFormattedText.hasSuffix(suffix), range.location == currentFormattedText.count {
        result = findIndexOfNumberSymbol(numberOfSymolsFromEnd: currentFormattedText.count - range.location, newFormattedText: newFormattedText) + 1 - suffix.count
      } else if currentFormattedText.isEmpty {
        return newFormattedText.count
      } else if range.location == currentFormattedText.count {
        result = findIndexOfNumberSymbol(numberOfSymolsFromEnd: currentFormattedText.count - range.location, newFormattedText: newFormattedText) + 1
      } else {
        result = findIndexOfNumberSymbol(numberOfSymolsFromEnd: currentFormattedText.count - range.location, newFormattedText: newFormattedText)
      }
      if range.location < prefixLength {
        result += prefixLength - range.location
      }
      return result
    }
  }
  
  private func findIndexOfNumberSymbol(numberOfSymolsFromEnd: Int, newFormattedText: String) -> Int {
    var numberSymbolsCount = 0
    for (index, _) in newFormattedText.enumerated().reversed() {
      numberSymbolsCount += 1
      if numberSymbolsCount >= numberOfSymolsFromEnd {
        return index
      }
    }
    return 0
  }
  
  // for delete
  private func calculateCaretPositionForDelete(range: NSRange, newFormattedText: String, unformattedRange: NSRange) -> Int {
    if let prefix = prefix, !prefix.isEmpty, newFormattedText.hasPrefix(prefix), range.location <= prefix.count {
      return range.location
    } else if unformattedRange.location == 0 {
      return findIndexOfNumberSymbol(numberOfSymbolsBefore: unformattedRange.location, newFormattedText: newFormattedText)
    } else {
      return findIndexOfNumberSymbol(numberOfSymbolsBefore: unformattedRange.location, newFormattedText: newFormattedText) + 1
    }
  }
  
  private func findIndexOfNumberSymbol(numberOfSymbolsBefore: Int, newFormattedText: String) -> Int {
    var numberSymbolsCount = 0
    for (index, character) in newFormattedText.enumerated() {
      let suffix = self.suffix ?? ""
      let isGroupingSeparator = self.isGroupingSeparator(character, in: newFormattedText, at: index)
      let isSuffix = (!suffix.isEmpty && suffix.contains(character) && !isGroupingSeparator)

      if isDigit(character: character) || character == decimalSeparator.first || isSuffix {
        numberSymbolsCount += 1
      }

      if numberSymbolsCount >= numberOfSymbolsBefore {
        return index
      }
    }

    return 0
  }

  private func isGroupingSeparator(_ separator: String.Element, in newFormattedText: String, at index: Int) -> Bool {
    guard self.groupingSeparator.first == separator else {
      return false
    }

    guard index > 0 && index < newFormattedText.count - 1 else {
      return false
    }

    guard let previousSymbol = newFormattedText.characterAt(index - 1) else {
      return false
    }

    guard let nextSymbol = newFormattedText.characterAt(index + 1) else {
      return false
    }

    return (self.isDigit(character: previousSymbol) && self.isDigit(character: nextSymbol))
  }
  
  // for replace
  private func calculateCaretPositionForReplace(range: NSRange, currentFormattedText: String, newFormattedText: String) -> Int {
    var result = 0
    let rangeLocation = range.location + range.length
    if rangeLocation == currentFormattedText.count {
      result = findReplaceIndexOfNumberSymbol(numberOfSymolsFromEnd: currentFormattedText.count - rangeLocation, newFormattedText: newFormattedText) + 1
    } else {
      result = findReplaceIndexOfNumberSymbol(numberOfSymolsFromEnd: currentFormattedText.count - rangeLocation, newFormattedText: newFormattedText)
    }
    return result
  }
  
  private func findReplaceIndexOfNumberSymbol(numberOfSymolsFromEnd: Int, newFormattedText: String) -> Int {
    var numberSymbolsCount = 0
    for (index, _) in newFormattedText.enumerated().reversed() {
      numberSymbolsCount += 1
      if numberSymbolsCount >= numberOfSymolsFromEnd {
        return index
      }
    }
    return 0
  }
  
  private func isDigit(character: Character) -> Bool {
    guard let scalar = String(character).unicodeScalars.first else { return false }
    return CharacterSet.decimalDigits.contains(scalar)
  }
}
