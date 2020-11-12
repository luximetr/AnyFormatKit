//
//  DefaultTextInputFormatterInputTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 09.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class DefaultTextInputFormatterInputTests: XCTestCase {
  
  let formatter = DefaultTextInputFormatter(textPattern: "## ## ##")
  
  override func setUp() {
  }
  
  override func tearDown() {
  }
  
  func test_to1() {
    let actualResult = formatter.formatInput(
      currentText: "",
      range: NSRange(location: 0, length: 0),
      replacementString: "1")
    let expectedResult = FormattedTextValue(formattedText: "1", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test1to12() {
    let actualResult = formatter.formatInput(
      currentText: "1",
      range: NSRange(location: 1, length: 0),
      replacementString: "2")
    let expectedResult = FormattedTextValue(formattedText: "12", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test12to12_3() {
    let actualResult = formatter.formatInput(
      currentText: "12",
      range: NSRange(location: 2, length: 0),
      replacementString: "3")
    let expectedResult = FormattedTextValue(formattedText: "12 3", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test12_3to12_34() {
    let actualResult = formatter.formatInput(
      currentText: "12 3",
      range: NSRange(location: 4, length: 0),
      replacementString: "4")
    let expectedResult = FormattedTextValue(formattedText: "12 34", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test12_3to01_23() {
    let actualResult = formatter.formatInput(
      currentText: "12 3",
      range: NSRange(location: 0, length: 0),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "01 23", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test12_3to10_23() {
    let actualResult = formatter.formatInput(
      currentText: "12 3",
      range: NSRange(location: 1, length: 0),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "10 23", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test12I_3to12_03() {
    let actualResult = formatter.formatInput(
      currentText: "12 3",
      range: NSRange(location: 2, length: 0),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "12 03", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test12_I3to12_03() {
    let actualResult = formatter.formatInput(
      currentText: "12 3",
      range: NSRange(location: 3, length: 0),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "12 03", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
}
