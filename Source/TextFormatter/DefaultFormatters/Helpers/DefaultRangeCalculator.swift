//
//  DefaultRangeCalculator.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 27.01.2022.
//

import Foundation

class DefaultRangeCalculator {
    
    func unformattedRange(
        currentText: String,
        textPattern: String,
        from range: Range<String.Index>,
        patternSymbol: Character
    ) -> Range<String.Index> {
        let numberOfFormatCharsBeforeRange = getNumberOfFormatChars(
            textPattern: textPattern,
            text: currentText,
            before: range.lowerBound,
            patternSymbol: patternSymbol
        )
        let numberOfFormatCharsInRange = getNumberOfFormatChars(
            textPattern: textPattern,
            text: currentText,
            in: range,
            patternSymbol: patternSymbol
        )
        
        return currentText.getRangeWithOffsets(
            sourceRange: range,
            lowerBoundOffset: -numberOfFormatCharsBeforeRange,
            upperBoundOffset: -numberOfFormatCharsInRange
        )
    }
    
    private func getNumberOfFormatChars(
        textPattern: String,
        text: String,
        before beforeIndex: String.Index,
        patternSymbol: Character
    ) -> Int {
        let textLeftSlice = text.leftSlice(end: beforeIndex)
        let patternLeftSlice = textPattern.leftSlice(limit: textLeftSlice.count)
        var result = 0
        for (textSliceChar, patternSliceChar) in zip(textLeftSlice, patternLeftSlice) {
            if textSliceChar == patternSliceChar && textSliceChar != patternSymbol { result += 1 }
        }
        return result
    }
    
    private func getNumberOfFormatChars(
        textPattern: String,
        text: String,
        in range: Range<String.Index>,
        patternSymbol: Character
    ) -> Int {
        let textSlice = text.slice(in: range)
        let textPatternRange = textPattern.getSameRange(asIn: text, sourceRange: range)
        let patternSlice = textPattern.slice(in: textPatternRange)
        
        var result = 0
        for (textSliceCharIndex, textSliceChar) in textSlice.enumerated() {
            let isSameCharacter = patternSlice.isSameCharacter(at: textSliceCharIndex, character: textSliceChar)
            if isSameCharacter && textSliceChar != patternSymbol {
                result += 1
            }
        }
        return result
    }
}
