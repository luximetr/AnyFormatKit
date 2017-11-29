//
//  FormatParsingTests.swift
//  AnyFormatKitTests
//
//  Created by BRANDERSTUDIO on 11/21/17.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import XCTest
import AnyFormatKit

class FormatParsingTests: XCTestCase {
  func test5InGroupFormat() {
    let formatter = SumTextFormatter(textPattern: "X.XXXXX,XX", patternSymbol: "X")
    let initialString = "1234567890123"
    let expectedString = "123.45678.90123"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test3InGroupFormat() {
    let formatter = SumTextFormatter(textPattern: "X.XXX,XX", patternSymbol: "X")
    let initialString = "1234567890123"
    let expectedString = "1.234.567.890.123"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test1InGroupFormat() {
    let formatter = SumTextFormatter(textPattern: "X.X,XX", patternSymbol: "X")
    let initialString = "1234567"
    let expectedString = "1.2.3.4.5.6.7"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testGroupingSeparatorParsing() {
    let formatter = SumTextFormatter(textPattern: "X.XXX,XX", patternSymbol: "X")
    let initialString = "1234567890"
    let expectedString = "1.234.567.890"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testDecimalSeparatorParsing() {
    let formatter = SumTextFormatter(textPattern: "X.XXX,X", patternSymbol: "X")
    let initialString = "12345.12"
    let expectedString = "12.345,12"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testPrefixParsing() {
    let formatter = SumTextFormatter(textPattern: "Prefix: X.XXX,XX", patternSymbol: "X")
    let initialString = "123456789,01"
    let expectedString = "Prefix: 123.456.789,01"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testSufixParsing() {
    let formatter = SumTextFormatter(textPattern: "X.XXX,XX <-Sufix", patternSymbol: "X")
    let initialString = "1234567"
    let expectedString = "1.234.567 <-Sufix"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
}
