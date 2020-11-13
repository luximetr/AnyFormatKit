//
//  PlaceholderTextInputFormatterInputTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class PlaceholderTextInputFormatterInputTests: XCTestCase {
  
  // "|### ###"  ->  1|## ###
  func test1() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "### ###",
      range: NSRange(location: 0, length: 0),
      replacementString: "1"
    )
    let expectedResult = FormattedTextValue(formattedText: "1## ###", caretBeginOffset: 1)
    XCTAssertEqual(result, expectedResult)
  }

  // 1|## ### -> 12|# ###
  func test2() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "1## ###",
      range: NSRange(location: 1, length: 0),
      replacementString: "2"
    )
    let expectedResult = FormattedTextValue(formattedText: "12# ###", caretBeginOffset: 2)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 12|# ### -> 123| ###
  func test3() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "12# ###",
      range: NSRange(location: 2, length: 0),
      replacementString: "3"
    )
    let expectedResult = FormattedTextValue(formattedText: "123 ###", caretBeginOffset: 3)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123| ### -> 123 4|##
  
  func test4() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 ###",
      range: NSRange(location: 3, length: 0),
      replacementString: "4"
    )
    let expectedResult = FormattedTextValue(formattedText: "123 4##", caretBeginOffset: 5)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123 4|## -> 123 45|#
  
  func test5() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 4##",
      range: NSRange(location: 5, length: 0),
      replacementString: "5"
    )
    let expectedResult = FormattedTextValue(formattedText: "123 45#", caretBeginOffset: 6)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123 45|# -> 123 456|
  
  func test6() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 45#",
      range: NSRange(location: 6, length: 0),
      replacementString: "6"
    )
    let expectedResult = FormattedTextValue(formattedText: "123 456", caretBeginOffset: 7)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123 456| -> 123 456|
  
  func test7() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 456",
      range: NSRange(location: 7, length: 0),
      replacementString: "7"
    )
    let expectedResult = FormattedTextValue(formattedText: "123 456", caretBeginOffset: 7)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 12|3 4## -> 120| 34#
  
  func test8() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 4##",
      range: NSRange(location: 2, length: 0),
      replacementString: "0"
    )
    let expectedResult = FormattedTextValue(formattedText: "120 34#", caretBeginOffset: 3)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 12|3 456 -> 120| 345
  
  func test9() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 456",
      range: NSRange(location: 2, length: 0),
      replacementString: "0"
    )
    let expectedResult = FormattedTextValue(formattedText: "120 345", caretBeginOffset: 3)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 1|23 ### -> 10|2 3##
  
  func test10() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 ###",
      range: NSRange(location: 1, length: 0),
      replacementString: "0"
    )
    let expectedResult = FormattedTextValue(formattedText: "102 3##", caretBeginOffset: 2)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123| 45# -> 123 0|45
  
  func test11() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 45#",
      range: NSRange(location: 3, length: 0),
      replacementString: "0"
    )
    let expectedResult = FormattedTextValue(formattedText: "123 045", caretBeginOffset: 5)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123 |45# -> 123 0|45
  
  func test12() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 456",
      range: NSRange(location: 4, length: 0),
      replacementString: "0"
    )
    let expectedResult = FormattedTextValue(formattedText: "123 045", caretBeginOffset: 5)
    XCTAssertEqual(result, expectedResult)
  }

}
