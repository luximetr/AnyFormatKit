//
//  AnyFormatKitTests.swift
//  AnyFormatKitTests
//
//  Created by BRANDERSTUDIO on 01.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class AnyFormatKitTests: XCTestCase {
  let phoneNumberFormatter = DefaultTextFormatter(textPattern: "### (###) ##-##-###")
  
  func testOneSymbolFormatting() {
    let expectedString = "3"
    let formattedString = phoneNumberFormatter.format("3")
    XCTAssert(expectedString == formattedString, "\(expectedString) must be equal to \(String(describing: formattedString))")
  }
  
  func testFullStringFormatting() {
    let expectedString = "123 (456) 78-78-789"
    let formattedString = phoneNumberFormatter.format("1234567878789")
    XCTAssert(expectedString == formattedString, "\(expectedString) must be equal to \(String(describing: formattedString))")
  }
  
  func testOverLengthStringFormatting() {
    let expectedString = "123 (456) 78-78-789"
    let formattedString = phoneNumberFormatter.format("123456787878900000")
    XCTAssert(expectedString == formattedString, "\(expectedString) must be equal to \(String(describing: formattedString))")
  }
  
  func testEmptyStringFormatting() {
    let expectedString = ""
    let formattedString = phoneNumberFormatter.format("")
    XCTAssert(expectedString == formattedString, "\(expectedString) must be equal to \(String(describing: formattedString))")
  }
  
  func testNilStringFormatting() {
    let expectedString: String? = nil
    let formattedString = phoneNumberFormatter.format(nil)
    XCTAssert(expectedString == formattedString, "\(String(describing: expectedString)) must be equal to \(String(describing: formattedString))")
  }
  
  func testHalfStringFormatting() {
    let expectedString = "123 (45"
    let formattedString = phoneNumberFormatter.format("12345")
    XCTAssert(expectedString == formattedString, "\(expectedString) must be equal to \(String(describing: formattedString))")
  }
}
