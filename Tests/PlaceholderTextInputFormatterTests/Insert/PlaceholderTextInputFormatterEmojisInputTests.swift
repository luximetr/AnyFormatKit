//
//  PlaceholderTextInputFormatterEmojisInputTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 16.01.2021.
//  Copyright © 2021 BRANDERSTUDIO. All rights reserved.
//

import XCTest
import AnyFormatKit

class PlaceholderTextInputFormatterEmojisInputTests: XCTestCase {
    
    // |### ###  ->  😊|## ###
    func test1() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
      let result = formatter.formatInput(
        currentText: "### ###",
        range: NSRange(location: 0, length: 0),
        replacementString: "😊"
      )
      let expectedResult = FormattedTextValue(formattedText: "😊## ###", caretBeginOffset: 2)
      XCTAssertEqual(result, expectedResult)
    }
    
    // 😊|## ###  ->  😊👍|# ###
    func test2() {
      let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
      let result = formatter.formatInput(
        currentText: "😊## ###",
        range: NSRange(location: 2, length: 0),
        replacementString: "👍"
      )
      let expectedResult = FormattedTextValue(formattedText: "😊👍# ###", caretBeginOffset: 4)
      XCTAssertEqual(result, expectedResult)
    }
    
    // 😊👍|# ###  ->  😊👍🙈| ###
    func test3() {
        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
        let result = formatter.formatInput(
          currentText: "😊👍# ###",
          range: NSRange(location: 4, length: 0),
          replacementString: "🙈"
        )
        let expectedResult = FormattedTextValue(formattedText: "😊👍🙈 ###", caretBeginOffset: 6)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😊👍🙈| ###  ->  😊👍🙈 😱|##
    func test4() {
        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
        let result = formatter.formatInput(
          currentText: "😊👍🙈 ###",
          range: NSRange(location: 6, length: 0),
          replacementString: "😱"
        )
        let expectedResult = FormattedTextValue(formattedText: "😊👍🙈 😱##", caretBeginOffset: 9)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😊👍🙈 😱|##  ->  😊👍🙈 😱😳|#
    func test5() {
        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
        let result = formatter.formatInput(
          currentText: "😊👍🙈 😱##",
          range: NSRange(location: 9, length: 0),
          replacementString: "😳"
        )
        let expectedResult = FormattedTextValue(formattedText: "😊👍🙈 😱😳#", caretBeginOffset: 11)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😊👍🙈 😱😳|#  ->  😊👍🙈 😱😳😡|
    func test6() {
        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
        let result = formatter.formatInput(
          currentText: "😊👍🙈 😱😳#",
          range: NSRange(location: 11, length: 0),
          replacementString: "😡"
        )
        let expectedResult = FormattedTextValue(formattedText: "😊👍🙈 😱😳😡", caretBeginOffset: 13)
        XCTAssertEqual(result, expectedResult)
    }
    
    // 😊👍🙈 😱😳😡|  ->  😊👍🙈 😱😳😡|
    func test7() {
        let formatter = PlaceholderTextInputFormatter(textPattern: "### ###")
        let result = formatter.formatInput(
          currentText: "😊👍🙈 😱😳😡",
          range: NSRange(location: 13, length: 0),
          replacementString: "😅"
        )
        let expectedResult = FormattedTextValue(formattedText: "😊👍🙈 😱😳😡", caretBeginOffset: 13)
        XCTAssertEqual(result, expectedResult)
    }
    
}
