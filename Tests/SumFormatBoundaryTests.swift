//
//  SumFormatBoundaryTests.swift
//  AnyFormatKitTests
//
//  Created by BRANDERSTUDIO on 11/21/17.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import XCTest
import AnyFormatKit

class SumFormatBoundaryTests: XCTestCase {
  let sumFormatter = SumTextFormatter(textPattern: "#.###,#####")
  
  func testDefaultMaxIntegerCharacters() {
    let defaultMaxIntegerCharacters = 14
    XCTAssert(sumFormatter.maximumIntegerCharacters == defaultMaxIntegerCharacters,
              "maximumIntegerCharacters by defaults must be equal to \(defaultMaxIntegerCharacters)")
  }
  
  func testDefaultMaxFractionCharacters() {
    let defaultMaxFractionCharacters = 5
    XCTAssert(sumFormatter.maximumDecimalCharacters == defaultMaxFractionCharacters,
              "maximumDecimalCharacters by defaults must be equal to \(defaultMaxFractionCharacters)")
  }
  
  func testGreaterThanMaxIntegerCharacters() {
    sumFormatter.maximumIntegerCharacters = 5
    let initialString = "123456"
    let expectedString = "12.345"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testEqualThanMaxIntegerCharacters() {
    sumFormatter.maximumIntegerCharacters = 5
    let initialString = "12345"
    let expectedString = "12.345"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testLessThanMaxIntegerCharacters() {
    sumFormatter.maximumIntegerCharacters = 5
    let initialString = "1234"
    let expectedString = "1.234"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testGreaterTnanMaxFractionCharacters() {
    sumFormatter.maximumIntegerCharacters = 14
    let initialString = "0.123456"
    let expectedString = "0,12345"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testEqualToMaxFractionCharacters() {
    sumFormatter.maximumIntegerCharacters = 14
    let initialString = "0.12345"
    let expectedString = "0,12345"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testLessThanMaxFractionCharacters() {
    sumFormatter.maximumIntegerCharacters = 14
    let initialString = "0.1234"
    let expectedString = "0,1234"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testEqualTo14MaxIntegerCharacters() {
    sumFormatter.maximumIntegerCharacters = 14
    let initialString = String(repeating: "9", count: 14) // 99999999999999
    let expectedString = "99.999.999.999.999"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testMoreThat14MaxIntegerCharacters() {
    sumFormatter.maximumIntegerCharacters = 14
    let initialString = String(repeating: "9", count: 15) // 999999999999999
    let expectedString = "99.999.999.999.999"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testLessThan14MaxIntegerCharacters() {
    sumFormatter.maximumIntegerCharacters = 14
    let initialString = String(repeating: "9", count: 13) // 9999999999999
    let expectedString = "9.999.999.999.999"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testMoreThan5MaxIntegerCharacters() {
    sumFormatter.maximumIntegerCharacters = 5
    let initialString = String(repeating: "9", count: 6) // 999999
    let expectedString = "99.999"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testEqualTo5MaxIntegerCharacters() {
    sumFormatter.maximumIntegerCharacters = 5
    let initialString = String(repeating: "9", count: 5) // 99999
    let expectedString = "99.999"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testLessThan5MaxIntegerCharacters() {
    sumFormatter.maximumIntegerCharacters = 5
    let initialString = String(repeating: "9", count: 4) // 9999
    let expectedString = "9.999"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testMoreThan1MaxIntegerCharacters() {
    sumFormatter.maximumIntegerCharacters = 1
    let initialString = String(repeating: "9", count: 5) // 99999
    let expectedString = "9"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testEqualTo1MaxIntegerCharacters() {
    sumFormatter.maximumIntegerCharacters = 1
    let initialString = String(repeating: "9", count: 1) // 9
    let expectedString = "9"
    let formattedString = sumFormatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
}
