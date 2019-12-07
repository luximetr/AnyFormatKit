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

    let decimalSeparator = parseDecimalSeparator(format: format,
                                                 suffix: suffix,
                                                 patternSymbol: patternSymbol,
                                                 groupingSeparator: groupingSeparator)

    let groupingSize = parseGroupingSize(format: format,
                                         groupingSeparator: groupingSeparator,
                                         decimalSeparator: decimalSeparator,
                                         suffix: suffix)

    let maximumFractionDigits = parseMaximumFractionDigits(format: format,
                                                           decimalSeparator: decimalSeparator,
                                                           suffix: suffix,
                                                           patternSymbol: patternSymbol)

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
  
  private func parseDecimalSeparator(format: String, suffix: String, patternSymbol: Character, groupingSeparator: String) -> String {
    let formatWithoutSuffix = format.removeSuffix(suffix)

    guard let decimalSeparatorPart = formatWithoutSuffix.split(separator: patternSymbol).last else { return "" }

    guard decimalSeparatorPart != groupingSeparator else { return "" }

    return String(decimalSeparatorPart)
  }
  
  private func parseGroupingSize(format: String, groupingSeparator: String, decimalSeparator: String, suffix: String) -> Int {
    let groupPart: String

    if !decimalSeparator.isEmpty {
      groupPart = format.slice(from: groupingSeparator, to: decimalSeparator)
    } else {
      groupPart = format.slice(from: groupingSeparator, to: suffix)
    }

    return groupPart.count
  }
  
  private func parseMaximumFractionDigits(format: String, decimalSeparator: String, suffix: String, patternSymbol: Character) -> Int {
    guard !decimalSeparator.isEmpty else {
      return 0
    }

    let fractionDigitsPart = format.slice(from: decimalSeparator, to: suffix)
    return fractionDigitsPart.count
  }
  
}
