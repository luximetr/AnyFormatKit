//
//  SumTextInputFormatterWithSuffixDelete2SymbolsTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 11.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWithSuffixDelete2SymbolsTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "#,###.##$")
  
  // |12|,345.67$  ->  |345.67$
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 0, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "345.67$", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1|2,|345.67$  ->  1|,345.67$
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 1, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,345.67$", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12|,3|45.67$  ->  1,2|45.67$
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 2, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,245.67$", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,|34|5.67$  ->  12|5.67$
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 3, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "125.67$", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,3|45|.67$  ->  123|.67$
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 4, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "123.67$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,34|5.|67$  ->  123,4|67$
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 5, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "123,467$", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,345|.6|7$  ->  123,45|7$
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 6, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "123,457$", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,345.|67|$  ->  12,345.|$
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 7, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12,345.$", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,345.6|7$|  ->  12,345.6|$
  func test9() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 8, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12,345.6$", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
}
