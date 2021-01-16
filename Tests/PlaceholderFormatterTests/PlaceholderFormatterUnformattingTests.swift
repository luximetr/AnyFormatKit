//
//  PlaceholderFormatterUnformattingTests.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class PlaceholderFormatterUnformattingTests: XCTestCase {
  
  func test1() {
    let formatter = PlaceholderTextFormatter(textPattern: "#### ####")
    let result = formatter.unformat("12## ####")
    let expectedResult = "12"
    XCTAssertEqual(result, expectedResult)
  }
  
  func test2() {
    let formatter = PlaceholderTextFormatter(textPattern: "#### ####")
    let result = formatter.unformat("#### ####")
    let expectedResult = ""
    XCTAssertEqual(result, expectedResult)
  }
  
  func test3() {
    let formatter = PlaceholderTextFormatter(textPattern: "#### ####")
    let result = formatter.unformat("1234 ####")
    let expectedResult = "1234"
    XCTAssertEqual(result, expectedResult)
  }
  
  func test4() {
    let formatter = PlaceholderTextFormatter(textPattern: "#### ####")
    let result = formatter.unformat("1234 5###")
    let expectedResult = "12345"
    XCTAssertEqual(result, expectedResult)
  }
}
