//
//  PlaceholderTextInputFormatterDelete3SymbolsTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 13.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class PlaceholderTextInputFormatterDelete3SymbolsTests: XCTestCase {
  
  // |123|4 5678 -> |4567 8###
  func test1() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 0, length: 3),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "4567 8###", caretBeginOffset: 0)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 12|34 |5678 -> 12|56 78##
  func test2() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 2, length: 3),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "1256 78##", caretBeginOffset: 2)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 123|4 5|678 -> 123|6 78##
  func test3() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 3, length: 3),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "1236 78##", caretBeginOffset: 3)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 1234| 56|78 -> 1234| 78##
  func test4() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 4, length: 3),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "1234 78##", caretBeginOffset: 4)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 1234 |567|8 -> 1234| 8###
  func test5() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 5, length: 3),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "1234 8###", caretBeginOffset: 4)
    XCTAssertEqual(result, expectedResult)
  }
  
  // 1234 5|678| -> 1234 5|###
  func test6() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "1234 5678",
      range: NSRange(location: 6, length: 3),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "1234 5###", caretBeginOffset: 6)
    XCTAssertEqual(result, expectedResult)
  }
  
  // #|###| #### -> #|### ####
  func test7() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "#### ####",
      range: NSRange(location: 1, length: 3),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "#### ####", caretBeginOffset: 1)
    XCTAssertEqual(result, expectedResult)
  }
  
  // ###|# #|### -> ###|# ####
  func test8() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "#### ####",
      range: NSRange(location: 3, length: 3),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "#### ####", caretBeginOffset: 3)
    XCTAssertEqual(result, expectedResult)
  }
  
  // #### #|###| -> #### #|###
  func test9() {
    let formatter = PlaceholderTextInputFormatter(textPattern: "#### ####")
    let result = formatter.formatInput(
      currentText: "#### ####",
      range: NSRange(location: 6, length: 3),
      replacementString: ""
    )
    let expectedResult = FormattedTextValue(formattedText: "#### ####", caretBeginOffset: 6)
    XCTAssertEqual(result, expectedResult)
  }
}
