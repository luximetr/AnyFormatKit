//
//  SumTextInputFormatter.swift
//  AnyFormatKit
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

public class SumTextInputFormatter: SumTextFormatter, TextInputFormatterProtocol {
    
    public var prefix: String?

    public var formattedPrefix: String?

    public var allowedSymbolsRegex: String?

    public override init(textPattern: String, specialSymbol: Character = "#") {
        super.init(textPattern: textPattern, specialSymbol: specialSymbol)
        self.prefix = prefixStr
        self.formattedPrefix = prefixStr
    }

    public func didBeginEditing(_ textInput: TextInput) {
        guard let suffix = suffixStr else { return }
        
        let offset = (textInput.content?.length ?? 0) - suffix.length
        
        let newCursorLocation = textInput.position(from: textInput.beginningOfDocument, offset: offset)
        
        if let cursor = newCursorLocation {
            textInput.selectedTextRange = textInput.textRange(from: cursor, to: cursor)
        }
    }
    
    public func shouldChangeTextIn(textInput: TextInput, range: NSRange, replacementString text: String) -> Bool {
        
        var internalRange = range
        
        if text.isEmpty {
            let newRange = correctRangeForDeleting(from: textInput.content, at: internalRange)
            guard let newRangeUnwrapped = newRange else { return false }
            internalRange = newRangeUnwrapped
        } else if text == "," || text == "." {
            if !isCorrectSeparatorInserting() { return false }
        } else {
            if !isCorrectInserting(from: textInput.content, at: internalRange) { return false }
        }
        
        guard let oldString = textInput.content as NSString? else { return false }
        let newString = oldString.replacingCharacters(in: internalRange, with: text)
        
        if decimalSeparator != groupingSeparator {
            guard newString.components(separatedBy: decimalSeparator).count < 3 else { return false }
        }
        guard var newUnformatted = unformattedText(from: newString) else { return false }
        
        newUnformatted = stringOnlyWithAllowedSymbols(from: newUnformatted)
        let newFormatted = formattedText(from: newUnformatted)
        
        textInput.content = newFormatted
        
        guard let newFormattedUnwrapped = newFormatted else { return false }
        correctCarretPosition(textInput: textInput, range: internalRange, oldString: String(oldString), newString: newFormattedUnwrapped)
        
        return false
    }
    
    private func rangeOffset(range: NSRange, oldString: String, newString: String) -> Int {
        var offset = range.location + range.length + (newString.length - oldString.length)
        if oldString.isEmpty {
            offset -= suffixStr?.length ?? 0
        }
        if offset < prefix?.length ?? 0 {
            offset = prefix?.length ?? 0
        }
        return offset
    }
    
    private func correctCarretPosition(textInput: TextInput, range: NSRange, oldString: String, newString: String) {
        let beginning = textInput.beginningOfDocument
        let offset = rangeOffset(range: range, oldString: String(oldString), newString: newString)
        let cursorLocation = textInput.position(from: beginning, offset: offset)
        if let cursor = cursorLocation {
            textInput.selectedTextRange = textInput.textRange(from: cursor, to: cursor)
        }
    }
    
    private func stringOnlyWithAllowedSymbols(from string: String) -> String {
        var result = ""
        if let regex = allowedSymbolsRegex {
            let regexPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
            
            for character in string {
                if regexPredicate.evaluate(with: String(character)) {
                    result.append(character)
                }
            }
        } else {
            return string
        }
        return result
    }
    
    private func correctRangeForDeleting(from string: String?, at range: NSRange) -> NSRange? {
        guard let unformatted = unformattedText(from: string), !unformatted.isEmpty else { return nil }
        guard let text = string else { return nil }
        
        if range.length == 1 {
            if range.location > text.length - (suffixStr?.length ?? 0) - 1 ||
                range.location < (prefix?.length ?? 0)
            { return nil }
        } else {
            
            var lowerBound = range.lowerBound
            var upperBound = range.upperBound
            
            if range.lowerBound < (prefix?.length ?? 0) {
                lowerBound = (prefix?.length ?? 0)
            }
            
            if range.upperBound > text.length - (suffixStr?.length ?? 0)  {
                upperBound = text.length - (suffixStr?.length ?? 0)
            }
            
            let newRange = NSRange(location: lowerBound, length: upperBound - lowerBound)
            return newRange
        }
        
        return range
    }
    
    private func isCorrectInserting(from string: String?, at range: NSRange) -> Bool {
        guard let text = string else { return false }
        guard let unformated = unformattedText(from: string) else { return false }
        
        if range.location > (text.length - (suffixStr?.length ?? 0)) ||
            range.location < (prefix?.length ?? 0)
        { return false }
        
        guard let integerPart = unformated.components(separatedBy: decimalSeparator).first,
              integerPart.length < maximumIntegerCharacters
        else { return false }
        
        return true
    }
    
    private func isCorrectSeparatorInserting() -> Bool {
        if decimalSeparator.isEmpty || decimalSeparator == groupingSeparator { return false } //Decimal not allowed
        return true
    }
}
