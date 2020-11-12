//
//  SumTextInputFormatterWith2SymbolsSuffixBy1SymbolInputTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 20.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWith2SymbolsSuffixBy1SymbolInputTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "#,###.## $")

  // "|"  ->  1| $
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "",
      range: NSRange(location: 0, length: 0),
      replacementString: "1")
    let expectedResult = FormattedTextValue(formattedText: "1 $", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1| $  ->  12| $
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "1 $",
      range: NSRange(location: 1, length: 0),
      replacementString: "2")
    let expectedResult = FormattedTextValue(formattedText: "12 $", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12| $  ->  12.| $
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "12 $",
      range: NSRange(location: 2, length: 0),
      replacementString: ".")
    let expectedResult = FormattedTextValue(formattedText: "12. $", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12.| $  ->  12.3 $
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "12. $",
      range: NSRange(location: 3, length: 0),
      replacementString: "3")
    let expectedResult = FormattedTextValue(formattedText: "12.3 $", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12.3| $  ->  12.34| $
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "12.3 $",
      range: NSRange(location: 4, length: 0),
      replacementString: "4")
    let expectedResult = FormattedTextValue(formattedText: "12.34 $", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
}
