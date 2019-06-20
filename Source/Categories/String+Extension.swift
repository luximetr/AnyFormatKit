//
//  String+Extension.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 23.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

extension String {
  
  func characterAt(_ index: Int) -> Character? {
    guard index < count else { return nil }
    return self[self.index(self.startIndex, offsetBy: index)]
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
  
  func slice(from: Int, length: Int) -> String? {
    guard from < count, from + length < count else { return nil }
    let fromIndex = index(startIndex, offsetBy: from)
    let toIndex = index(fromIndex, offsetBy: length)
    return String(self[fromIndex..<toIndex])
  }
  
  func replacingCharacters(in range: NSRange, with replacement: String) -> String {
    guard range.location <= self.count else { return self }
    let maxLength = self.count
    var limitedRange = NSRange(location: range.location, length: range.length)
    if range.location + range.length > maxLength {
      limitedRange.length = self.count - range.location
    }
    guard let swiftRange = Range(limitedRange, in: self) else { return self }
    return replacingCharacters(in: swiftRange, with: replacement)
  }
}
