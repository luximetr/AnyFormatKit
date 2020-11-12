//
//  PlaceholderFormatterFormattingTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class PlaceholderFormatterFormattingTests: XCTestCase {

  func test1() {
    let formatter = PlaceholderTextFormatter(textPattern: "#### ####")
    let result = formatter.format("12345678")
    let expectedResult = "1234 5678"
    XCTAssertEqual(result, expectedResult)
  }
  
  func test2() {
    let formatter = PlaceholderTextFormatter(textPattern: "#### ####")
    let result = formatter.format("12")
    let expectedResult = "12## ####"
    XCTAssertEqual(result, expectedResult)
  }
  
  func test3() {
    let formatter = PlaceholderTextFormatter(textPattern: "#### ####")
    let result = formatter.format("")
    let expectedResult = "#### ####"
    XCTAssertEqual(result, expectedResult)
  }
  
  func test4() {
    let formatter = PlaceholderTextFormatter(textPattern: "#### ####")
    let result = formatter.format(nil)
    let expectedResult = "#### ####"
    XCTAssertEqual(result, expectedResult)
  }
  
  func test5() {
    let formatter = PlaceholderTextFormatter(textPattern: "#### ####")
    let result = formatter.format("1")
    let expectedResult = "1### ####"
    XCTAssertEqual(result, expectedResult)
  }
  
}
