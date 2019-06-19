//
//  SumTextInputFormatter.swift
//  AnyFormatKit
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

open class SumTextInputFormatter: SumTextFormatter, TextInputFormatter {
  
  // MARK: - Init
  /**
   Initializes formatter with patternString

   - Parameters:
   - textPattern: String with special characters, that will be used for formatting
   - patternSymbol: Optional parameter, that represent character, that will be replaced in formatted string
   */
  public override init(textPattern: String, patternSymbol: Character = "#") {
    super.init(textPattern: textPattern, patternSymbol: patternSymbol)
  }
  
  override open func format(_ unformatted: String?) -> String? {
    guard let unformatted = unformatted else { return nil }
    let minimumFractionDigits = calculateMinimumFractionDigits(unformatted: unformatted, divider: decimalSeparator, maximumFractionDigits: numberFormatter.maximumFractionDigits)
    numberFormatter.minimumFractionDigits = minimumFractionDigits
    
    let needAlwaysShowDecimalSeparator = minimumFractionDigits == 0 && unformatted.contains(decimalSeparator)
    numberFormatter.alwaysShowsDecimalSeparator = needAlwaysShowDecimalSeparator
    
    numberFormatter.minimumIntegerDigits = calculateMinimumIntegerDigits(unformatted: unformatted, decimalSeparator: decimalSeparator)
    if unformatted == decimalSeparator {
      return (prefix ?? "") + decimalSeparator + (suffix ?? "")
    } else {
      return super.format(unformatted)
    }

  }
  
  private func calculateMinimumFractionDigits(unformatted: String, divider: String, maximumFractionDigits: Int) -> Int {
    let currentFractionDigitsCount = getFractionDigitsCount(unformatted: unformatted, divider: divider)
    if currentFractionDigitsCount >= maximumFractionDigits { return maximumFractionDigits }
    return currentFractionDigitsCount
  }
  
  private func getFractionDigitsCount(unformatted: String, divider: String) -> Int {
    let parts = unformatted.components(separatedBy: divider)
    if unformatted.hasPrefix(divider), parts.count > 0 {
      return parts[0].count
    }
    guard parts.count > 1 else { return 0 }
    return parts[1].count
  }
  
  private func calculateMinimumIntegerDigits(unformatted: String, decimalSeparator: String) -> Int {
    let isBeginFromDecimalSeparator = unformatted.hasPrefix(decimalSeparator)
    let hasIntegerPart = !isBeginFromDecimalSeparator
    if hasIntegerPart {
      return 1
    } else {
      return 0
    }
  }

  open func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
    let unformattedCurrentText = unformat(currentText) ?? ""
    let unformattedRange = convertToUnformattedRange(currentText: currentText, unformattedCurrentText: unformattedCurrentText, range: range)
    let newUnformattedText = unformattedCurrentText.replacingCharacters(in: unformattedRange, with: text)
    let newFormattedText = format(newUnformattedText) ?? ""
    
    let caretOffset = calculateCaretOffset(range: range, replacementText: text, unformattedRange: unformattedRange, currentFormattedText: currentText, newFormattedText: newFormattedText, currentUnformattedText: unformattedCurrentText, newUnformattedText: newUnformattedText)
    return FormattedTextValue(formattedText: newFormattedText, caretBeginOffset: caretOffset)
  }
  
  private func calculateCaretOffset(
      range: NSRange,
      replacementText: String,
      unformattedRange: NSRange,
      currentFormattedText: String,
      newFormattedText: String,
      currentUnformattedText: String,
      newUnformattedText: String) -> Int {
    let isInsert = range.length == 0 && !replacementText.isEmpty
    let isDelete = range.length != 0 && replacementText.isEmpty
    
    let difference = diff(newFormattedText, currentFormattedText)
    print(difference)
    
    if isInsert {
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
        if let suffix = suffix, newFormattedText.hasSuffix(suffix), range.location == currentFormattedText.count {
          result = findIndexOfNumberSymbol(numberOfSymolsFromEnd: currentFormattedText.count - range.location, newFormattedText: newFormattedText) + 1 - suffix.count
        } else if range.location == currentFormattedText.count {
          result = findIndexOfNumberSymbol(numberOfSymolsFromEnd: currentFormattedText.count - range.location, newFormattedText: newFormattedText) + 1
        } else {
          result = findIndexOfNumberSymbol(numberOfSymolsFromEnd: currentFormattedText.count - range.location, newFormattedText: newFormattedText)
        }
        if range.location < prefixLength {
//          result += prefixLength - range.location
        }
        return result
      }
    } else if isDelete {
      if let prefix = prefix, newFormattedText.hasPrefix(prefix), range.location <= prefix.count {
        return range.location
      } else if unformattedRange.location == 0 {
        return findIndexOfNumberSymbol(numberOfSymbolsBefore: unformattedRange.location, newFormattedText: newFormattedText)
      } else {
        return findIndexOfNumberSymbol(numberOfSymbolsBefore: unformattedRange.location, newFormattedText: newFormattedText) + 1
      }
    } else { // isReplace
      var result = 0
      let rangeLocation = range.location + range.length
      if rangeLocation == currentFormattedText.count {
        result = findReplaceIndexOfNumberSymbol(numberOfSymolsFromEnd: currentFormattedText.count - rangeLocation, newFormattedText: newFormattedText) + 1
      } else {
        result = findReplaceIndexOfNumberSymbol(numberOfSymolsFromEnd: currentFormattedText.count - rangeLocation, newFormattedText: newFormattedText)
      }
      
      return result
    }
  }
  
  // for insert
  private func findIndexOfNumberSymbol(numberOfSymolsFromEnd: Int, newFormattedText: String) -> Int {
    var numberSymbolsCount = 0
    for (index, character) in newFormattedText.enumerated().reversed() {
      numberSymbolsCount += 1
      if numberSymbolsCount >= numberOfSymolsFromEnd {
        return index
      }
    }
    return 0
  }
  
  // for delete
  private func findIndexOfNumberSymbol(numberOfSymbolsBefore: Int, newFormattedText: String) -> Int {
    var numberSymbolsCount = 0
    for (index, character) in newFormattedText.enumerated() {
      if isDigit(character: character) || character == decimalSeparator.first! {
        numberSymbolsCount += 1
      }
      if numberSymbolsCount >= numberOfSymbolsBefore {
        return index
      }
    }
    return 0
  }
  
  // for replace
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
  
  private func convertToUnformattedRange(currentText: String, unformattedCurrentText: String, range: NSRange) -> NSRange {
    let currentTextBeforeRangeLocation = currentText.leftSlice(limit: range.location)
    let unformattedTextBeforeRangeLocation = removeAllFormatSymbols(text: currentTextBeforeRangeLocation)
    
    
    let textLengthDifference = currentTextBeforeRangeLocation.count - unformattedTextBeforeRangeLocation.count
    var convertedRange = range
    
    convertedRange.location -= textLengthDifference
    if range.length > 0 {
      let rangeSlice = currentText.slice(from: range.location, length: range.length) ?? ""
      let uls = removeAllFormatSymbols(text: rangeSlice)
      convertedRange.length -= rangeSlice.count - uls.count
    }
    
    return convertedRange
  }
  
  // MARK: - Caret offset calculation
  
  private func calculateCaretOffset(replacementString: String, range: NSRange) -> Int {
    return replacementString.count + range.location
  }
}



// Diff

public func diff(_ before: String, _ after: String) -> (CountableRange<Int>, String)? {
  #if swift(>=4.0)
  let result = diff(Array(before), Array(after))
  #else
  let result = diff(Array(before.characters), Array(after.characters))
  #endif
  
  return result.flatMap { ($0.0, String($0.1)) }
}

public func diff<T: Equatable>(_ before: [T], _ after: [T]) -> (CountableRange<Int>, [T])? {
  return diff(before, after, compare: ==)
}

public func diff<T>(_ before: [T], _ after: [T], compare: (T, T) -> Bool) -> (CountableRange<Int>, [T])? {
  let beforeCount = before.count
  let afterCount = after.count
  
  // Find start
  var commonStart = 0
  while commonStart < beforeCount && commonStart < afterCount && compare(before[commonStart], after[commonStart]) {
    commonStart += 1
  }
  
  // Find end
  var commonEnd = 0
  while commonEnd + commonStart < beforeCount && commonEnd + commonStart < afterCount && compare(before[beforeCount - 1 - commonEnd], after[afterCount - 1 - commonEnd]) {
    commonEnd += 1
  }
  
  // Remove
  if beforeCount != commonStart + commonEnd {
    let range = commonStart..<(beforeCount - commonEnd)
    let intersection = commonStart..<(afterCount - commonEnd)
    return (range, Array(after[intersection]))
  }
  
  // Insert
  if afterCount != commonStart + commonEnd {
    let range = commonStart..<(afterCount - commonEnd)
    return (commonStart..<commonStart, Array(after[range]))
  }
  
  // Already equal
  return nil
}

public func diff(_ before: NSString, _ after: NSString) -> (NSRange, NSString)? {
  let result = diff(Array(before.characters), Array(after.characters))
  return result.flatMap { range, characters in
    let string = NSString(characters: characters, length: characters.count)
    return (NSRange(location: range.startIndex, length: range.count), string)
  }
}


extension NSString {
  var characters: [unichar] {
    var characters = [unichar]()
    
    for i in 0..<length {
      characters.append(character(at: i))
    }
    
    return characters
  }
}
