//
//  SumTextInputFormatterFormatTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 18.01.2021.
//  Copyright © 2021 BRANDERSTUDIO. All rights reserved.
//

import XCTest
import AnyFormatKit

class SumTextInputFormatterFormatTests: XCTestCase {
    
    // 1345.99  ->  1,345.99
    func test1() {
        let formatter = SumTextFormatter(textPattern: "#,###.##")
        let actualResult = formatter.format("1345.99")
        let expectedResult = "1,345.99"
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // nil  ->  nil
    func test2() {
        let formatter = SumTextFormatter(textPattern: "#,###.##")
        let actualResult = formatter.format(nil)
        let expectedResult: String? = nil
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(String(describing: expectedResult))")
    }
    
    // ""  ->  ""
    func test3() {
        let formatter = SumTextFormatter(textPattern: "#,###.##")
        let actualResult = formatter.format("")
        let expectedResult = ""
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // 144  ->  144
    func test4() {
        let formatter = SumTextFormatter(textPattern: "#,###.##")
        let actualResult = formatter.format("144")
        let expectedResult = "144"
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // 0  ->  0
    func test5() {
        let formatter = SumTextFormatter(textPattern: "#,###.##")
        let actualResult = formatter.format("0")
        let expectedResult = "0"
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // 0.1  ->  0.1
    func test6() {
        let formatter = SumTextFormatter(textPattern: "#,###.##")
        let actualResult = formatter.format("0.1")
        let expectedResult = "0.1"
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // 10000  ->  10,000
    func test7() {
        let formatter = SumTextFormatter(textPattern: "#,###.##")
        let actualResult = formatter.format("10000")
        let expectedResult = "10,000"
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // .55  ->  .55
    func test8() {
        let formatter = SumTextFormatter(textPattern: "#,###.##")
        let actualResult = formatter.format(".55")
        let expectedResult = "0.55"
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // 0.234  ->  0.23
    func test9() {
        let formatter = SumTextFormatter(textPattern: "#,###.##")
        let actualResult = formatter.format("0.234")
        let expectedResult = "0.23"
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // 0.239  ->  0.23
    func test10() {
        let formatter = SumTextFormatter(textPattern: "#,###.##")
        let actualResult = formatter.format("0.239")
        let expectedResult = "0.23"
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // 111222333444  ->  111,222,333,444
    func test11() {
        let formatter = SumTextFormatter(textPattern: "#,###.##")
        let actualResult = formatter.format("111222333444")
        let expectedResult = "111,222,333,444"
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
}
