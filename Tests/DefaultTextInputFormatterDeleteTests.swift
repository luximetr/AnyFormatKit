//
//  DefaultTextInputFormatterDeleteTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 09.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class DefaultTextInputFormatterDeleteTests: XCTestCase {
  
  private let formatter = DefaultTextInputFormatter(textPattern: "## ## ##")
  
  func test12_34to12_3() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 4, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12 3", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_3to12() {
    let actualResult = formatter.formatInput(
      currentText: "12 3",
      range: NSRange(location: 3, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12to1() {
    let actualResult = formatter.formatInput(
      currentText: "12",
      range: NSRange(location: 1, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test1to_() {
    let actualResult = formatter.formatInput(
      currentText: "1",
      range: NSRange(location: 0, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_34to12_4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 3, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12 4", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_I34to12I_34() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 2, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12 34", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_34to13_4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "13 4", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_34to23_4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "23 4", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_34to12() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 3, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_34to34() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "34", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_34to14() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 3),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "14", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_34to1() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 4),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test1I2_I34to13_4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "13 4", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12I_3I4to12_4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 2, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12 4", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_34to4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 4),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "4", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  func test12_34to_() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 5),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
}
