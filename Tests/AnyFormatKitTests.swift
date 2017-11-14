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
  let phoneNumberFormatter = TextFormatter(textPattern: "### (###) ##-##-###")
  
  override func setUp() {
    super.setUp()
  }
  
  func testOneSymbolFormatting() {
    let expectedString = "3"
    let formattedString = phoneNumberFormatter.formattedText(from: "3")
    XCTAssert(expectedString == formattedString, "\(expectedString) must be equal to \(String(describing: formattedString))")
  }
}
