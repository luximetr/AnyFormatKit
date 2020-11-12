//
//  SumTextInputFormatterWithSuffixInsert2SymbolsTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 13.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWithSuffixInsert2SymbolsTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "#,###.##$")
  
  // |12,345.67$  ->  8,9|12,345.67$
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 0, length: 0),
      replacementString: "89")
    let expectedResult = FormattedTextValue(formattedText: "8,912,345.67$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1|2,345.67$  ->  1,89|2,345.67$
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 1, length: 0),
      replacementString: "89")
    let expectedResult = FormattedTextValue(formattedText: "1,892,345.67$", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12|,345.67$  ->  1,289|,345.67$
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 2, length: 0),
      replacementString: "89")
    let expectedResult = FormattedTextValue(formattedText: "1,289,345.67$", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,|345.67$  ->  1,289,|345.67$
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 3, length: 0),
      replacementString: "89")
    let expectedResult = FormattedTextValue(formattedText: "1,289,345.67$", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,3|45.67$  ->  1,238,9|45.67$
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 4, length: 0),
      replacementString: "89")
    let expectedResult = FormattedTextValue(formattedText: "1,238,945.67$", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,34|5.67$  ->  1,234,89|5.67$
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 5, length: 0),
      replacementString: "89")
    let expectedResult = FormattedTextValue(formattedText: "1,234,895.67$", caretBeginOffset: 8)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345|.67$  ->  1,234,589|.67$
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 6, length: 0),
      replacementString: "89")
    let expectedResult = FormattedTextValue(formattedText: "1,234,589.67$", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345.|67$  ->  12,345.89|$
  func test8() { // to_fix
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 7, length: 0),
      replacementString: "89")
    let expectedResult = FormattedTextValue(formattedText: "12,345.89$", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345.6|7$  ->  12,345.68|$
  func test9() { // to_fix
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 8, length: 0),
      replacementString: "89")
    let expectedResult = FormattedTextValue(formattedText: "12,345.68$", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345.67|$  ->  12,345.67|$
  func test10() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 9, length: 0),
      replacementString: "89")
    let expectedResult = FormattedTextValue(formattedText: "12,345.67$", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345.67$|  ->  12,345.67$|
  func test11() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67$",
      range: NSRange(location: 10, length: 0),
      replacementString: "89")
    let expectedResult = FormattedTextValue(formattedText: "12,345.67$", caretBeginOffset: 10)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }

}
