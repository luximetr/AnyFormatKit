//
//  SumTextFormatter.swift
//  AnyFormatKit
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

public class SumTextFormatter: TextFormatterProtocol {
    
    private static let maxIntSize = String(Int.max).length - 1
    
    public var maximumDecimalCharacters: Int = 2
    public var maximumIntegerCharacters: Int = 14 {
        didSet {
            if maximumIntegerCharacters > SumTextFormatter.maxIntSize { maximumIntegerCharacters = SumTextFormatter.maxIntSize }
        }
    }
    
    var prefixStr: String?
    var suffixStr: String?
    var decimalSeparator: String = "."
    var groupingSeparator: String = ","
    var numberOfCharactersInGroup = 3
    
    var textPattern: String
    var specialSymbol: Character

    private let possibleDividers = CharacterSet(charactersIn: ".,")

    public init(textPattern: String, specialSymbol: Character = "#") {
        self.textPattern = textPattern
        self.specialSymbol = specialSymbol
        
        extractDataFromPattern()
    }
    
    private func extractDataFromPattern() {
        self.suffixStr = getSuffix(from: textPattern, specialSymbol: specialSymbol)
        self.prefixStr = getPrefix(from: textPattern, specialSymbol: specialSymbol)
        self.decimalSeparator = getDecimalSeparator(from: textPattern, specialSymbol: specialSymbol)
        self.groupingSeparator = getGroupingSeparator(from: textPattern, specialSymbol: specialSymbol)
    }
    
    private func getPrefix(from pattern: String, specialSymbol: Character) -> String {
        var result = ""
        for i in pattern.enumerated() {
            if i.element == specialSymbol {
                let index = pattern.index(pattern.startIndex, offsetBy: i.offset)
                result = String(pattern[pattern.startIndex..<index])
                break
            }
        }
        return result
    }
    
    private func getSuffix(from pattern: String, specialSymbol: Character) -> String {
        var result = ""
        var i = pattern.length
        while (i > 0) {
            i -= 1
            if let currentChar = pattern.characterAt(i), currentChar == specialSymbol {
                let index = pattern.index(pattern.endIndex, offsetBy: -(pattern.length - i - 1))
                result = String(pattern[index..<pattern.endIndex])
                break
            }
        }
        return result
    }
    
    private func getDecimalSeparator(from pattern: String, specialSymbol: Character) -> String {
        var result = ""
        var i = pattern.length - (suffixStr?.length ?? 0)
        while (i > 0) {
            i -= 1
            if let currentChar = pattern.characterAt(i), currentChar != specialSymbol {
                var tmpResult = ""
                var j = i
                
                while (pattern.characterAt(j) != specialSymbol) {
                    guard let char = pattern.characterAt(j) else { break }
                    tmpResult.append(char)
                    j -= 1
                }
                
                result = String(tmpResult.reversed())
                break
            }
        }
        return result
    }
    
    private func getGroupingSeparator(from pattern: String, specialSymbol: Character) -> String {
        var result = ""
        var i = prefixStr?.length ?? 0
        while (i < pattern.length) {
            if let currentChar = pattern.characterAt(i), currentChar != specialSymbol {
                var j = i
                while (pattern.characterAt(j) != specialSymbol) {
                    guard let char = pattern.characterAt(j) else { break }
                    result.append(char)
                    j += 1
                }
                break
            }
            i+=1
        }
        return result
    }
    
    func isRequireSubstitute(symbol: Character) -> Bool {
        return symbol == specialSymbol
    }
    
    private func stringForDecimal(decimal: Int) -> String {
        var result = ""
        let reversString = String(String(decimal).reversed())
        let isNegative = decimal < 0
        var reversLenght = reversString.length
        if isNegative {
            // for minus symbol
            reversLenght -= 1
        }
        for i in 0..<reversLenght {
            guard let currentChar = reversString.characterAt(i) else { continue }
            result.append(currentChar)
            if i % 3 == 2, i != 0, i != reversLenght - 1 {
                result.append(groupingSeparator)
            }
        }
        if isNegative {
            result.append("-")
        }
        return String(result.reversed())
    }
    
    
    public func formattedText(from unformatted: String?) -> String? {
        
        guard let unformattedString = unformatted else { return nil }
        guard !(unformattedString.isEmpty) else { return "\(prefixStr ?? "")\(suffixStr ?? "")" }
        
        var resultString = ""
        var hasIncompletedDecimal = false

        resultString.append(prefixStr ?? "")
        
        var doubleStringValue = unformattedString.components(separatedBy: possibleDividers).joined(separator: decimalSeparator)
        if doubleStringValue.characterAt(0) == Character(decimalSeparator) {
          doubleStringValue.insert("0", at: doubleStringValue.startIndex)
        }
        
        if doubleStringValue.characterAt(doubleStringValue.length - 1) == Character(decimalSeparator) {
            doubleStringValue.append("0")
            hasIncompletedDecimal = true
        }
        
        guard let doubleValue = Double(doubleStringValue) else { return unformattedString }

        let decimalValue = Int(doubleValue)
        resultString.append(stringForDecimal(decimal: decimalValue))

        if doubleStringValue.contains(decimalSeparator) {
          resultString.append(decimalSeparator)
          if doubleStringValue.characterAt(doubleStringValue.length - 1) != Character(decimalSeparator) {
            let floatString = doubleStringValue.components(separatedBy: decimalSeparator)[1]
            resultString.append(correctedDecimalPart(from: floatString))
            
          }
        }
        
        if hasIncompletedDecimal { resultString.removeLast() }
        resultString.append(suffixStr ?? "")
        return resultString
    }
    
    public func unformattedText(from formatted: String?) -> String? {
        guard let formattedString = formatted else { return nil }
        
        let unformattedString = formattedString
            .replacingOccurrences(of: suffixStr ?? "", with: "")
            .replacingOccurrences(of: prefixStr ?? "", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: groupingSeparator, with: "")
        
        return unformattedString
    }
    
    private func correctedDecimalPart(from string: String) -> String {
        if string.length <= maximumDecimalCharacters { return string }
        var tmpString = string
        let numberOfExcessSymbols = tmpString.length - maximumDecimalCharacters
        tmpString.removeLast(numberOfExcessSymbols)
        return tmpString
    }
    
    
}
