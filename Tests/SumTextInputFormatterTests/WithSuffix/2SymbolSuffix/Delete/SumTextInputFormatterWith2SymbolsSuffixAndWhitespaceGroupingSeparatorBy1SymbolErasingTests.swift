//
//  SumTextInputFormatterWith2SymbolsSuffixAndWhitespaceGroupingSeparatorBy1SymbolErasingTests.swift
//  AnyFormatKitTests
//
//  Created by Timur Shafigullin on 25/11/2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWith2SymbolsSuffixAndWhitespaceGroupingSeparatorBy1SymbolErasingTests: XCTestCase {

    private let formatter = SumTextInputFormatter(textPattern: "# ###.## $")

    // 12 345.67 |$|  ->  12 345.67| $
    func test1() {
      let actualResult = formatter.formatInput(
        currentText: "12 345.67 $",
        range: NSRange(location: 10, length: 1),
        replacementString: "")
      let expectedResult = FormattedTextValue(formattedText: "12 345.67 $", caretBeginOffset: 9)
      XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }

    // 12 345.67| |$  ->  12 345.67| $
    func test2() {
      let actualResult = formatter.formatInput(
        currentText: "12 345.67 $",
        range: NSRange(location: 9, length: 1),
        replacementString: "")
      let expectedResult = FormattedTextValue(formattedText: "12 345.67 $", caretBeginOffset: 9)
      XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }

    // 12 345.6|7| $  ->  12 345.6| $
    func test3() {
      let actualResult = formatter.formatInput(
        currentText: "12 345.67 $",
        range: NSRange(location: 8, length: 1),
        replacementString: "")
      let expectedResult = FormattedTextValue(formattedText: "12 345.6 $", caretBeginOffset: 8)
      XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }

    // 12 345.|6| $  ->  12 345.| $
    func test4() {
      let actualResult = formatter.formatInput(
        currentText: "12 345.6 $",
        range: NSRange(location: 7, length: 1),
        replacementString: "")
      let expectedResult = FormattedTextValue(formattedText: "12 345. $", caretBeginOffset: 7)
      XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }

    // 12 345|.| $  ->  12 345| $
    func test5() {
      let actualResult = formatter.formatInput(
        currentText: "12 345. $",
        range: NSRange(location: 6, length: 1),
        replacementString: "")
      let expectedResult = FormattedTextValue(formattedText: "12 345 $", caretBeginOffset: 6)
      XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }

    // 12 34|5| $  ->  1 234| $
    func test6() {
      let actualResult = formatter.formatInput(
        currentText: "12 345 $",
        range: NSRange(location: 5, length: 1),
        replacementString: "")
      let expectedResult = FormattedTextValue(formattedText: "1 234 $", caretBeginOffset: 5)
      XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }

    // 1 23|4| $  ->  123| $
    func test7() {
      let actualResult = formatter.formatInput(
        currentText: "1 234 $",
        range: NSRange(location: 4, length: 1),
        replacementString: "")
      let expectedResult = FormattedTextValue(formattedText: "123 $", caretBeginOffset: 3)
      XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
}
