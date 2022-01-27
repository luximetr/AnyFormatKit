//
//  DefaultTextInputFormatterDeleteTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 09.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class DefaultTextInputFormatterDeleteTests: XCTestCase {
  
  private let formatter = DefaultTextInputFormatter(textPattern: "## ## ##")
  
    // 12 3|4|  ->  12 3|
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 4, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12 3", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
    // 12 |3|  ->  12|
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "12 3",
      range: NSRange(location: 3, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
    // 1|2|  ->  1|
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "12",
      range: NSRange(location: 1, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "1",
      range: NSRange(location: 0, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 3, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12 4", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 2, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12 34", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "13 4", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
    // |1|2 34  ->  |23 4
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "23 4", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test9() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 3, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test10() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "34", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test11() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 3),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "14", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test12() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 4),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test13() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "13 4", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  func test14() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 2, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12 4", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
    // |12 3|4  ->  |4
  func test15() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 4),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "4", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
    // |12 34|  ->  |
  func test16() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 5),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
    
    // 1|2|  ->  1|
    func test17() {
        let actualResult = formatter.formatInput(
          currentText: "12",
          range: NSRange(location: 1, length: 1),
          replacementString: "")
        let expectedResult = FormattedTextValue(formattedText: "1", caretBeginOffset: 1)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 😊👍 🙈😡 😱🌚|  ->  😊👍 🙈😡 😱|
    func test18() {
        let actualResult = formatter.formatInput(
          currentText: "😊👍 🙈😡 😱🌚",
          range: NSRange(location: 12, length: 2),
          replacementString: "")
        let expectedResult = FormattedTextValue(formattedText: "😊👍 🙈😡 😱", caretBeginOffset: 12)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    func test19() {
        let actualResult = formatter.formatInput(
          currentText: "12 ##",
          range: NSRange(location: 4, length: 1),
          replacementString: "")
        let expectedResult = FormattedTextValue(formattedText: "12 #", caretBeginOffset: 4)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
}
