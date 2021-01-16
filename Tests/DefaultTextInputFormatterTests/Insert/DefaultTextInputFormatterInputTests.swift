//
//  DefaultTextInputFormatterInputTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 09.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
import AnyFormatKit

class DefaultTextInputFormatterInputTests: XCTestCase {
    
    private let formatter = DefaultTextInputFormatter(textPattern: "## ## ##")
    
    // "|"  ->  1|
    func test1() {
        let actualResult = formatter.formatInput(
            currentText: "",
            range: NSRange(location: 0, length: 0),
            replacementString: "1")
        let expectedResult = FormattedTextValue(formattedText: "1", caretBeginOffset: 1)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 1|  ->  12|
    func test2() {
        let actualResult = formatter.formatInput(
            currentText: "1",
            range: NSRange(location: 1, length: 0),
            replacementString: "2")
        let expectedResult = FormattedTextValue(formattedText: "12", caretBeginOffset: 2)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12|  ->  12 3|
    func test3() {
        let actualResult = formatter.formatInput(
            currentText: "12",
            range: NSRange(location: 2, length: 0),
            replacementString: "3")
        let expectedResult = FormattedTextValue(formattedText: "12 3", caretBeginOffset: 4)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12 3|  ->  12 34|
    func test4() {
        let actualResult = formatter.formatInput(
            currentText: "12 3",
            range: NSRange(location: 4, length: 0),
            replacementString: "4")
        let expectedResult = FormattedTextValue(formattedText: "12 34", caretBeginOffset: 5)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12 34|  ->  12 34 5|
    func test5() {
        let actualResult = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 5, length: 0),
            replacementString: "5")
        let expectedResult = FormattedTextValue(formattedText: "12 34 5", caretBeginOffset: 7)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12 34 5|  ->  12 34 56|
    func test6() {
        let actualResult = formatter.formatInput(
            currentText: "12 34 5",
            range: NSRange(location: 7, length: 0),
            replacementString: "6")
        let expectedResult = FormattedTextValue(formattedText: "12 34 56", caretBeginOffset: 8)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12 34 56|  ->  12 34 56|
    func test7() {
        let result = formatter.formatInput(
            currentText: "12 34 56",
            range: NSRange(location: 8, length: 0),
            replacementString: "7"
        )
        let expectedResult = FormattedTextValue(formattedText: "12 34 56", caretBeginOffset: 8)
        XCTAssertEqual(result, expectedResult)
    }
    
    // |12 3  ->  0|1 23
    func test8() {
        let actualResult = formatter.formatInput(
            currentText: "12 3",
            range: NSRange(location: 0, length: 0),
            replacementString: "0")
        let expectedResult = FormattedTextValue(formattedText: "01 23", caretBeginOffset: 1)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 1|2 3  ->  10| 23
    func test9() {
        let actualResult = formatter.formatInput(
            currentText: "12 3",
            range: NSRange(location: 1, length: 0),
            replacementString: "0")
        let expectedResult = FormattedTextValue(formattedText: "10 23", caretBeginOffset: 2)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12| 3  ->  12 0|3
    func test10() {
        let actualResult = formatter.formatInput(
            currentText: "12 3",
            range: NSRange(location: 2, length: 0),
            replacementString: "0")
        let expectedResult = FormattedTextValue(formattedText: "12 03", caretBeginOffset: 4)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12 |3  ->  12 0|3
    func test11() {
        let actualResult = formatter.formatInput(
            currentText: "12 3",
            range: NSRange(location: 3, length: 0),
            replacementString: "0")
        let expectedResult = FormattedTextValue(formattedText: "12 03", caretBeginOffset: 4)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // |12 34 56  ->  0|1 23 45
    func test12() {
        let result = formatter.formatInput(
            currentText: "12 34 56",
            range: NSRange(location: 0, length: 0),
            replacementString: "0"
        )
        let expectedResult = FormattedTextValue(formattedText: "01 23 45", caretBeginOffset: 1)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 1|2 34 56  ->  10| 23 45
    func test13() {
        let result = formatter.formatInput(
            currentText: "12 34 56",
            range: NSRange(location: 1, length: 0),
            replacementString: "0"
        )
        let expectedResult = FormattedTextValue(formattedText: "10 23 45", caretBeginOffset: 2)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 12| 34 56  ->  12 0|3 45
    func test14() {
        let result = formatter.formatInput(
            currentText: "12 34 56",
            range: NSRange(location: 2, length: 0),
            replacementString: "0"
        )
        let expectedResult = FormattedTextValue(formattedText: "12 03 45", caretBeginOffset: 4)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 12 |34 56  ->  12 0|3 45
    func test15() {
        let result = formatter.formatInput(
            currentText: "12 34 56",
            range: NSRange(location: 3, length: 0),
            replacementString: "0"
        )
        let expectedResult = FormattedTextValue(formattedText: "12 03 45", caretBeginOffset: 4)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 12 3|4 56  ->  12 30| 45
    func test16() {
        let result = formatter.formatInput(
            currentText: "12 34 56",
            range: NSRange(location: 4, length: 0),
            replacementString: "0"
        )
        let expectedResult = FormattedTextValue(formattedText: "12 30 45", caretBeginOffset: 5)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 12 34| 56  ->  12 34 0|5
    func test17() {
        let result = formatter.formatInput(
            currentText: "12 34 56",
            range: NSRange(location: 5, length: 0),
            replacementString: "0"
        )
        let expectedResult = FormattedTextValue(formattedText: "12 34 05", caretBeginOffset: 7)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 12 34 |56  ->  12 34 0|5
    func test18() {
        let result = formatter.formatInput(
            currentText: "12 34 56",
            range: NSRange(location: 6, length: 0),
            replacementString: "0"
        )
        let expectedResult = FormattedTextValue(formattedText: "12 34 05", caretBeginOffset: 7)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 12 34 5|6  ->  12 34 50|
    func test19() {
        let result = formatter.formatInput(
            currentText: "12 34 56",
            range: NSRange(location: 7, length: 0),
            replacementString: "0"
        )
        let expectedResult = FormattedTextValue(formattedText: "12 34 50", caretBeginOffset: 8)
        XCTAssertEqual(result, expectedResult)
    }
}
