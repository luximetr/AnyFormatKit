//
//  DefaultTextInputFormatter3SymbolsReplace.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 10.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class DefaultTextInputFormatter3SymbolsReplace: XCTestCase {
    
    private let formatter = DefaultTextInputFormatter(textPattern: "## ## ##")
    
    // MARK: - 1 symbol replace
    
    // |1|2 34  ->  56 7|2 34
    func testI1I2_34to56_7I2_34() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 0, length: 1),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "56 72 34", caretBeginOffset: 4)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 1|2| 34  ->  15 67| 34
    func test1I2I_34to15_67I_34() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 1, length: 1),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "15 67 34", caretBeginOffset: 5)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12| |34  ->  12 56 7|3
    func test12I_I34to12_56_7I3() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 2, length: 1),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "12 56 73", caretBeginOffset: 7)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12 |3|4  ->  12 56 7|4
    func test12_I3I4to12_56_7I4() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 3, length: 1),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "12 56 74", caretBeginOffset: 7)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12 3|4|  ->  12 35 67|
    func test12_3I4Ito12_35_67I() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 4, length: 1),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "12 35 67", caretBeginOffset: 8)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // MARK: - 2 symbols replace
    
    // |12| 34  -> 56 7|3 4
    func testI12I_34to56_7I3_4() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 0, length: 2),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "56 73 4", caretBeginOffset: 4)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 1|2 |34  -> 15 67| 34
    func test1I2_I34to15_67I_34() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 1, length: 2),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "15 67 34", caretBeginOffset: 5)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12| 3|4  -> 12 56 7|4
    func test12I_3I4to12_56_7I4() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 2, length: 2),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "12 56 74", caretBeginOffset: 7)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12 |34|  -> 12 56 7|
    func test12_I34Ito12_56_7I() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 3, length: 2),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "12 56 7", caretBeginOffset: 7)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // MARK: - 3 symbols replace
    
    // |12 |34  -> 56 7|3 4
    func testI12_I34to56_7I3_4() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 0, length: 3),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "56 73 4", caretBeginOffset: 4)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 1|2 3|4  -> 15 67| 4
    func test1I2_3I4to15_67I_4() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 1, length: 3),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "15 67 4", caretBeginOffset: 5)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12| 34|  -> 12 56 7|
    func test12I_34Ito12_56_7I() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 2, length: 3),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "12 56 7", caretBeginOffset: 7)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // MARK: - 4 symbols replace
    
    // |12 3|4  -> 56 7|4
    func testI12_3I4to56_7I4() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 0, length: 4),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "56 74", caretBeginOffset: 4)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 1|2 34|  -> 15 67|
    func test1I2_34Ito15_67I_4() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 1, length: 4),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "15 67", caretBeginOffset: 5)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // MARK: - 5 symbols replace
    
    // |12 34|  -> 56 7|
    func testI12_34Ito56_7I() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 0, length: 5),
            replacementString: "567")
        let expectedResult = FormattedTextValue(formattedText: "56 7", caretBeginOffset: 4)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 😀|😎 😂|👍  -> 😀🤔| 👍
    func test10() {
        let result = formatter.formatInput(
            currentText: "😀😎 😂👍",
            range: NSRange(location: 2, length: 5),
            replacementString: "🤔"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀🤔 👍", caretBeginOffset: 4)
        XCTAssertEqual(result, expectedResult)
    }
    
}
