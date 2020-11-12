//
//  SumTextInputFormatterWithPrefix3SymbolInsertTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 13.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputtFormaterWithPrefix3SymbolnsertTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "$#,###.##")
  
  // |$12,345.67  ->  $80,9|12,345.67
  func test1() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 0, length: 0),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "$80,912,345.67", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $|12,345.67  ->  $80,9|12,345.67
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 1, length: 0),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "$80,912,345.67", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $1|2,345.67  ->  $18,09|2,345.67
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 2, length: 0),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "$18,092,345.67", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12|,345.67  ->  $12,809|,345.67
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 3, length: 0),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "$12,809,345.67", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,|345.67  ->  $12,809|,345.67
//  func test5() { // to_think
//    let actualResult = formatter.formatInput(
//      currentText: "$12,345.67",
//      range: NSRange(location: 4, length: 0),
//      replacementString: "809")
//    let expectedResult = FormattedTextValue(formattedText: "$12,809,345.67", caretBeginOffset: 7)
//    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
//  }
  
  // $12,3|45.67  ->  $12,380,9|45.67
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 5, length: 0),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "$12,380,945.67", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,34|5.67  ->  $12,348,09|5.67
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 6, length: 0),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "$12,348,095.67", caretBeginOffset: 10)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,345|.67  ->  $12,345,809|.67'
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 7, length: 0),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "$12,345,809.67", caretBeginOffset: 11)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,345.|67  ->  $12,345.80|
  func test9() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 8, length: 0),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "$12,345.80", caretBeginOffset: 10)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,345.6|7  ->  $12,345.68|
  func test10() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 9, length: 0),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "$12,345.68", caretBeginOffset: 10)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,345.67|  ->  $12,345.67|
  func test11() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.67",
      range: NSRange(location: 10, length: 0),
      replacementString: "809")
    let expectedResult = FormattedTextValue(formattedText: "$12,345.67", caretBeginOffset: 10)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
}
