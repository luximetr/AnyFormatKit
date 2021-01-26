////
////  PlaceholderTextInputEmptyValueTests.swift
////  AnyFormatKitTests
////
////  Created by Oleksandr Orlov on 24.01.2021.
////  Copyright © 2021 Oleksandr Orlov. All rights reserved.
////
//
//import XCTest
//import AnyFormatKit
//
//class PlaceholderTextInputEmptyValueTests: XCTestCase {
//
//    // |### ###  ->  |### ###
//    func test1() {
//        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
//        let result = formatter.formatInput(
//          currentText: "### ###",
//          range: NSRange(location: 0, length: 0),
//          replacementString: ""
//        )
//        let expectedResult = FormattedTextValue(formattedText: "### ###", caretBeginOffset: 0)
//        XCTAssertEqual(result, expectedResult)
//    }
//
//    // #|## ###  ->  |### ###
//    func test2() {
//        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
//        let result = formatter.formatInput(
//          currentText: "### ###",
//          range: NSRange(location: 1, length: 0),
//          replacementString: ""
//        )
//        let expectedResult = FormattedTextValue(formattedText: "### ###", caretBeginOffset: 0)
//        XCTAssertEqual(result, expectedResult)
//    }
//
//    // ##|# ###  ->  |### ###
//    func test3() {
//        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
//        let result = formatter.formatInput(
//          currentText: "### ###",
//          range: NSRange(location: 2, length: 0),
//          replacementString: ""
//        )
//        let expectedResult = FormattedTextValue(formattedText: "### ###", caretBeginOffset: 0)
//        XCTAssertEqual(result, expectedResult)
//    }
//
//    // ###| ###  ->  |### ###
//    func test4() {
//        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
//        let result = formatter.formatInput(
//          currentText: "### ###",
//          range: NSRange(location: 3, length: 0),
//          replacementString: ""
//        )
//        let expectedResult = FormattedTextValue(formattedText: "### ###", caretBeginOffset: 0)
//        XCTAssertEqual(result, expectedResult)
//    }
//
//    // ### |###  ->  |### ###
//    func test5() {
//        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
//        let result = formatter.formatInput(
//          currentText: "### ###",
//          range: NSRange(location: 4, length: 0),
//          replacementString: ""
//        )
//        let expectedResult = FormattedTextValue(formattedText: "### ###", caretBeginOffset: 0)
//        XCTAssertEqual(result, expectedResult)
//    }
//
//    // ### #|##  ->  |### ###
//    func test6() {
//        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
//        let result = formatter.formatInput(
//          currentText: "### ###",
//          range: NSRange(location: 5, length: 0),
//          replacementString: ""
//        )
//        let expectedResult = FormattedTextValue(formattedText: "### ###", caretBeginOffset: 0)
//        XCTAssertEqual(result, expectedResult)
//    }
//
//    // ### ##|#  ->  |### ###
//    func test7() {
//        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
//        let result = formatter.formatInput(
//          currentText: "### ###",
//          range: NSRange(location: 6, length: 0),
//          replacementString: ""
//        )
//        let expectedResult = FormattedTextValue(formattedText: "### ###", caretBeginOffset: 0)
//        XCTAssertEqual(result, expectedResult)
//    }
//
//    // ### ###|  ->  |### ###
//    func test8() {
//        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
//        let result = formatter.formatInput(
//          currentText: "### ###",
//          range: NSRange(location: 7, length: 0),
//          replacementString: ""
//        )
//        let expectedResult = FormattedTextValue(formattedText: "### ###", caretBeginOffset: 0)
//        XCTAssertEqual(result, expectedResult)
//    }
//}
