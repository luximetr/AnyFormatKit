//
//  SumTextInputFormatterWithSuffixInput0Tests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 19.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWithSuffixInput0Tests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "#,###.## $")
  
  // 20.| $  ->  20.0| $
  func test1() {
    let actualResult = formatter.formatInput(
      currentText: "20. $",
      range: NSRange(location: 3, length: 0),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "20.0 $", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
  
  // 20.0| $  ->  20.00| $
  func test2() {
    let actualResult = formatter.formatInput(
      currentText: "20.0 $",
      range: NSRange(location: 4, length: 0),
      replacementString: "0")
    let expectedResult = FormattedTextValue(formattedText: "20.00 $", caretBeginOffset: 5)
    XCTAssert(actualResult == expectedResult, "\n\(actualResult) must be equal to\n\(expectedResult)")
  }
}
