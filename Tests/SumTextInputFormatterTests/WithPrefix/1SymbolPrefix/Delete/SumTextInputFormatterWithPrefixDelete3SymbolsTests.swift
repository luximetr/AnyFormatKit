//
//  SumTextInputFormatterWithPrefixDelete3SymbolsTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 15.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWithPrefixDelete3SymbolsTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "$#,###.##")
  
  // |$12|,345.67  ->  |$345.67
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 0, length: 3),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "$345.67", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $|12,|345.67  ->  $|345.67
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 1, length: 3),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "$345.67", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $1|2,3|45.67  ->  $1|45.67
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 2, length: 3),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "$145.67", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12|,34|5.67  ->  $12|5.67
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 3, length: 3),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "$125.67", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,|345|.67  ->  $12|.67
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 4, length: 3),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "$12.67", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,3|45.|67  ->  $12,3|67
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 5, length: 3),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "$12,367", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,34|5.6|7  ->  $12,34|7
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 6, length: 3),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "$12,347", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,345|.67|  ->  $12,345|
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 7, length: 3),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "$12,345", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
}
