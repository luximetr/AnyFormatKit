//
//  SumTextInputFormatterWithSuffixReplace3SymbolsTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 12.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWithSuffixReplace3SymbolsTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "#,###.##$")
  
  // |12,|345.67$  ->  9,|345.67$
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 0, length: 3),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "9,345.67$", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1|2,3|45.67$  ->  1,9|45.67$
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 1, length: 3),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "1,945.67$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12|,34|5.67$  ->  1,29|5.67$
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 2, length: 3),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "1,295.67$", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,|345|.67$  ->  129|.67$
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 3, length: 3),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "129.67$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,3|45.|67$  ->  123,9|67$
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 4, length: 3),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "123,967$", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,34|5.6|7$  ->  123,49|7$
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 5, length: 3),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "123,497$", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345|.67|$  ->  123,459|$
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 6, length: 3),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "123,459$", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345.|67$|  ->  12,345.9$|
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 7, length: 3),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "12,345.9$", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
}
