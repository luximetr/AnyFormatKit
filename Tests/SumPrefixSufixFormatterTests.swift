
//
//  SumPrefixSufixFormatterTests.swift
//  AnyFormatKitTests
//
//  Created by BRANDERSTUDIO on 11/21/17.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import XCTest
import AnyFormatKit

class SumPrefixSufixFormatterTests: XCTestCase {
  func testEmptyPrefixFormatting() {
    let formatter = SumTextFormatter(textPattern: "#,###.##")
    let initialString = "123.45"
    let expectedString = "123.45"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test$PrefixFormatting() {
    let formatter = SumTextFormatter(textPattern: "$#,###.##")
    let initialString = "123.45"
    let expectedString = "$123.45"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test$SpacePrefixFormatting() {
    let formatter = SumTextFormatter(textPattern: "$ #,###.##")
    let initialString = "123.45"
    let expectedString = "$ 123.45"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testLongStringPrefixFormatting() {
    let formatter = SumTextFormatter(textPattern: "LongString #,###.##")
    let initialString = "123.45"
    let expectedString = "LongString 123.45"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test1PrefixFormatting() {
    let formatter = SumTextFormatter(textPattern: "1#,###.##")
    let initialString = "123.45"
    let expectedString = "1123.45"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testMinusPrefixFormatting() {
    let formatter = SumTextFormatter(textPattern: "-#,###.##")
    let initialString = "123.45"
    let expectedString = "-123.45"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testMinusPrefixNegativeValueFormatting() {
    let formatter = SumTextFormatter(textPattern: "-#,###.##")
    let initialString = "-123.45"
    let expectedString = "--123.45"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testDolarPrefixNegativeValueFormatting() {
    let formatter = SumTextFormatter(textPattern: "$#,###.##")
    let initialString = "-123.45"
    let expectedString = "$-123.45"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testDotPrefixFormatting() {
    let formatter = SumTextFormatter(textPattern: ".#,###.##")
    let initialString = "123.45"
    let expectedString = ".123.45"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testCommaPrefixFormatting() {
    let formatter = SumTextFormatter(textPattern: ",#,###.##")
    let initialString = "123.45"
    let expectedString = ",123.45"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testEmptySufixFormatting() {
    let formatter = SumTextFormatter(textPattern: "#,###.##")
    let initialString = "123.45"
    let expectedString = "123.45"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test$SufixFormatting() {
    let formatter = SumTextFormatter(textPattern: "#,###.##$")
    let initialString = "123.45"
    let expectedString = "123.45$"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testSpace$SufixFormatting() {
    let formatter = SumTextFormatter(textPattern: "#,###.## $")
    let initialString = "123.45"
    let expectedString = "123.45 $"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testLongStringSufixFormatting() {
    let formatter = SumTextFormatter(textPattern: "#,###.##LongString")
    let initialString = "123.45"
    let expectedString = "123.45LongString"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testDotSufixFormatting() {
    let formatter = SumTextFormatter(textPattern: "#,###.##.")
    let initialString = "123.45"
    let expectedString = "123.45."
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testCommaSufixFormatting() {
    let formatter = SumTextFormatter(textPattern: "#,###.##,")
    let initialString = "123.45"
    let expectedString = "123.45,"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func test$Prefix$SuffixFormatting() {
    let formatter = SumTextFormatter(textPattern: "$#,###.##$")
    let initialString = "123.45"
    let expectedString = "$123.45$"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testLongStringPrefixSufixFormatting() {
    let formatter = SumTextFormatter(textPattern: "LongString#,###.##LongString")
    let initialString = "123.45"
    let expectedString = "LongString123.45LongString"
    let formattedString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == formattedString,
              "\(String(describing: formattedString)) must be equal to \(expectedString)")
  }
  
  func testSuffixWithEmptyStringFormatting() {
    let formatter = SumTextFormatter(textPattern: "# ###.## $")
    let initialString = ""
    let expectedString = " $"
    let resultString = formatter.formattedText(from: initialString)
    XCTAssert(expectedString == resultString,
              "\(String(describing: resultString)) must be equal to \(expectedString)")
  }
}
