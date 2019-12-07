//
//  SumFormatParserTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 5/27/19.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumFormatParserTests: XCTestCase {
  
  private let parser = SumFormatParser()
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testPrefixParse() {
    let format = "$ # ####.## S"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = "$ "
    let actualResult = result.prefix
    XCTAssert(expectedResult == actualResult, "Wrong prefix \(String(describing: actualResult))")
  }
  
  func testWrongPrefixParse() {
    let format = "$ # ####.## S"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = "$"
    let actualResult = result.prefix
    XCTAssert(expectedResult != actualResult, "Should be wrong prefix \(String(describing: actualResult))")
  }
  
  func testNoPrefixParse() {
    let format = "# ####.## S"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = ""
    let actualResult = result.prefix
    XCTAssert(expectedResult == actualResult, "Wrong prefix \(String(describing: actualResult))")
  }
  
  func testSuffixParse() {
    let format = "$ # ####.## S"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = " S"
    let actualResult = result.suffix
    XCTAssert(expectedResult == actualResult, "Wrong suffix \(String(describing: actualResult))")
  }
  
  func testWrongSuffixParse() {
    let format = "$ # ####.## S"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = "S"
    let actualResult = result.suffix
    XCTAssert(expectedResult != actualResult, "Should be wrong suffix \(String(describing: actualResult))")
  }
  
  func testNoSuffixParse() {
    let format = "$ # ####.##"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = ""
    let actualResult = result.suffix
    XCTAssert(expectedResult == actualResult, "Wrong suffix \(String(describing: actualResult))")
  }
  
  func testGroupingSeparatorParse() {
    let format = "$ #-####_## S"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = "-"
    let actualResult = result.groupingSeparator
    XCTAssert(expectedResult == actualResult, "Wrong grouping separator \(String(describing: actualResult))")
  }
  
  func testGroupingSeparatorWithoutPrefixParse() {
    let format = "#-####_## S"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = "-"
    let actualResult = result.groupingSeparator
    XCTAssert(expectedResult == actualResult, "Wrong grouping separator \(String(describing: actualResult))")
  }
  
  func testLongGroupingSeparatorParse() {
    let format = "$ #LONG####_## S"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = "LONG"
    let actualResult = result.groupingSeparator
    XCTAssert(expectedResult == actualResult, "Wrong grouping separator \(String(describing: actualResult))")
  }
  
  func testWrongGroupingSeparatorParse() {
    let format = "$ #-####_## S"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = "_"
    let actualResult = result.groupingSeparator
    XCTAssert(expectedResult != actualResult, "Should be wrong grouping separator \(String(describing: actualResult))")
  }
  
  func testDecimalSeparatorParse() {
    let format = "$ #-####_## S"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = "_"
    let actualResult = result.decimalSeparator
    XCTAssert(expectedResult == actualResult, "Wrong decimal separator \(String(describing: actualResult))")
  }
  
  func testDecimalSeparatorWithoutSuffix() {
    let format = "$ #-####_##"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = "_"
    let actualResult = result.decimalSeparator
    XCTAssert(expectedResult == actualResult, "Wrong decimal separator \(String(describing: actualResult))")
  }

  func testNoneDecimalSeparator() {
    let format = "# ###"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = ""
    let actualResult = result.decimalSeparator
    XCTAssert(expectedResult == actualResult, "Wrong decimal separator \(String(describing: actualResult))")
  }
  
  func testWrongDecimalSeparator() {
    let format = "$ #-####_## S"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = "-"
    let actualResult = result.decimalSeparator
    XCTAssert(expectedResult != actualResult, "Should be wrong decimal separator \(String(describing: actualResult))")
  }
  
  func test4GroupSizeParse() {
    let format = "$ #-####_## S"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = 4
    let actualResult = result.groupingSize
    XCTAssert(expectedResult == actualResult, "Wrong grouping size \(actualResult)")
  }
  
  func test3GroupingSizeParse() {
    let format = "#-###_##"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = 3
    let actualResult = result.groupingSize
    XCTAssert(expectedResult == actualResult, "Wrong grouping size \(actualResult)")
  }

  func test5GroupingSizeParse() {
    let format = "# ### $"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = 3
    let actualResult = result.groupingSize
    XCTAssert(expectedResult == actualResult, "Wrong grouping size \(actualResult)")
  }

  func test1MaximumFractionDigitsParse() {
    let format = "# ###.##"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = 2
    let actualResult = result.maximumFractionDigits
    XCTAssert(expectedResult == actualResult, "Wrong maximum fraction digits \(actualResult)")
  }

  func test2MaximumFractionDigitsParse() {
    let format = "# ###"
    let result = parser.parse(format: format, patternSymbol: "#")
    let expectedResult = 0
    let actualResult = result.maximumFractionDigits
    XCTAssert(expectedResult == actualResult, "Wrong maximum fraction digits \(actualResult)")
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

}
