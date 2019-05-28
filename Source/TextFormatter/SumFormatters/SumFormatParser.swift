//
//  SumFormatParser.swift
//  AnyFormatKit
//
//  Created by branderstudio on 5/27/19.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import Foundation

class SumFormatParser {
  
  struct Result {
    let prefix: String
    let suffix: String
    let groupingSeparator: String
    let decimalSeparator: String
    let groupingSize: Int
    let maximumFractionDigits: Int
  }
  
  func parse(format: String, patternSymbol: Character) -> Result {
    let prefix = parsePrefix(format: format, patternSymbol: patternSymbol)
    let suffix = parseSuffix(format: format, patternSymbol: patternSymbol)
    let groupingSeparator = parseGroupingSeparator(format: format, prefix: prefix, patternSymbol: patternSymbol)
    let decimalSeparator = parseDecimalSeparator(format: format, suffix: suffix, patternSymbol: patternSymbol)
    let groupingSize = parseGroupingSize(format: format, groupingSeparator: groupingSeparator, decimalSeparator: decimalSeparator, patternSymbol: patternSymbol)
    let maximumFractionDigits = parseMaximumFractionDigits(format: format, decimalSeparator: decimalSeparator, suffix: suffix, patternSymbol: patternSymbol)
    return Result(prefix: prefix,
                  suffix: suffix,
                  groupingSeparator: groupingSeparator,
                  decimalSeparator: decimalSeparator,
                  groupingSize: groupingSize,
                  maximumFractionDigits: maximumFractionDigits)
  }
  
  private func parsePrefix(format: String, patternSymbol: Character) -> String {
    guard format.first != patternSymbol else { return "" }
    guard let prefixPart = format.split(separator: patternSymbol).first else { return "" }
    return String(prefixPart)
  }
  
  private func parseSuffix(format: String, patternSymbol: Character) -> String {
    guard format.last != patternSymbol else { return "" }
    guard let suffixPart = format.split(separator: patternSymbol).last else { return "" }
    return String(suffixPart)
  }
  
  private func parseGroupingSeparator(format: String, prefix: String, patternSymbol: Character) -> String {
    let formatWithoutPrefix = format.removePrefix(prefix)
    guard let groupingSeparatorPart = formatWithoutPrefix.split(separator: patternSymbol).first else { return "" }
    return String(groupingSeparatorPart)
  }
  
  private func parseDecimalSeparator(format: String, suffix: String, patternSymbol: Character) -> String {
    let formatWithoutSuffix = format.removeSuffix(suffix)
    guard let decimalSeparatorPart = formatWithoutSuffix.split(separator: patternSymbol).last else { return "" }
    return String(decimalSeparatorPart)
  }
  
  private func parseGroupingSize(format: String, groupingSeparator: String, decimalSeparator: String, patternSymbol: Character) -> Int {
    let groupPart = format.slice(from: groupingSeparator, to: decimalSeparator)
    return groupPart.count
  }
  
  private func parseMaximumFractionDigits(format: String, decimalSeparator: String, suffix: String, patternSymbol: Character) -> Int {
    let fractionDigitsPart = format.slice(from: decimalSeparator, to: suffix)
    return fractionDigitsPart.count
  }
  
}

private extension String {
  
  func sliceAfter(substring: String) -> String {
    guard count > substring.count else { return "" }
    guard let lastSubstringCharacter = substring.last else { return "" }
    guard let substringIndex = firstIndex(of: lastSubstringCharacter) else { return "" }
    let indexAfterSubstringIndex = index(substringIndex, offsetBy: 1)
    return String(self[indexAfterSubstringIndex..<endIndex])
  }
  
  func sliceBefore(substring: String) -> String {
    guard count > substring.count else { return "" }
    guard let firstSubstringCharacter = substring.first else { return self }
    guard let substringStartIndex = lastIndex(of: firstSubstringCharacter) else { return self }
    return String(self[startIndex..<substringStartIndex])
  }
  
  func slice(from: String, to: String) -> String {
    return sliceAfter(substring: from).sliceBefore(substring: to)
  }
  
  func removePrefix(_ prefix: String) -> String {
    guard !prefix.isEmpty else { return self }
    return sliceAfter(substring: prefix)
  }
  
  func removeSuffix(_ suffix: String) -> String {
    guard !suffix.isEmpty else { return self }
    return sliceBefore(substring: suffix)
  }
}
