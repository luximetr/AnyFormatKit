//
//  PlaceholderTextInputUnformattingTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 18.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import XCTest
import AnyFormatKit

class PlaceholderTextInputUnformattingTests: XCTestCase {
    
    func test1() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
      let result = formatter.unformat("12## ####")
      let expectedResult = "12"
      XCTAssertEqual(result, expectedResult)
    }
    
    func test2() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
      let result = formatter.unformat("#### ####")
      let expectedResult = ""
      XCTAssertEqual(result, expectedResult)
    }
    
    func test3() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
      let result = formatter.unformat("1234 ####")
      let expectedResult = "1234"
      XCTAssertEqual(result, expectedResult)
    }
    
    func test4() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
      let result = formatter.unformat("1234 5###")
      let expectedResult = "12345"
      XCTAssertEqual(result, expectedResult)
    }
}
