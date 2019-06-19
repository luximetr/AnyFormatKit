//
//  SumTextInputFormatterReplace3SymbolsTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 15.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterReplace3SymbolsTests: XCTestCase {
 
  let formatter = SumTextInputFormatter(textPattern: "#,###.##")
 
  // |12,|345.67  ->  809|,345.67
  func test1() { // #to_think
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 0, length: 3),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "809,345.67", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1|2,3|45.67  ->  180,9|45.67
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 1, length: 3),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "180,945.67", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12|,34|5.67  ->  128,09|5.67
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 2, length: 3),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "128,095.67", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,|345|.67  ->  12,809|.67
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 3, length: 3),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "12,809.67", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,3|45.|67  ->  12,380,9|67
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 4, length: 3),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "12,380,967", caretBeginOffset: 8)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,34|5.6|7  ->  12,348,09|7
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 5, length: 3),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "12,348,097", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345|.67|  ->  12,345,809|
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.67",
      range: NSRange(location: 6, length: 3),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "12,345,809", caretBeginOffset: 10)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
}
