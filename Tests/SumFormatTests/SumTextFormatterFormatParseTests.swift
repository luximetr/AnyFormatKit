//
//  SumTextFormatterFormatParseTests.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 04.02.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import XCTest
import AnyFormatKit

class SumTextFormatterFormatParseTests: XCTestCase {
    
    // test default maximumIntegerCharacters
    func test1() {
        let formatter = SumTextFormatter(textPattern: "# ###.##")
        let expectedValue = 14
        let resultValue = formatter.maximumIntegerCharacters
        XCTAssert(expectedValue == resultValue, "\(resultValue) must be equal to \(expectedValue)")
    }
    
    // test update maximumIntegerCharacters
    func test2() {
        let formatter = SumTextFormatter(textPattern: "# ###.##")
        formatter.maximumIntegerCharacters = 10
        let expectedValue = 10
        let resultValue = formatter.maximumIntegerCharacters
        XCTAssert(expectedValue == resultValue, "\(resultValue) must be equal to \(expectedValue)")
    }
    
    // test string with more than maximumIntegerCharacters
    func test3() {
        let formatter = SumTextFormatter(textPattern: "# ###.##")
        formatter.maximumIntegerCharacters = 4
        let expectedString = "2 345.67"
        let formattedString = formatter.format("12345.67")
        XCTAssert(expectedString == formattedString,
                  "\(String(describing: formattedString)) must be equal to \(expectedString)")
    }
    
    // test parsed maximumDecimalCharacters from .## (after '.')
    func test4() {
        let formatter = SumTextFormatter(textPattern: "# ###.##")
        let expectedValue = 2
        let resultValue = formatter.maximumDecimalCharacters
        XCTAssert(expectedValue == resultValue, "\(resultValue) must be equal to \(expectedValue)")
    }
    
    // test parsed maximumDecimalCharacters from .##### (after '.')
    func test5() {
        let formatter = SumTextFormatter(textPattern: "# ###.#####")
        let expectedValue = 5
        let resultValue = formatter.maximumDecimalCharacters
        XCTAssert(expectedValue == resultValue, "\(resultValue) must be equal to \(expectedValue)")
    }
    
    // test with more than maximumDecimalCharacters
    func test6() {
        let formatter = SumTextFormatter(textPattern: "# ###.##")
        let expectedString = "12 345.67"
        let formattedString = formatter.format("12345.6789")
        XCTAssert(expectedString == formattedString,
                  "\(String(describing: formattedString)) must be equal to \(expectedString)")
    }
    
    // test 1 symbol parsed prefix
    func test7() {
        let formatter = SumTextFormatter(textPattern: "$# ###.## !")
        let expectedPrefix = "$"
        let actualPrefix = formatter.prefix
        XCTAssert(expectedPrefix == actualPrefix,
                  "\(String(describing: actualPrefix)) must be equal to \(expectedPrefix)")
    }
    
    // test 2 symbols parsed prefix
    func test8() {
        let formatter = SumTextFormatter(textPattern: "$ # ###.## !")
        let expectedPrefix = "$ "
        let actualPrefix = formatter.prefix
        XCTAssert(expectedPrefix == actualPrefix,
                  "\(String(describing: actualPrefix)) must be equal to \(expectedPrefix)")
    }
    
    // test 3 symbols emoji parsed prefix
    func test9() {
        let formatter = SumTextFormatter(textPattern: "$👍😁# ###.## !")
        let expectedPrefix = "$👍😁"
        let actualPrefix = formatter.prefix
        XCTAssert(expectedPrefix == actualPrefix,
                  "\(String(describing: actualPrefix)) must be equal to \(expectedPrefix)")
    }
    
    // test empty parsed prefix
    func test10() {
        let formatter = SumTextFormatter(textPattern: "# ###.## !")
        let expectedPrefix: String? = nil
        let actualPrefix = formatter.prefix
        XCTAssert(expectedPrefix == actualPrefix,
                  "\(String(describing: actualPrefix)) must be equal to \(String(describing: expectedPrefix))")
    }
    
    // test 1 symbol parsed suffix
    func test11() {
        let formatter = SumTextFormatter(textPattern: "# ###.##$")
        let expectedSuffix = "$"
        let actualSuffix = formatter.suffix
        XCTAssert(expectedSuffix == actualSuffix,
                  "\(String(describing: actualSuffix)) must be equal to \(expectedSuffix)")
    }
    
    // test 2 symbols parsed suffix
    func test12() {
        let formatter = SumTextFormatter(textPattern: "# ###.## $")
        let expectedSuffix = " $"
        let actualSuffix = formatter.suffix
        XCTAssert(expectedSuffix == actualSuffix,
                  "\(String(describing: actualSuffix)) must be equal to \(expectedSuffix)")
    }
    
    // test 3 symbols emoji parsed suffix
    func test13() {
        let formatter = SumTextFormatter(textPattern: "# ###.##😊👍$")
        let expectedSuffix = "😊👍$"
        let actualSuffix = formatter.suffix
        XCTAssert(expectedSuffix == actualSuffix,
                  "\(String(describing: actualSuffix)) must be equal to \(expectedSuffix)")
    }
    
    // test empty parsed suffix
    func test14() {
        let formatter = SumTextFormatter(textPattern: "_ # ###.##")
        let expectedSuffix: String? = nil
        let actualSuffix = formatter.suffix
        XCTAssert(expectedSuffix == actualSuffix,
                  "\(String(describing: actualSuffix)) must be equal to \(String(describing: expectedSuffix))")
    }
    
    // test parsed ' ' groupingSeparator
    func test15() {
        let formatter = SumTextFormatter(textPattern: "_ # ###.## $")
        let expectedSeparator = " "
        let actualSeparator = formatter.groupingSeparator
        XCTAssert(expectedSeparator == actualSeparator, "\(actualSeparator) must be equal to \(expectedSeparator)")
    }
    
    // test parsed ',' groupingSeparator
    func test16() {
        let formatter = SumTextFormatter(textPattern: "_ #,###.## $")
        let expectedSeparator = ","
        let actualSeparator = formatter.groupingSeparator
        XCTAssert(expectedSeparator == actualSeparator, "\(actualSeparator) must be equal to \(expectedSeparator)")
    }
    
    // test parsed '()' groupingSeparator
    func test17() {
        let formatter = SumTextFormatter(textPattern: "_ #()###.## $")
        let expectedSeparator = "()"
        let actualSeparator = formatter.groupingSeparator
        XCTAssert(expectedSeparator == actualSeparator, "\(actualSeparator) must be equal to \(expectedSeparator)")
    }
    
    // test parsed '.' decimalSeparator
    func test18() {
        let formatter = SumTextFormatter(textPattern: "_ # ###.## $")
        let expectedSeparator = "."
        let actualSeparator = formatter.decimalSeparator
        XCTAssert(expectedSeparator == actualSeparator, "\(actualSeparator) must be equal to \(expectedSeparator)")
    }
    
    // test parsed ',' decimalSeparator
    func test19() {
        let formatter = SumTextFormatter(textPattern: "_ # ###,## $")
        let expectedSeparator = ","
        let actualSeparator = formatter.decimalSeparator
        XCTAssert(expectedSeparator == actualSeparator, "\(actualSeparator) must be equal to \(expectedSeparator)")
    }
    
    // test parsed '()' decimalSeparator
    func test20() {
        let formatter = SumTextFormatter(textPattern: "_ # ###()## $")
        let expectedSeparator = "()"
        let actualSeparator = formatter.decimalSeparator
        XCTAssert(expectedSeparator == actualSeparator, "\(actualSeparator) must be equal to \(expectedSeparator)")
    }
    
    // test parsed 3 groupingSize
    func test21() {
        let formatter = SumTextFormatter(textPattern: "# ###.## $")
        let expectedSize = 3
        let actualSize = formatter.groupingSize
        XCTAssert(expectedSize == actualSize, "\(actualSize) must be equal to \(expectedSize)")
    }
    
    // test parsed 5 groupingSize
    func test22() {
        let formatter = SumTextFormatter(textPattern: "# #####.## $")
        let expectedSize = 5
        let actualSize = formatter.groupingSize
        XCTAssert(expectedSize == actualSize, "\(actualSize) must be equal to \(expectedSize)")
    }
    
    // test parsed 3 groupingSize with ' ' groupingSeparator and ' ' in prefix
    func test23() {
        let formatter = SumTextFormatter(textPattern: "_ # ###.## $")
        let expectedSize = 3
        let actualSize = formatter.groupingSize
        XCTAssert(expectedSize == actualSize, "\(actualSize) must be equal to \(expectedSize)")
    }
    
    // test parsed 1 groupingSize
    func test24() {
        let formatter = SumTextFormatter(textPattern: "# #.## $")
        let expectedSize = 1
        let actualSize = formatter.groupingSize
        XCTAssert(expectedSize == actualSize, "\(actualSize) must be equal to \(expectedSize)")
    }
}
