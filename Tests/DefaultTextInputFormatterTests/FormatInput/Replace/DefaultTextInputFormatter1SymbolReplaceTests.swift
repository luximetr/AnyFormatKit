//
//  DefaultTextInputFormatter1SymbolReplaceTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 09.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class DefaultTextInputFormatter1SymbolReplaceTests: XCTestCase {
  
  private let formatter = DefaultTextInputFormatter(textPattern: "## ## ##")
  
  // 12 3|4|  ->  12 30|
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 4, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "12 30", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 3, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "12 04", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test12_34to10_34() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "10 34", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test12_34to02_34() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "02 34", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test12I_I34to12_03_4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 2, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "12 03 4", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
}
