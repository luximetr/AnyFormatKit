//
//  PlaceholderTextInputFormatterReplace3SymbolsTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 13.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class PlaceholderTextInputFormatterReplace3SymbolsTests: XCTestCase {
  
  // |123| ### -> 789| ###
  func test1() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 ###",
      range: NSRange(location: 0, length: 3),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "789 ###", caretBeginOffset: 3)
    XCTAssertEqual(result, expectedResult)
  }
  
  // |123| 456 -> 789| 456
  func test2() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 456",
      range: NSRange(location: 0, length: 3),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "789 456", caretBeginOffset: 3)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 1|23 |### -> 178 9|##
  func test3() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 ###",
      range: NSRange(location: 1, length: 3),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "178 9##", caretBeginOffset: 5)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 12|3 #|## -> 127 89|#
  func test4() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 ###",
      range: NSRange(location: 2, length: 3),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "127 89#", caretBeginOffset: 6)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 12|3 4|56 -> 127 89|5
  func test5() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 456",
      range: NSRange(location: 2, length: 3),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "127 895", caretBeginOffset: 6)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123| ##|# -> 123 789|
  func test6() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 ###",
      range: NSRange(location: 3, length: 3),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "123 789", caretBeginOffset: 7)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123 |###| -> 123 789|
  func test7() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 ###",
      range: NSRange(location: 4, length: 3),
      replacementString: "789"
    )
    let expectedResult = FormattedTextValue(formattedText: "123 789", caretBeginOffset: 7)
    XCTAssertEqual(result, expectedResult)
  }
  
}
