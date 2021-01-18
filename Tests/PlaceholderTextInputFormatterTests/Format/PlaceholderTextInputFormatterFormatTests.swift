//
//  PlaceholderTextInputFormatterFormatTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 18.01.2021.
//  Copyright © 2021 BRANDERSTUDIO. All rights reserved.
//

import XCTest
import AnyFormatKit

class PlaceholderTextInputFormatterFormatTests: XCTestCase {
    
    func test1() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
      let result = formatter.format("12345678")
      let expectedResult = "1234 5678"
      XCTAssertEqual(result, expectedResult)
    }
    
    func test2() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
      let result = formatter.format("12")
      let expectedResult = "12## ####"
      XCTAssertEqual(result, expectedResult)
    }
    
    func test3() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
      let result = formatter.format("")
      let expectedResult = "#### ####"
      XCTAssertEqual(result, expectedResult)
    }
    
    func test4() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
      let result = formatter.format(nil)
      let expectedResult = "#### ####"
      XCTAssertEqual(result, expectedResult)
    }
    
    func test5() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
      let result = formatter.format("1")
      let expectedResult = "1### ####"
      XCTAssertEqual(result, expectedResult)
    }
    
    func test6() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
      let result = formatter.format("123456789")
      let expectedResult = "1234 5678"
      XCTAssertEqual(result, expectedResult)
    }
    
    func test7() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
      let result = formatter.format("1234567")
      let expectedResult = "1234 567#"
      XCTAssertEqual(result, expectedResult)
    }

}
