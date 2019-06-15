//
//  SumTextInputFormatterInputTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 10.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterInputTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "#,###.##")
  
  // ""  ->  1
  func test_to1() {
    let actualResult = formatter.formatInput(
      currentText: "",
      range: NSRange(location: 0, length: 0),
      replacementString: "1")
    let expectedResult = FormattedTextValue(formattedText: "1", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1  ->  12
  func test1to12() {
    let actualResult = formatter.formatInput(
      currentText: "1",
      range: NSRange(location: 1, length: 0),
      replacementString: "2")
    let expectedResult = FormattedTextValue(formattedText: "12", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12  ->  123
  func test12to123() {
    let actualResult = formatter.formatInput(
      currentText: "12",
      range: NSRange(location: 2, length: 0),
      replacementString: "3")
    let expectedResult = FormattedTextValue(formattedText: "123", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 123  ->  1,234  c = ,
  func test123to1c234() {
    let actualResult = formatter.formatInput(
      currentText: "123",
      range: NSRange(location: 3, length: 0),
      replacementString: "4")
    let expectedResult = FormattedTextValue(formattedText: "1,234", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1,234  ->  12,345
  func test1c234to12c345() {
    let actualResult = formatter.formatInput(
      currentText: "1,234",
      range: NSRange(location: 5, length: 0),
      replacementString: "5")
    let expectedResult = FormattedTextValue(formattedText: "12,345", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,345  ->  123,456
  func test12c345to123c456() {
    let actualResult = formatter.formatInput(
      currentText: "12,345",
      range: NSRange(location: 6, length: 0),
      replacementString: "6")
    let expectedResult = FormattedTextValue(formattedText: "123,456", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 123,456  ->  1,234,567
  func test123c456to1c234c567() {
    let actualResult = formatter.formatInput(
      currentText: "123,456",
      range: NSRange(location: 7, length: 0),
      replacementString: "7")
    let expectedResult = FormattedTextValue(formattedText: "1,234,567", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1,234  ->  1,234.  p = .
  func test1c234to1c234p() {
    let actualResult = formatter.formatInput(
      currentText: "1,234",
      range: NSRange(location: 5, length: 0),
      replacementString: ".")
    let expectedResult = FormattedTextValue(formattedText: "1,234.", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1,234.  ->  1,234.5
  func test1c234pto1c234p5() {
    let actualResult = formatter.formatInput(
      currentText: "1,234.",
      range: NSRange(location: 6, length: 0),
      replacementString: "5")
    let expectedResult = FormattedTextValue(formattedText: "1,234.5", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1,234.5  ->  1,234.56
  func test1c234p5to1c234p56() {
    let actualResult = formatter.formatInput(
      currentText: "1,234.5",
      range: NSRange(location: 7, length: 0),
      replacementString: "6")
    let expectedResult = FormattedTextValue(formattedText: "1,234.56", caretBeginOffset: 8)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // ""  ->  .
  func test_toP() {
    let actualResult = formatter.formatInput(
      currentText: "",
      range: NSRange(location: 0, length: 0),
      replacementString: ".")
    let expectedResult = FormattedTextValue(formattedText: "1", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // .  ->  .5
  func testPtoP5() {
    let actualResult = formatter.formatInput(
      currentText: ".",
      range: NSRange(location: 1, length: 0),
      replacementString: "5")
    let expectedResult = FormattedTextValue(formattedText: ".5", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // .5  ->  .56
  func testP5toP56() {
    let actualResult = formatter.formatInput(
      currentText: ".5",
      range: NSRange(location: 2, length: 0),
      replacementString: "6")
    let expectedResult = FormattedTextValue(formattedText: ".56", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // .56  ->  3.56
  func testP56to3p56() {
    let actualResult = formatter.formatInput(
      currentText: ".56",
      range: NSRange(location: 0, length: 0),
      replacementString: "3")
    let expectedResult = FormattedTextValue(formattedText: "3.56", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 3.56  ->  23.56
  func test3p56to23p56() {
    let actualResult = formatter.formatInput(
      currentText: "3.56",
      range: NSRange(location: 0, length: 0),
      replacementString: "2")
    let expectedResult = FormattedTextValue(formattedText: "23.56", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 23.56  ->  123.56
  func test23p56to123p56() {
    let actualResult = formatter.formatInput(
      currentText: "23.56",
      range: NSRange(location: 0, length: 0),
      replacementString: "1")
    let expectedResult = FormattedTextValue(formattedText: "123.56", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 123.56  ->  1,234.56
  func test123p56to1c234p56() {
    let actualResult = formatter.formatInput(
      currentText: "123.56",
      range: NSRange(location: 3, length: 0),
      replacementString: "4")
    let expectedResult = FormattedTextValue(formattedText: "1,234.56", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }

}
