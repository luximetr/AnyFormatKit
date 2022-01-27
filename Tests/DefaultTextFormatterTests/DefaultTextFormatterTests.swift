//
//  DefaultTextFormatterTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 18.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import XCTest
import AnyFormatKit

class DefaultTextFormatterTests: XCTestCase {

    // ""  ->  ""
    func test1() {
        let formatter = DefaultTextFormatter(textPattern: "## ## ##")
        let result = formatter.format("")
        let expectedResult = ""
        XCTAssertEqual(result, expectedResult)
    }
    
    // 123  -> 12 3
    func test2() {
        let formatter = DefaultTextFormatter(textPattern: "## ## ##")
        let result = formatter.format("123")
        let expectedResult = "12 3"
        XCTAssertEqual(result, expectedResult)
    }
    
    // 123  ->  +5 12 3
    func test3() {
        let formatter = DefaultTextFormatter(textPattern: "+5 ## ## ##")
        let result = formatter.format("123")
        let expectedResult = "+5 12 3"
        XCTAssertEqual(result, expectedResult)
    }
    
    // 123  ->  😊 12 3
    func test4() {
        let formatter = DefaultTextFormatter(textPattern: "😊 ## ## ##")
        let result = formatter.format("123")
        let expectedResult = "😊 12 3"
        XCTAssertEqual(result, expectedResult)
    }
    
    // nil  ->  nil
    func test5() {
        let formatter = DefaultTextFormatter(textPattern: "## ## ##")
        let result = formatter.format(nil)
        let expectedResult: String? = nil
        XCTAssertEqual(result, expectedResult)
    }
    
    // 1234  ->  12 34
    func test6() {
        let formatter = DefaultTextFormatter(textPattern: "XX XX", patternSymbol: "X")
        let result = formatter.format("1234")
        let expectedResult = "12 34"
        XCTAssertEqual(result, expectedResult)
    }
    
    // #123  ->  #1-23
    func test7() {
        let formatter = DefaultTextFormatter(textPattern: "##-##-##")
        let result = formatter.format("#123")
        let expectedResult = "#1-23"
        XCTAssertEqual(result, expectedResult)
    }
    
    // ####  ->  ##-##
    func test8() {
        let formatter = DefaultTextFormatter(textPattern: "##-##-##")
        let result = formatter.format("####")
        let expectedResult = "##-##"
        XCTAssertEqual(result, expectedResult)
    }
    
    // abcd  ->  ab-cd
    func test9() {
        let formatter = DefaultTextFormatter(textPattern: "##-##-##")
        let result = formatter.format("abcd")
        let expectedResult = "ab-cd"
        XCTAssertEqual(result, expectedResult)
    }
    
    // a1b2  ->  a1-b2
    func test10() {
        let formatter = DefaultTextFormatter(textPattern: "##-##-##")
        let result = formatter.format("a1b2")
        let expectedResult = "a1-b2"
        XCTAssertEqual(result, expectedResult)
    }
    
    func test11() {
        let formatter = DefaultTextFormatter(textPattern: "##-##-##")
        let result = formatter.format("a1#b#2")
        let expectedResult = "a1-#b-#2"
        XCTAssertEqual(result, expectedResult)
    }
}
