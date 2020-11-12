//
//  SumTextInputFormatterWithSuffixInputTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 10.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWithSuffixInputTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "#,###.##$")
  
  // "|"  ->  1|$
  func testIto1I$() {
    let actualResult = formatter.formatInput(
      currentText: "",
      range: NSRange(location: 0, length: 0),
      replacementString: "1")
    let expectedResult = FormattedTextValue(formattedText: "1$", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1|$  ->  1.|$
  func test1I$to1pI$() {
    let actualResult = formatter.formatInput(
      currentText: "1$",
      range: NSRange(location: 1, length: 0),
      replacementString: ".")
    let expectedResult = FormattedTextValue(formattedText: "1.$", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1.|$  ->  1.5|$
  func test1pI$to1p5I$() {
    let actualResult = formatter.formatInput(
      currentText: "1.$",
      range: NSRange(location: 2, length: 0),
      replacementString: "5")
    let expectedResult = FormattedTextValue(formattedText: "1.5$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1.5|$  ->  1.56|$
  func test1p5I$to1p56I$() {
    let actualResult = formatter.formatInput(
      currentText: "1.5$",
      range: NSRange(location: 3, length: 0),
      replacementString: "6")
    let expectedResult = FormattedTextValue(formattedText: "1.56$", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1|.56$  ->  12|.56$
  func test1Ip56$to12Ip56$() {
    let actualResult = formatter.formatInput(
      currentText: "1.56$",
      range: NSRange(location: 1, length: 0),
      replacementString: "2")
    let expectedResult = FormattedTextValue(formattedText: "12.56$", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12|.56$  ->  123|.56$
  func test12Ip56$to123Ip56$() {
    let actualResult = formatter.formatInput(
      currentText: "12.56$",
      range: NSRange(location: 2, length: 0),
      replacementString: "3")
    let expectedResult = FormattedTextValue(formattedText: "123.56$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 123|.56$  ->  1,234|.56$
  func test123Ip56$to1c234Ip56$() {
    let actualResult = formatter.formatInput(
      currentText: "123.56$",
      range: NSRange(location: 3, length: 0),
      replacementString: "4")
    let expectedResult = FormattedTextValue(formattedText: "1,234.56$", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // "|"  ->  .|$
  func testItopI$() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: "",
      range: NSRange(location: 0, length: 0),
      replacementString: ".")
    let expectedResult = FormattedTextValue(formattedText: ".$", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // .|$  ->  .5|$
  func testpI$toP5I$() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: ".$",
      range: NSRange(location: 1, length: 0),
      replacementString: "5")
    let expectedResult = FormattedTextValue(formattedText: ".5$", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // .5|$  ->  .56|$
  func testP5I$toP56I$() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: ".5$",
      range: NSRange(location: 2, length: 0),
      replacementString: "6")
    let expectedResult = FormattedTextValue(formattedText: ".56$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // .|56$  ->  .4|5$
  func testPI56$toP4I5$() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: ".56$",
      range: NSRange(location: 1, length: 0),
      replacementString: "4")
    let expectedResult = FormattedTextValue(formattedText: ".45$", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // .5|6$  ->  .50|$
  func testP5I6$ToP50I$() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: ".56$",
      range: NSRange(location: 2, length: 0),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: ".50$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // .56|$  ->  .56|$
  func testP56I$toP56I$() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: ".56$",
      range: NSRange(location: 3, length: 0),
      replacementString: "7")
    let expectedResult = FormattedTextValue(formattedText: ".56$", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // |.5$  ->  1|.5$
  func testIP5$to1Ip5$() {
    let actualResult = formatter.formatInput(
      currentText: ".5$",
      range: NSRange(location: 0, length: 0),
      replacementString: "1")
    let expectedResult = FormattedTextValue(formattedText: "1.5$", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
}
