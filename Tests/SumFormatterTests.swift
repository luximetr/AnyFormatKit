//
//  SumFormatterTests.swift
//  AnyFormatKitTests
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumFormatterTests: XCTestCase {
  let sumFormatter = SumTextFormatter()
  
  override func setUp() {
    super.setUp()
    sumFormatter.groupingSeparator = " "
    sumFormatter.decimalSeparator = "."
    sumFormatter.minimumFractionDigits = 2
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test5000dot00ValueFormatting() {
    let expectedString = "5 000.00"
    let formattedString = sumFormatter.formattedText(from: "5000.00")
    XCTAssert(expectedString == formattedString, "\(expectedString) not equal to \(String(describing: formattedString))")
  }
  
  func test5000ValueFormatting() {
    let expectedString = "5 000.00"
    let formattedString = sumFormatter.formattedText(from: "5000")
    XCTAssert(expectedString == formattedString, "\(expectedString) not equal to \(String(describing: formattedString))")
  }
  
  func test0dotValueFormatting() {
    let expectedString = "0.00"
    let formattedString = sumFormatter.formattedText(from: "0.")
    XCTAssert(expectedString == formattedString, "\(expectedString) not equal to \(String(describing: formattedString))")
  }
  
//  func test0commaValueFormatting() {
//    let expectedString = "0.00"
//    let formattedString = sumFormatter.formattedText(from: "0,")
//    XCTAssert(expectedString == formattedString, "\(expectedString) not equal to \(String(describing: formattedString))")
//  }
  
  func testDot0ValueFormatting() {
    let expectedString = "0.00"
    let formattedString = sumFormatter.formattedText(from: ".0")
    XCTAssert(expectedString == formattedString, "\(expectedString) not equal to \(String(describing: formattedString))")
  }
  
//  func testComma0ValueFormatting() {
//    let expectedString = "0.00"
//    let formattedString = sumFormatter.formattedText(from: ",0")
//    XCTAssert(expectedString == formattedString, "\(expectedString) not equal to \(String(describing: formattedString))")
//  }
  
  func test0ValueFormatting() {
    let expectedString = "0.00"
    let formattedString = sumFormatter.formattedText(from: "0")
    XCTAssert(expectedString == formattedString, "\(expectedString) not equal to \(String(describing: formattedString))")
  }

//  func testDotValueFormatting() {
//    let expectedString = "0.00"
//    let formattedString = sumFormatter.formattedText(from: ".")
//    XCTAssert(expectedString == formattedString, "\(expectedString) not equal to \(String(describing: formattedString))")
//  }

  func testSingleNumberFormatting() {
    let expectedString = "1.00"
    let formattedString = sumFormatter.formattedText(from: "1")
    XCTAssert(expectedString == formattedString, "\(expectedString) not equal to \(String(describing: formattedString))")
  }
}
