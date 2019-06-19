//
//  SumTextInputFormatterWithSuffixReplaceWith0Tests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 12.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWithSuffixReplaceWith0Tests: XCTestCase {
  
  private let formatter = SumTextInputFormatter(textPattern: "#,###.##$")

  // |1|2,345.67$  ->  |2,345.67$
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 0, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "2,345.67$", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1|2|,345.67$  ->  10|,345.67$
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 1, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "10,345.67$", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // "|" ->  0|$
  func test3() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: "",
      range: NSRange(location: 0, length: 0),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "0$", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 0|$  ->  0.|$
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "0$",
      range: NSRange(location: 1, length: 0),
      replacementString: ".")
    let expectedResult = FormattedTextValue(formattedText: "0.$", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 0.|$  ->  0.0|$
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "0.$",
      range: NSRange(location: 2, length: 0),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "0.0$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 0.0|$  ->  0.00|$
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "0.0$",
      range: NSRange(location: 3, length: 0),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "0.00$", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // |0.0$  ->  0|.0$
  func test7() { // #to_think
    let actualResult = formatter.formatInput(
      currentText: "0.0$",
      range: NSRange(location: 0, length: 0),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "0.0$", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 0|.0$  ->  1|.0$
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "0.0$",
      range: NSRange(location: 1, length: 0),
      replacementString: "1")
    let expectedResult = FormattedTextValue(formattedText: "1.0$", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12|,|345.67$  ->  120|,345.67$
  func test9() { // #to_think
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 2, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "120,345.67$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345|.|67$  ->  12,345,0|67$
  func test10() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 6, length: 1),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "12,345,067$", caretBeginOffset: 8)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }

}
