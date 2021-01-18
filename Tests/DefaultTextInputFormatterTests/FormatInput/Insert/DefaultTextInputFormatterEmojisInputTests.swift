//
//  DefaultTextInputFormatterEmojisInputTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 16.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import XCTest
import AnyFormatKit

class DefaultTextInputFormatterEmojisInputTests: XCTestCase {
    
    private let formatter = DefaultTextInputFormatter(textPattern: "## ## ##")
    
    // |  ->  😀|
    func test1() {
        let result = formatter.formatInput(
            currentText: "",
            range: NSRange(location: 0, length: 0),
            replacementString: "😀"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀", caretBeginOffset: 2)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😀|  ->  😀😎|
    func test2() {
        let result = formatter.formatInput(
            currentText: "😀",
            range: NSRange(location: 2, length: 0),
            replacementString: "😎"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀😎", caretBeginOffset: 4)
        XCTAssertEqual(result, expectedResult)
    }

    // 😀😎|  ->  😀😎 😅|
    func test3() {
        let result = formatter.formatInput(
            currentText: "😀😎",
            range: NSRange(location: 4, length: 0),
            replacementString: "😅"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀😎 😅", caretBeginOffset: 7)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😀😎 😅|  ->  😀😎 😅👍|
    func test4() {
        let result = formatter.formatInput(
            currentText: "😀😎 😅",
            range: NSRange(location: 7, length: 0),
            replacementString: "👍"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀😎 😅👍", caretBeginOffset: 9)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😀😎 😅👍|  ->  😀😎 😅👍 🙈|
    func test5() {
        let result = formatter.formatInput(
            currentText: "😀😎 😅👍",
            range: NSRange(location: 9, length: 0),
            replacementString: "🙈"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀😎 😅👍 🙈", caretBeginOffset: 12)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😀😎 😅👍 🙈|  ->  😀😎 😅👍 🙈😱|
    func test6() {
        let result = formatter.formatInput(
            currentText: "😀😎 😅👍 🙈",
            range: NSRange(location: 12, length: 0),
            replacementString: "😱"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀😎 😅👍 🙈😱", caretBeginOffset: 14)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😀😎 😅👍 🙈😱|  ->  😀😎 😅👍 🙈😱|
    func test7() {
        let result = formatter.formatInput(
            currentText: "😀😎 😅👍 🙈😱",
            range: NSRange(location: 14, length: 0),
            replacementString: "😳"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀😎 😅👍 🙈😱", caretBeginOffset: 14)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😀|  ->  😀1|
    func test8() {
        let result = formatter.formatInput(
            currentText: "😀",
            range: NSRange(location: 2, length: 0),
            replacementString: "1"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀1", caretBeginOffset: 3)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😀1|  ->  😀1 😎|
    func test9() {
        let result = formatter.formatInput(
            currentText: "😀1",
            range: NSRange(location: 3, length: 0),
            replacementString: "😎"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀1 😎", caretBeginOffset: 6)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😀1 😎|  ->  😀1 😎2|
    func test10() {
        let result = formatter.formatInput(
            currentText: "😀1 😎",
            range: NSRange(location: 6, length: 0),
            replacementString: "2"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀1 😎2", caretBeginOffset: 7)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😀1 😎2|  ->  😀1 😎2 😅|
    func test11() {
        let result = formatter.formatInput(
            currentText: "😀1 😎2",
            range: NSRange(location: 7, length: 0),
            replacementString: "😅"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀1 😎2 😅", caretBeginOffset: 10)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😀1 😎2 😅|  ->  😀1 😎2 😅3
    func test12() {
        let result = formatter.formatInput(
            currentText: "😀1 😎2 😅",
            range: NSRange(location: 10, length: 0),
            replacementString: "3"
        )
        let expectedResult = FormattedTextValue(formattedText: "😀1 😎2 😅3", caretBeginOffset: 11)
        XCTAssertEqual(result, expectedResult)
    }
}
