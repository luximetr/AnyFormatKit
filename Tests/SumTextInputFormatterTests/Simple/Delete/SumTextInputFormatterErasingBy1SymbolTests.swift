//
//  SumTextInputFormatterErasingBy1SymbolTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 15.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterErasingBy1SymbolTests: XCTestCase {
  
  let formatter = SumTextInputFormatter(textPattern: "#,###.##")
  
  // 12,345.6|7|  ->  12,345.6|
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 8, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12,345.6", caretBeginOffset: 8)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }

  // 12,345.|6|  ->  12,345.|
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.6",
      range: NSRange(location: 7, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12,345.", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,345|.|  ->  12,345|
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.",
      range: NSRange(location: 6, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12,345", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,34|5|  ->  1,234|
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "12,345",
      range: NSRange(location: 5, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,234", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1,23|4|  ->  123|
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "1,234",
      range: NSRange(location: 4, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "123", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12|3|  ->  12|
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "123",
      range: NSRange(location: 2, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1|2|  ->  1|
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "12",
      range: NSRange(location: 1, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // |1|   ->  "|"
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "1",
      range: NSRange(location: 0, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
}
