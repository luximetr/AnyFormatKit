//
//  SumTextInputFormatterWithSuffixDeleteTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 10.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWithSuffixDeleteTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "#,###.##$")
  
  // |1|2,345.67$  ->  |2,345.67$
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 0, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "2,345.67$", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1|2|,345.67$  ->  1|,345.67$
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 1, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,345.67$", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12|,|345,67$  ->  12|,345.67$
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 2, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12,345.67$", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,|3|45.67$  ->  1,2|45.67$
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 3, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,245.67$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,3|4|5.67$  ->  1,23|5.67$
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 4, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,235.67$", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,34|5|.67$  ->  1,234|.67$
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 5, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,234.67$", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345|.|67$  ->  1,234,5|67$
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 6, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,234,567$", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345.|6|7$  ->  12,345.|7$
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 7, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12,345.7$", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345.6|7|$  ->  12,345.6|$
  func test9() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 8, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12,345.6$", caretBeginOffset: 8)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345.67|$|  ->  12,345.67|$
  func test10() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 9, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12,345.67$", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
}
