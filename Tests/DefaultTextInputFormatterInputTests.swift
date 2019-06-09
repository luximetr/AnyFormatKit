//
//  DefaultTextInputFormatterInputTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 09.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class DefaultTextInputFormatterInputTests: XCTestCase {
  
  let formatter = DefaultTextInputFormatter(textPattern: "## ## ##")
  
  override func setUp() {
  }
  
  override func tearDown() {
  }
  
  func test_to1Format() {
    let result = formatter.formatInput(
      currentText: "",
      range: NSRange(location: 0, length: 0),
      replacementString: "1")
    
    
  }
  
  func test_to1Caret() {
    let result = formatter.formatInput(
      currentText: "",
      range: NSRange(location: 0, length: 0),
      replacementString: "1")
    
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
