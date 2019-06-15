//
//  SumTextInputFormatterWithSuffixReplace1SymbolTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 11.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWithSuffixReplace1SymbolTests: XCTestCase {
  
  private let formatter = SumTextInputFormatter(textPattern: "#,###.##$")
  
  // |1|2,345.67$  ->  9|2,345.67$
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 0, length: 1),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "92,345.67$", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1|2|,345.67$  ->  19|,345.67$
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 1, length: 1),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "19,345.67$", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12|,|345.67$  ->  129|,345.67$
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 2, length: 1),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "129,345.67$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,|3|45.67$  ->  12,9|45.67$
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 3, length: 1),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "12,945.67$", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,3|4|5.67$  ->  12,39|5.67$
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 4, length: 1),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "12,395.67$", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,34|5|.67$  ->  12,349|.67$
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 5, length: 1),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "12,349.67$", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,345|.|67$  ->  12,345,9|67$
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 6, length: 1),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "12,345,967$", caretBeginOffset: 8)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,345.|6|7$  ->  12,345.9|7$
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 7, length: 1),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "12,345.97$", caretBeginOffset: 8)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,345.6|7|$  ->  12,345.69|$
  func test9() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 8, length: 1),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "12,345.69$", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,345.67|$|  ->  12,345.67|$
  func test10() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 9, length: 1),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "12,345.67$", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
}
