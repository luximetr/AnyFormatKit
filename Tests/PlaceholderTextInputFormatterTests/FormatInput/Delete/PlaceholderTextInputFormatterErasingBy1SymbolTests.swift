//
//  PlaceholderTextInputFormatterErasingBy1SymbolTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 13.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import XCTest
import AnyFormatKit

class PlaceholderTextInputFormatterErasingBy1SymbolTests: XCTestCase {
  
  // 123 45|6| -> 123 45|#
  func test1() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 456",
      range: NSRange(location: 6, length: 1),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "123 45#", caretBeginOffset: 6)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123 4|5|# -> 123 4|##
  func test2() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 45#",
      range: NSRange(location: 5, length: 1),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "123 4##", caretBeginOffset: 5)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123 |4|## -> 123| ###
  func test3() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 4##",
      range: NSRange(location: 4, length: 1),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "123 ###", caretBeginOffset: 3)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123| |### -> 123| ###
  func test4() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 ###",
      range: NSRange(location: 3, length: 1),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "123 ###", caretBeginOffset: 3)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 12|3| ### -> 12|# ###
  func test5() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "123 ###",
      range: NSRange(location: 2, length: 1),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "12# ###", caretBeginOffset: 2)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 1|2|# ### -> 1|## ###
  func test6() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "12# ###",
      range: NSRange(location: 1, length: 1),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "1## ###", caretBeginOffset: 1)
    XCTAssertEqual(result, expectedResult)
  }
  
  // |1|## ### -> |### ###
  func test7() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "1## ###",
      range: NSRange(location: 0, length: 1),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "### ###", caretBeginOffset: 0)
    XCTAssertEqual(result, expectedResult)
  }
  
  // #|#|# ### -> #|## ###
  func test8() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
    let result = formatter.formatInput(
      currentText: "### ###",
      range: NSRange(location: 1, length: 1),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "### ###", caretBeginOffset: 1)
    XCTAssertEqual(result, expectedResult)
  }
}
