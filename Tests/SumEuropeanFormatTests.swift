//
//  SumEuropeanFormatTests.swift
//  AnyFormatKitTests
//
//  Created by BRANDERSTUDIO on 11/15/17.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import XCTest
import AnyFormatKit

class SumEuropeanFormatTests: XCTestCase {
  let sumFormatter = SumTextFormatter(textPattern: "#.###,##")
}

// MARK: - Empty string tests
extension SumEuropeanFormatTests {
  func testEmptyString() {
    let initialString = ""
    let expectedString = ""
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testNilString() {
    let initialString: String? = nil
    let expectedString: String? = nil
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(String(describing: expectedString))")
  }
}

// MARK: - Zero values tests
extension SumEuropeanFormatTests {
  func testZeroDecimal() {
    let initialString = "0"
    let expectedString = "0"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test0comma0Formatting() {
    let initialString = "0,0"
    let expectedString = "0,0"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test0dot0Formatting() {
    let initialString = "0.0"
    let expectedString = "0,0"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test0comma00Formatting() {
    let initialString = "0,00"
    let expectedString = "0,00"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test00dot0Formatting() {
    let initialString = "00.0"
    let expectedString = "0,0"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test00dot00Formatting() {
    let initialString = "00.00"
    let expectedString = "0,00"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test0dot000Formatting() {
    let initialString = "0.000"
    let expectedString = "0,00"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
}

// MARK: - Correct values tests
extension SumEuropeanFormatTests {
  func test1Formatting() {
    let initialString = "1"
    let expectedString = "1"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test12Formatting() {
    let initialString = "12"
    let expectedString = "12"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test123Formatting() {
    let initialString = "123"
    let expectedString = "123"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
}

// MARK: - Thousand values tests
extension SumEuropeanFormatTests {
  func test1234Formatting() {
    let initialString = "1234"
    let expectedString = "1.234"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test1234dot5Formatting() {
    let initialString = "1234.5"
    let expectedString = "1.234,5"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test1234dot56Formatting() {
    let initialString = "1234.56"
    let expectedString = "1.234,56"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test123456Formatting() {
    let initialString = "123456"
    let expectedString = "123.456"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test1234567Formatting() {
    let initialString = "1234567"
    let expectedString = "1.234.567"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test1234567dot12Formatting() {
    let initialString = "1234567.12"
    let expectedString = "1.234.567,12"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testDotAtEndFormatting() {
    let initialString = "1234567."
    let expectedString = "1.234.567,"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
}
