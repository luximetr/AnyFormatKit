//
//  DefaultTextInputFormatter3SymbolsReplace.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 10.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class DefaultTextInputFormatter3SymbolsReplace: XCTestCase {
  
  private let formatter = DefaultTextInputFormatter(textPattern: "## ## ##")
  
  // MARK: - 1 symbol replace
  
  // |1|2 34  ->  56 7|2 34
  
  func testI1I2_34to56_7I2_34() {
    let actualResult = formatter.formatInput(
      currentText: "12 34",
      range: NSRange(location: 0, length: 1),
      replacementString: "567")
    let expectedResult = FormattedTextValue(formattedText: "56 72 34", caretBeginOffset: 4)
    XCTAssert(actualResult == expectedResult, "\(expectedResult) must be equal to \(actualResult)")
  }
  
  // 1|2| 34  ->  15 67| 34
  
  // 12| |34  ->  12 56 7|3
  
  // 12 |3|4  ->  12 56 7|4
  
  // 12 3|4|  ->  12 35 67|
  
  // MARK: - 2 symbols replace
  
  // |12| 34  -> 56 7|3 4
  
  // 1|2 |34  -> 15 67| 34
  
  // 12| 3|4  -> 12 56 7|4
  
  // 12 |34|  -> 12 56 7|
  
  // MARK: - 3 symbols replace
  
  // |12 |34  -> 56 7|3 4
  
  // 1|2 3|4  -> 15 67| 4
  
  // 12| 34|  -> 12 56 7|
  
  // MARK: - 4 symbols replace
  
  // |12 3|4  -> 56 7|4
  
  // 1|2 34|  -> 15 67| 4
  
  // MARK: - 5 symbols replace
  
  // |12 34|  -> 56 7|

}
