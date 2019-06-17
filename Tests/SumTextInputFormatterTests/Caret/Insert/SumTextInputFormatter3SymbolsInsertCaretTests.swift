//
//  SumTextInputFormatter3SymbolsInsertCaretTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 17.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatter3SymbolsInsertCaretTests: XCTestCase {
  
  private let formatter = SumTextInputFormatter(textPattern: "#,###.##")
  
  // |1,111.11  ->  9,99|1,111.11
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "1,111.11",
      range: NSRange(location: 0, length: 0),
      replacementString: "999").caretBeginOffset
    let expectedResult = 4
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1|,111.11  ->  1,999|,111.11
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "1,111.11",
      range: NSRange(location: 1, length: 0),
      replacementString: "999").caretBeginOffset
    let expectedResult = 5
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1,|111.11  ->  1,999|,111.11
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "1,111.11",
      range: NSRange(location: 2, length: 0),
      replacementString: "999").caretBeginOffset
    let expectedResult = 5
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1,1|11.11  ->  1,199,9|11.11
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "1,111.11",
      range: NSRange(location: 3, length: 0),
      replacementString: "999").caretBeginOffset
    let expectedResult = 7
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1,11|1.11  ->  1,119,99|1.11
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "1,111.11",
      range: NSRange(location: 4, length: 0),
      replacementString: "999").caretBeginOffset
    let expectedResult = 8
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1,111|.11  ->  1,111,999|.11
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "1,111.11",
      range: NSRange(location: 5, length: 0),
      replacementString: "999").caretBeginOffset
    let expectedResult = 9
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1,111.|11  ->  1,111.99|
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "1,111.11",
      range: NSRange(location: 6, length: 0),
      replacementString: "999").caretBeginOffset
    let expectedResult = 8
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1,111.1|1  ->  1,111.99|
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "1,111.11",
      range: NSRange(location: 7, length: 0),
      replacementString: "999").caretBeginOffset
    let expectedResult = 8
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1,111.11|  ->  1,111.99|
  func test9() {
    let actualResult = formatter.formatInput(
      currentText: "1,111.11",
      range: NSRange(location: 8, length: 0),
      replacementString: "999").caretBeginOffset
    let expectedResult = 8
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
}
