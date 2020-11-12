//
//  DefaultTextInputFormatter2SymbolsReplaceTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 09.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class DefaultTextInputFormatter2SymbolsReplaceTests: XCTestCase {

  private let formatter = DefaultTextInputFormatter(textPattern: "## ## ##")
  
  // MARK: - 1 Symbol replace
  
  // |1|2 34  ->  56| 23 4
  func testI1I2_34to56I_23_4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 1),
      replacementString: "56")
    let expectedResult = FormattedTextValue(formattedText: "56 23 4", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1|2| 34  ->  15 6|3 4
  func test1I2I_34to15_6I3_4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 1),
      replacementString: "56")
    let expectedResult = FormattedTextValue(formattedText: "15 63 4", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }

  // 12| |34  ->  12 56| 34
  func test12I_I34to12_56I_34() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 2, length: 1),
      replacementString: "56")
    let expectedResult = FormattedTextValue(formattedText: "12 56 34", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12 |3|4  ->  12 56| 4
  func test12_I3I4to12_56I_4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 3, length: 1),
      replacementString: "56")
    let expectedResult = FormattedTextValue(formattedText: "12 56 4", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12 3|4|  ->  12 35 6|
  func test12_3I4Ito12_35_6I() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 4, length: 1),
      replacementString: "56")
    let expectedResult = FormattedTextValue(formattedText: "12 35 6", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // MARK: - 2 Symbols replace
  
  // |12| 34  ->  56| 34
  func testI12I_34to56I_34() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 2),
      replacementString: "56")
    let expectedResult = FormattedTextValue(formattedText: "56 34", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1|2 |34  ->  15 6|3 4
  
  func test1I2_I34to15_6I3_4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 2),
      replacementString: "56")
    let expectedResult = FormattedTextValue(formattedText: "15 63 4", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12| 3|4  -> 12 56| 4
  
  func test12I_3I4to12_56I_4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 2, length: 2),
      replacementString: "56")
    let expectedResult = FormattedTextValue(formattedText: "12 56 4", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12 |34|  ->  12 56|
  func test12_I34Ito12_56I() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 3, length: 2),
      replacementString: "56")
    let expectedResult = FormattedTextValue(formattedText: "12 56", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // MARK: - 3 Symbols replace
  
  // |12 |34  -> 56| 34
  func testI12_I34to56I_34() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 3),
      replacementString: "56")
    let expectedResult = FormattedTextValue(formattedText: "56 34", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1|2 3|4  ->  15 6|4
  func test12_34to15_6I4() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 1, length: 3),
      replacementString: "56")
    let expectedResult = FormattedTextValue(formattedText: "15 64", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12| 34|  -> 12 56|
  func test12I_34Ito12_56I() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 2, length: 3),
      replacementString: "56")
    let expectedResult = FormattedTextValue(formattedText: "12 56", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
}
