//
//  SumTextInputFormatterWith2SymbolsPrefixBy1SymbolErasingTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 20.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWith2SymbolsPrefixBy1SymbolErasingTests: XCTestCase {
  
  private let formatter = SumTextInputFormatter(textPattern: "$ #,###.##")
  
  // $ 12.3|4|  ->  $ 12.3|
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "$ 12.34",
      range: NSRange(location: 6, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "$ 12.3", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $ 12.|3|  ->  $ 12.|
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "$ 12.3",
      range: NSRange(location: 5, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "$ 12.", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $ 12|.|  ->  $ 12|
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "$ 12.",
      range: NSRange(location: 4, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "$ 12", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $ 1|2|  ->  $ 1|
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "$ 12",
      range: NSRange(location: 3, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "$ 1", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $ |1|  ->  "|"
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "$ 1",
      range: NSRange(location: 2, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
}
