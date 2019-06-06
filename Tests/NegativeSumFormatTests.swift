//
//  NegativeSumFormatTests.swift
//  AnyFormatKitTests
//
//  Created by BRANDERSTUDIO on 11/21/17.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import XCTest
import AnyFormatKit

class NegativeSumFormatTests: XCTestCase {
  let sumFormatter = SumTextFormatter(textPattern: "#.###,##")

  func testMinusFormatting() {
    let initialString = "-"
    let expectedString = "-"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testMinus1Formatting() {
    let initialString = "-1"
    let expectedString = "-1"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testMinus10Formatting() {
    let initialString = "-10"
    let expectedString = "-10"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testMinus1000Formatting() {
    let initialString = "-1000"
    let expectedString = "-1.000"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testMinus1000dot0Formatting() {
    let initialString = "-1000.0"
    let expectedString = "-1.000,0"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testMinus1000dot000Formatting() {
    let initialString = "-1000.000"
    let expectedString = "-1.000,00"
    let formattedString = sumFormatter.format(initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
}
