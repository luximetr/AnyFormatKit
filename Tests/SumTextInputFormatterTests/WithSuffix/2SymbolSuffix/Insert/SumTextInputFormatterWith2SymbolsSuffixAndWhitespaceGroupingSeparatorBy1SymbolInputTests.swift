//
//  SumTextInputFormatterWith2SymbolsSuffixAndWhitespaceGroupingSeparatorBy1SymbolInputTests.swift
//  AnyFormatKitTests
//
//  Created by Timur Shafigullin on 05/12/2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWith2SymbolsSuffixAndWhitespaceGroupingSeparatorBy1SymbolInputTests: XCTestCase {

    private let formatter = SumTextInputFormatter(textPattern: "# ###.## $")

    // "|1 000 $"  ->  1|1 000 $
    func test1() {
      let actualResult = formatter.formatInput(
        currentText: "1 000 $",
        range: NSRange(location: 0, length: 0),
        replacementString: "1")
      let expectedResult = FormattedTextValue(formattedText: "11 000 $", caretBeginOffset: 1)
      XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }

    // 1|1 000 $  ->  12|1 000 $
    func test2() {
      let actualResult = formatter.formatInput(
        currentText: "11 000 $",
        range: NSRange(location: 1, length: 0),
        replacementString: "2")
      let expectedResult = FormattedTextValue(formattedText: "121 000 $", caretBeginOffset: 2)
      XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }

    // 12 000 $  ->  12 000.| $
    func test3() {
      let actualResult = formatter.formatInput(
        currentText: "12 000 $",
        range: NSRange(location: 6, length: 0),
        replacementString: ".")
      let expectedResult = FormattedTextValue(formattedText: "12 000. $", caretBeginOffset: 7)
      XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }

    // 12 000.| $  ->  12 000.3| $
    func test4() {
      let actualResult = formatter.formatInput(
        currentText: "12 000. $",
        range: NSRange(location: 7, length: 0),
        replacementString: "3")
      let expectedResult = FormattedTextValue(formattedText: "12 000.3 $", caretBeginOffset: 8)
      XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }

    // 12 000.3| $  ->  12 000.34| $
    func test5() {
      let actualResult = formatter.formatInput(
        currentText: "12 000.3 $",
        range: NSRange(location: 8, length: 0),
        replacementString: "4")
      let expectedResult = FormattedTextValue(formattedText: "12 000.34 $", caretBeginOffset: 9)
      XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
}
