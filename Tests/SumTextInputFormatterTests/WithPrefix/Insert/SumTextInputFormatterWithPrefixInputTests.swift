//
//  SumTextInputFormatterWithPrefixInputTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 15.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWithPrefixInputTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "$#,###.##")
  
  // "|"  ->  $1|
  func test1() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: "",
      range: NSRange(location: 0, length: 0),
      replacementString: "1")
    let expectedResult = FormattedTextValue(formattedText: "$1", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $1|  ->  $12|
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "$1",
      range: NSRange(location: 2, length: 0),
      replacementString: "2")
    let expectedResult = FormattedTextValue(formattedText: "$12", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12|  ->  $123|
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "$12",
      range: NSRange(location: 3, length: 0),
      replacementString: "3")
    let expectedResult = FormattedTextValue(formattedText: "$123", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $123|  ->  $1,234|
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "$123",
      range: NSRange(location: 4, length: 0),
      replacementString: "4")
    let expectedResult = FormattedTextValue(formattedText: "$1,234", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $1,234|  ->  $12,345|
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "$1,234",
      range: NSRange(location: 6, length: 0),
      replacementString: "5")
    let expectedResult = FormattedTextValue(formattedText: "$12,345", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,345|  ->  $12,345.|
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345",
      range: NSRange(location: 7, length: 0),
      replacementString: ".")
    let expectedResult = FormattedTextValue(formattedText: "$12,345.", caretBeginOffset: 8)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,345.|  ->  $12.345.6|
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.",
      range: NSRange(location: 8, length: 0),
      replacementString: "6")
    let expectedResult = FormattedTextValue(formattedText: "$12,345.6", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // $12,345.6|  ->  $12,345.67|
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "$12,345.6",
      range: NSRange(location: 9, length: 0),
      replacementString: "7")
    let expectedResult = FormattedTextValue(formattedText: "$12,345.67", caretBeginOffset: 10)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }

}
