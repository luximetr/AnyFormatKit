//
//  PlaceholderTextInputFormatterInsert3SymbolsTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 13.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class PlaceholderTextInputFormatterInsert3SymbolsTests: XCTestCase {
  
  // |#### #### -> 123|# ####
  func test1() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "#### ####",
      range: NSRange(location: 0, length: 0),
      replacementString: "123"
    )
    let expectedResult = FormattedTextValue(formattedText: "123# ####", caretBeginOffset: 3)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123|# #### -> 1234 56|##
  func test2() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "123# ####",
      range: NSRange(location: 3, length: 0),
      replacementString: "456"
    )
    let expectedResult = FormattedTextValue(formattedText: "1234 56##", caretBeginOffset: 7)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 1234 56|## -> 1234 5678|
  func test3() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 56##",
      range: NSRange(location: 7, length: 0),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "1234 5678", caretBeginOffset: 9)
    XCTAssertEqual(result, expectedResult)
  }
  
  // |1234 5678 -> 789|1 2345
  func test4() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 0, length: 0),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "7891 2345", caretBeginOffset: 3)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 1|234 5678 -> 1789| 2345
  func test5() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 1, length: 0),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "1789 2345", caretBeginOffset: 4)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 12|34 5678 -> 1278 9|345
  func test6() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 2, length: 0),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "1278 9345", caretBeginOffset: 6)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123|4 5678 -> 1237 89|45
  func test7() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 3, length: 0),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "1237 8945", caretBeginOffset: 7)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 1234| 5678 -> 1234 789|5
  func test8() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 4, length: 0),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "1234 7895", caretBeginOffset: 8)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 1234 |5678 -> 1234 789|5
  func test9() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 5, length: 0),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "1234 7895", caretBeginOffset: 8)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 1234 567|8 -> 1234 5677|
  func test10() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 8, length: 0),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "1234 5677", caretBeginOffset: 9)
    XCTAssertEqual(result, expectedResult)
  }
}
