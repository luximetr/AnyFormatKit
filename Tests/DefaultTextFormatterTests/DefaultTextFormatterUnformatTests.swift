//
//  DefaultTextFormatterUnformatTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 18.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import XCTest
import AnyFormatKit

class DefaultTextFormatterUnformatTests: XCTestCase {

    // 12-34-45  ->  123445
    func test1() {
        let formatter = DefaultTextFormatter(textPattern: "##-##-##")
        let result = formatter.unformat("12-34-45")
        let expectedResult = "123445"
        XCTAssertEqual(result, expectedResult)
    }
    
    // 12 34  ->  1234
    func test2() {
        let formatter = DefaultTextFormatter(textPattern: "## ## ##")
        let result = formatter.unformat("12 34")
        let expectedResult = "1234"
        XCTAssertEqual(result, expectedResult)
    }
    
    // +5 11 22
    func test3() {
        let formatter = DefaultTextFormatter(textPattern: "+5 ## ##")
        let result = formatter.unformat("+5 11 22")
        let expectedResult = "1122"
        XCTAssertEqual(result, expectedResult)
    }
    
    // ""  ->  ""
    func test4() {
        let formatter = DefaultTextFormatter(textPattern: "##-## ##")
        let result = formatter.unformat("")
        let expectedResult = ""
        XCTAssertEqual(result, expectedResult)
    }
    
    // nil  ->  nil
    func test5() {
        let formatter = DefaultTextFormatter(textPattern: "##-## ##")
        let result = formatter.unformat(nil)
        let expectedResult: String? = nil
        XCTAssertEqual(result, expectedResult)
    }
    
    func test6() {
        let formatter = DefaultTextFormatter(textPattern: "##-##-##")
        let result = formatter.unformat("12-##")
        let expectedResult = "12##"
        XCTAssertEqual(result, expectedResult)
    }
    
    func test7() {
        let formatter = DefaultTextFormatter(textPattern: "##-##-##")
        let result = formatter.unformat("12-ab")
        let expectedResult = "12ab"
        XCTAssertEqual(result, expectedResult)
    }
}
