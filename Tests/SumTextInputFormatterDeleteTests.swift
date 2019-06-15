//
//  SumTextInputFormatterDeleteTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 10.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterDeleteTests: XCTestCase {

  let formatter = SumTextInputFormatter(textPattern: "#,###.##")
  
  // 1,234.5|6|  ->  1,234.5|
  func test1c234p56to1c234p5() {
    let actualResult = formatter.formatInput(
      currentText: "1,234.56",
      range: NSRange(location: 7, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,234.5", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1,234.|5|  ->  1,234.|
  func test1c234p5to1c234() {
    let actualResult = formatter.formatInput(
      currentText: "1,234.5",
      range: NSRange(location: 6, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,234.", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1,234|.|  ->  1,234|
  func test1c234pTo1c234() {
    let actualResult = formatter.formatInput(
      currentText: "1,234.",
      range: NSRange(location: 5, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,234", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1,23|4|  ->  123|
  func test1c23I4Ito123I() {
    let actualResult = formatter.formatInput(
      currentText: "1,234",
      range: NSRange(location: 4, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "123", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // |1|,234  ->  |234
  func testI1Ic234toI234() {
    let actualResult = formatter.formatInput(
      currentText: "1,234",
      range: NSRange(location: 0, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "234", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // |1,|234  ->  |234
  func testI1cI234toI234() {
    let actualResult = formatter.formatInput(
      currentText: "1,234",
      range: NSRange(location: 0, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "234", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1,|2|34  ->  1|34
  func test1cI2I34to1I34() {
    let actualResult = formatter.formatInput(
      currentText: "1,234",
      range: NSRange(location: 2, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "134", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1,234|.|5  ->  12,34|5
  func test1c234p5to12c345() {
    let actualResult = formatter.formatInput(
      currentText: "1,234.5",
      range: NSRange(location: 5, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12,345", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12|,|345.6  ->  1|,345.6
  func test12c345p6to1c345p6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.6",
      range: NSRange(location: 2, length: 1),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,345.6", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // MARK: 2 symbols remove
  
  // |12|,345.6  ->  |345.6
  func testI12Ic345p6toI345p6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.6",
      range: NSRange(location: 0, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "345.6", caretBeginOffset: 0)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1|2,|345.6  ->  1|,345.6
  func test1I2cI345p6to1Ic345p6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.6",
      range: NSRange(location: 1, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,345.6", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12|,3|45.6  ->  1,2|45.6
  func test12Ic3I45p6to1c2I45p6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.6",
      range: NSRange(location: 2, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,245.6", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,|34|5.6  ->  12|5.6
  func test12cI34I5p6to12I5p6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.6",
      range: NSRange(location: 3, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "125.6", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,3|45|.6  ->  123|.6
  func test12c3I45Ip6to123Ip6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.6",
      range: NSRange(location: 4, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "123.6", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,34|5.|6  ->  1,234|.6
  func test12c34II5pI6to1c234Ip6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.6",
      range: NSRange(location: 5, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "1,234.6", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 12,345|.6|  ->  12,345|
  func test12c345Ip6Ito12c345I() {
    let actualResult = formatter.formatInput(
      currentText: "12,345.6",
      range: NSRange(location: 6, length: 2),
      replacementString: "")
    let expectedResult = FormattedTextValue(formattedText: "12,345", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }

}
