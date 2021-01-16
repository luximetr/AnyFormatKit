//
//  DefaultTextInputFormatterPhoneEmojisInputTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 16.01.2021.
//  Copyright © 2021 Orlov Oleksandr. All rights reserved.
//

import XCTest
import AnyFormatKit

class DefaultTextInputFormatterPhoneEmojisInputTests: XCTestCase {
    
    private let formatter = DefaultTextInputFormatter(textPattern: "### (###) ###-##-##")

    // |  ->  😊|
    func test1() {
        let actualResult = formatter.formatInput(
            currentText: "",
            range: NSRange(location: 0, length: 0),
            replacementString: "😊")
        let expectedResult = FormattedTextValue(formattedText: "😊", caretBeginOffset: 2)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 😊|  ->  😊👍|
    func test2() {
        let actualResult = formatter.formatInput(
            currentText: "😊",
            range: NSRange(location: 2, length: 0),
            replacementString: "👍")
        let expectedResult = FormattedTextValue(formattedText: "😊👍", caretBeginOffset: 4)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 😊👍|  ->  😊👍🙈|
    func test3() {
        let actualResult = formatter.formatInput(
            currentText: "😊👍",
            range: NSRange(location: 4, length: 0),
            replacementString: "🙈")
        let expectedResult = FormattedTextValue(formattedText: "😊👍🙈", caretBeginOffset: 6)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    // 😊👍🙈|  ->  😊👍🙈 (😱|
    func test4() {
        let actualResult = formatter.formatInput(
            currentText: "😊👍🙈",
            range: NSRange(location: 6, length: 0),
            replacementString: "😱")
        let expectedResult = FormattedTextValue(formattedText: "😊👍🙈 (😱", caretBeginOffset: 10)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
    
    //  😊👍🙈 (😱|  ->  😊👍🙈 (😱😭|
    func test5() {
        let actualResult = formatter.formatInput(
            currentText: "😊👍🙈 (😱",
            range: NSRange(location: 10, length: 0),
            replacementString: "😭")
        let expectedResult = FormattedTextValue(formattedText: "😊👍🙈 (😱😭", caretBeginOffset: 12)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
}
