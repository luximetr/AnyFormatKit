//
//  String+Extension.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 23.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

// MARK: - String extension
extension String {
  /**
   Filter string with given regular expression
   
   - Parameters:
     - regex: optional regular expression, that use for filter all symbols, that don't satisfy the RegEx
   
   - Returns: optional filtered string with symbols, that satify to RegEx
  */
  func filter(regex: String?) -> String {
    guard let regex = regex else { return self }
    let regexPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
    let filteredCharacters = filter { (character) -> Bool in
      regexPredicate.evaluate(with: String(character))
    }
    return String(filteredCharacters)
  }
  
  /**
   Find and return character in string by index
   
   - Parameters:
     - index: integer value, of character, that need to find
   
   - Returns: found character or nil
  */
  
  func characterAt(_ index: Int) -> Character? {
    guard index < count else { return nil }
    return self[self.index(self.startIndex, offsetBy: index)]
  }
  
  var first: String {
    return String(prefix(1))
  }
  
  var last: String {
    return String(suffix(1))
  }
  
  var uppercaseFirst: String {
    return first.uppercased() + String(dropFirst())
  }
  
  func addingPercentEncodingForQuery() -> String? {
    let allowed = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._* ")
    return addingPercentEncoding(withAllowedCharacters: allowed)?.replacingOccurrences(of: " ", with: "+")
  }
  
  func isOnlyDigits() -> Bool {
    return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
  }
  
  func slice(from: String, toString: String) -> String? {
    return (range(of: from)?.upperBound).flatMap { substringFrom in
      (range(of: toString, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
        String(self[substringFrom..<substringTo])
      }
    }
  }
  
  func sliceAfter(substring: String) -> String {
    guard self.contains(substring) else { return self }
    guard count > substring.count else { return "" }
    guard let lastSubstringCharacter = substring.last else { return "" }
    guard let substringIndex = firstIndex(of: lastSubstringCharacter) else { return "" }
    let indexAfterSubstringIndex = index(substringIndex, offsetBy: 1)
    return String(self[indexAfterSubstringIndex..<endIndex])
  }
  
  func sliceBefore(substring: String) -> String {
    guard self.contains(substring) else { return self }
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
  
  func leftSlice(limit: Int) -> String {
    guard limit < count else { return self }
    let rangeBegin = startIndex
    let rangeEnd = index(startIndex, offsetBy: limit)
    return String(self[rangeBegin..<rangeEnd])
  }
}
