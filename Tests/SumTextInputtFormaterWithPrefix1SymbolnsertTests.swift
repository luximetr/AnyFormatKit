//
//  SumTextInputFormatterWithPrefix1SymbolInsertTests.swift
//  AnyFormatKitTests
//
//  Created by branderstudio on 13.06.2019.
//  Copyright © 2019 BRANDERSTUDIO. All rights reserved.
//

import XCTest
@testable import AnyFormatKit

class SumTextInputFormatterWithPrefix1SymbolInsertTests: XCTestCase {

  private let formatter = SumTextInputFormatter(textPattern: "$#,###.##")
  
  // |$12,345.67  ->  $9|12,345.67
  
  // $|12,345.67  ->  $9|12,345.67
  
  // $1|2,345.67  ->  $192|,345.67
  
  // $12|,345.67  ->  $129|,345.67
  
  // $12,|345.67  ->  $129|,345.67
  
  // $12,3|45.67  ->  $123,9|45.67
  
  // $12,34|5.67  ->  $123,49|5.67
  
  // $12,345|.67  ->  $123,459|.67
  
  // $12,345.|67  ->  $12,345.9|6
  
  // $12,345.6|7  ->  $12,345.69|
  
  // $12,345.67|  ->  $12,345.67|
}
