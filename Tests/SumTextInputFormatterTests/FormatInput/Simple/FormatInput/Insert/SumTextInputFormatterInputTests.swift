//
//  SumTextInputFormatterInputTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 10.06.2019.
//  Copyright © 2019 Oleksandr Orlov. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterInputTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "#,###.##")
  
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
  
  // 12|  ->  123|
  func test3() {
    let actualResult = formatter.formatInput(
      currentText: "12",
      range: NSRange(location: 2, length: 0),
      replacementString: "3")
    let expectedResult = FormattedTextValue(formattedText: "123", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 123|  ->  1,234|
  func test4() {
    let actualResult = formatter.formatInput(
      currentText: "123",
      range: NSRange(location: 3, length: 0),
      replacementString: "4")
    let expectedResult = FormattedTextValue(formattedText: "1,234", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1,234|  ->  12,345|
  func test5() {
    let actualResult = formatter.formatInput(
      currentText: "1,234",
      range: NSRange(location: 5, length: 0),
      replacementString: "5")
    let expectedResult = FormattedTextValue(formattedText: "12,345", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 12,345|  ->  123,456|
  func test6() {
    let actualResult = formatter.formatInput(
      currentText: "12,345",
      range: NSRange(location: 6, length: 0),
      replacementString: "6")
    let expectedResult = FormattedTextValue(formattedText: "123,456", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 123,456|  ->  1,234,567|
  func test7() {
    let actualResult = formatter.formatInput(
      currentText: "123,456",
      range: NSRange(location: 7, length: 0),
      replacementString: "7")
    let expectedResult = FormattedTextValue(formattedText: "1,234,567", caretBeginOffset: 9)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1,234|  ->  1,234.|
  func test8() {
    let actualResult = formatter.formatInput(
      currentText: "1,234",
      range: NSRange(location: 5, length: 0),
      replacementString: ".")
    let expectedResult = FormattedTextValue(formattedText: "1,234.", caretBeginOffset: 6)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1,234.|  ->  1,234.5|
  func test9() {
    let actualResult = formatter.formatInput(
      currentText: "1,234.",
      range: NSRange(location: 6, length: 0),
      replacementString: "5")
    let expectedResult = FormattedTextValue(formattedText: "1,234.5", caretBeginOffset: 7)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 1,234.5|  ->  1,234.56|
  func test10() {
    let actualResult = formatter.formatInput(
      currentText: "1,234.5",
      range: NSRange(location: 7, length: 0),
      replacementString: "6")
    let expectedResult = FormattedTextValue(formattedText: "1,234.56", caretBeginOffset: 8)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // "|"  ->  .|
  func test11() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: "",
      range: NSRange(location: 0, length: 0),
      replacementString: ".")
    let expectedResult = FormattedTextValue(formattedText: ".", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // .|  ->  .5|
  func test12() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: ".",
      range: NSRange(location: 1, length: 0),
      replacementString: "5")
    let expectedResult = FormattedTextValue(formattedText: ".5", caretBeginOffset: 2)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // .5|  ->  .56|
  func test13() { // #to_fix
    let actualResult = formatter.formatInput(
      currentText: ".5",
      range: NSRange(location: 2, length: 0),
      replacementString: "6")
    let expectedResult = FormattedTextValue(formattedText: ".56", caretBeginOffset: 3)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // |.56  ->  3|.56
  func test14() {
    let actualResult = formatter.formatInput(
      currentText: ".56",
      range: NSRange(location: 0, length: 0),
      replacementString: "3")
    let expectedResult = FormattedTextValue(formattedText: "3.56", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // |3.56  ->  2|3.56
  func test15() {
    let actualResult = formatter.formatInput(
      currentText: "3.56",
      range: NSRange(location: 0, length: 0),
      replacementString: "2")
    let expectedResult = FormattedTextValue(formattedText: "23.56", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // |23.56  ->  1|23.56
  func test16() {
    let actualResult = formatter.formatInput(
      currentText: "23.56",
      range: NSRange(location: 0, length: 0),
      replacementString: "1")
    let expectedResult = FormattedTextValue(formattedText: "123.56", caretBeginOffset: 1)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 123|.56  ->  1,234|.56
  func test17() {
    let actualResult = formatter.formatInput(
      currentText: "123.56",
      range: NSRange(location: 3, length: 0),
      replacementString: "4")
    let expectedResult = FormattedTextValue(formattedText: "1,234.56", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
    
    // 12,345,678,901,234|.56  ->  12,345,678,901,234|.56
    func test18() {
        let actualResult = formatter.formatInput(
            currentText: "12,345,678,901,234.56",
            range: NSRange(location: 18, length: 0),
            replacementString: "9")
        let expectedResult = FormattedTextValue(formattedText: "12,345,678,901,234.56", caretBeginOffset: 18)
        XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
    }
}
