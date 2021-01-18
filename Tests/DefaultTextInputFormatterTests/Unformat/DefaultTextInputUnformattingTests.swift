//
//  DefaultTextInputUnformattingTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 18.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import XCTest
import AnyFormatKit

class DefaultTextInputUnformattingTests: XCTestCase {
    
    // +5 123 456  ->  123456
    func test1() {
        let formatter = DefaultTextInputFormatter(textPattern: "+5 ### ###")
        let result = formatter.unformat("+5 123 456")
        let expectedResult = "123456"
        XCTAssertEqual(result, expectedResult)
    }
    
    // 123 4  ->  1234
    func test2() {
        let formatter = DefaultTextInputFormatter(textPattern: "### ###")
        let result = formatter.unformat("123 4")
        let expectedResult = "1234"
        XCTAssertEqual(result, expectedResult)
    }
    
    // ""  ->  ""
    func test3() {
        let formatter = DefaultTextInputFormatter(textPattern: "### ###")
        let result = formatter.unformat("")
        let expectedResult = ""
        XCTAssertEqual(result, expectedResult)
    }
    
    // nil  ->  nil
    func test4() {
        let formatter = DefaultTextInputFormatter(textPattern: "### ###")
        let result = formatter.unformat(nil)
        let expectedResult: String? = nil
        XCTAssertEqual(result, expectedResult)
    }
    
    func test5() {
        let formatter = DefaultTextInputFormatter(textPattern: "+5 ### ###")
        let result = formatter.unformat("+5 ")
        let expectedResult = ""
        XCTAssertEqual(result, expectedResult)
    }

}
