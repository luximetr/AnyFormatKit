//
//  SumTextInputFormatterWithSuffixReplace2SymbolsTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 11.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWithSuffixReplace2SymbolsTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "#,###.##$")
  
  // |12|,345.67$  ->  9|,345.67$
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 0, length: 2),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "9,345.67$", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1|2,|345.67$  ->  19,|345.67$
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 1, length: 2),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "19,345.67$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12|,3|45.67$  ->  12,9|45.67$
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 2, length: 2),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "12,945.67$", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,|34|5.67$  ->  1,29|5.67$
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 3, length: 2),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "1,295.67$", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,3|45|.67$  ->  1,239|.67$
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 4, length: 2),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "1,239.67$", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,34|5.|67$  ->  1,234,9|67$
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 5, length: 2),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "1,234,967$", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345|.6|7$  ->  1,234,59|7$
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 6, length: 2),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "1,234,597$", caretBeginOffset: 8)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345.|67|$  ->  12,345.9|$
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 7, length: 2),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "12,345.9$", caretBeginOffset: 8)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345.6|7$|  ->  12,345.69|$
  func test9() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 8, length: 2),
      replacementString: "9")
    let expectedResult = FormattedTextValue(formattedText: "12,345.69$", caretBeginOffset: 10)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
}
