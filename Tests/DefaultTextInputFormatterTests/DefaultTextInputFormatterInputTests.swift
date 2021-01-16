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
    
    let formatter = DefaultTextInputFormatter(textPattern: "## ## ##")
    
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
    
    // |12 3  ->  0|1 23
    func test5() {
        let actualResult = formatter.formatInput(
            currentText: "12 3",
            range: NSRange(location: 0, length: 0),
            replacementString: "0")
        let expectedResult = FormattedTextValue(formattedText: "01 23", caretBeginOffset: 1)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 1|2 3  ->  10| 23
    func test6() {
        let actualResult = formatter.formatInput(
            currentText: "12 3",
            range: NSRange(location: 1, length: 0),
            replacementString: "0")
        let expectedResult = FormattedTextValue(formattedText: "10 23", caretBeginOffset: 2)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12| 3  ->  12 0|3
    func test7() {
        let actualResult = formatter.formatInput(
            currentText: "12 3",
            range: NSRange(location: 2, length: 0),
            replacementString: "0")
        let expectedResult = FormattedTextValue(formattedText: "12 03", caretBeginOffset: 4)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 12 |3  ->  12 03|
    func test8() {
        let actualResult = formatter.formatInput(
            currentText: "12 3",
            range: NSRange(location: 3, length: 0),
            replacementString: "0")
        let expectedResult = FormattedTextValue(formattedText: "12 03", caretBeginOffset: 4)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 1|2 3|4  =>  10| 4
    func test9() {
        let result = formatter.formatInput(
            currentText: "12 34",
            range: NSRange(location: 1, length: 3),
            replacementString: "0"
        )
        let expectedResult = FormattedTextValue(formattedText: "10 4", caretBeginOffset: 2)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😀|  ->  😀😎|
    func test10() {
        let result = formatter.formatInput(
            currentText: "😀",
            range: NSRange(location: 2, length: 0),
            replacementString: "😎"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀😎", caretBeginOffset: 4)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😀😎|  ->  😀😎 😅|
    func test11() {
        let result = formatter.formatInput(
            currentText: "😀😎",
            range: NSRange(location: 4, length: 0),
            replacementString: "😅"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀😎 😅", caretBeginOffset: 7)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 12 34 56|  ->  12 34 56|
    func test12() {
        let result = formatter.formatInput(
            currentText: "12 34 56",
            range: NSRange(location: 8, length: 0),
            replacementString: "0"
        )
        let expectedResult = FormattedTextValue(formattedText: "12 34 56", caretBeginOffset: 8)
        XCTAssertEqual(result, expectedResult)
    }
}
