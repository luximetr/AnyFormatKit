//
//  SumTextInputFormatterNumberUnformatTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 18.01.2021.
//  Copyright © 2021 BRANDERSTUDIO. All rights reserved.
//

import XCTest
import AnyFormatKit

class SumTextInputFormatterNumberUnformatTests: XCTestCase {
    
    // 1,345.99 $  ->  1345.99
    func test1() {
        let formatter = SumTextInputFormatter(textPattern: "#,###.## $")
        let actualResult = formatter.unformatNumber("1,345.99 $")
        let expectedResult = NSDecimalNumber(string: "1345.99")
        XCTAssert(actualResult?.compare(expectedResult) == .orderedSame, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // 1 345,99 @  ->  1345,99
    func test2() {
        let formatter = SumTextInputFormatter(textPattern: "# ###,## @")
        let actualResult = formatter.unformatNumber("1 345,99 @")
        let expectedResult = NSDecimalNumber(string: "1345.99")
        XCTAssert(actualResult?.compare(expectedResult) == .orderedSame, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // 345.90 $  ->  345.90
    func test3() {
        let formatter = SumTextInputFormatter(textPattern: "#,###.## $")
        let actualResult = formatter.unformatNumber("345.99 $")
        let expectedResult = NSDecimalNumber(string: "345.99")
        XCTAssert(actualResult?.compare(expectedResult) == .orderedSame, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // 345.9  ->  345.9
    func test4() {
        let formatter = SumTextInputFormatter(textPattern: "#,###.##")
        let actualResult = formatter.unformatNumber("345.9")
        let expectedResult = NSDecimalNumber(string: "345.9")
        XCTAssert(actualResult?.compare(expectedResult) == .orderedSame, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }

    // ""  ->  ""
    func test5() {
        let formatter = SumTextInputFormatter(textPattern: "#,###.## $")
        let actualResult = formatter.unformatNumber("")
        let expectedResult: NSNumber? = nil
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(String(describing: expectedResult))")
    }

    // nil  ->  nil
    func test6() {
        let formatter = SumTextInputFormatter(textPattern: "#,###.## $")
        let actualResult = formatter.unformatNumber(nil)
        let expectedResult: NSNumber? = nil
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(String(describing: actualResult))")
    }

    // .90 $  ->  0.90
    func test7() {
        let formatter = SumTextInputFormatter(textPattern: "#,###.## $")
        let actualResult = formatter.unformatNumber(".90 $")
        let expectedResult = NSDecimalNumber(string: "0.9")
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }

    // .9  ->  0.9
    func test8() {
        let formatter = SumTextInputFormatter(textPattern: "#,###.## $")
        let actualResult = formatter.unformatNumber(".9 $")
        let expectedResult = NSDecimalNumber(string: "0.9")
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // 0  ->  0
    func test9() {
        let formatter = SumTextInputFormatter(textPattern: "#,###.##")
        let actualResult = formatter.unformatNumber("0")
        let expectedResult = NSDecimalNumber(string: "0")
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
    
    // 1,344  ->  1344
    func test10() {
        let formatter = SumTextInputFormatter(textPattern: "#,###.##")
        let actualResult = formatter.unformatNumber("1,344")
        let expectedResult = NSDecimalNumber(string: "1344")
        XCTAssert(actualResult == expectedResult, "\n\(String(describing: actualResult)) must be equal to\n\(expectedResult)")
    }
}
