//
//  DefaultTextInputFormatter1SymbolReplaceTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 09.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class DefaultTextInputFormatter1SymbolReplaceTests: XCTestCase {
  
  private let formatter = DefaultTextInputFormatter(textPattern: "## ## ##")
  
  func test12_34to12_30() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 4, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "12 30", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_34to12_04() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 3, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "12 04", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_34to10_34() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "10 34", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_34to02_34() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "02 34", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12I_I34to12_03_4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 2, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "12 03 4", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
}
