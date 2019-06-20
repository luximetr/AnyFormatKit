//
//  SumTextInputFormatterWith2SymbolsPrefixInputTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 20.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWith2SymbolsPrefixInputTests: XCTestCase {
  
  private let formatter = SumTextInputFormatter(textPattern: "$ #.###,##")
  
  // "|"  ->  $ 1|
//  func test1() {
//    let actualResult = formatter.formatInput(
//      currentText: "",
//      range: NSRange(location: 0, length: 0),
//      replacementString: "1")
//    let expectedResult = FormattedTextValue(formattedText: "$ 1", caretBeginOffset: 3)
//    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
//  }
  
  // $ 1|  ->  $ 1.
//  func test2() {
//    let actualResult = formatter.formatInput(
//      currentText: "$ 1",
//      range: NSRange(location: 3, length: 0),
//      replacementString: ".")
//    let expectedResult = FormattedTextValue(formattedText: "$ 1.", caretBeginOffset: 4)
//    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
//  }
  
  // $ 1.|  ->  $ 1.2
//  func test3() {
//    let actualResult = formatter.formatInput(
//      currentText: "$ 1.",
//      range: NSRange(location: 4, length: 0),
//      replacementString: "2")
//    let expectedResult = FormattedTextValue(formattedText: "$ 1.2", caretBeginOffset: 5)
//    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
//  }
}
