//
//  PlaceholderRangeCalculator.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 16.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import Foundation

class PlaceholderRangeCalculator {
    
    func unformattedRange(
        currentText: String,
        textPattern: String,
        from range: Range<String.Index>
    ) -> Range<String.Index> {
        let numberOfFormatCharsBeforeRange = getNumberOfFormatChars(
            textPattern: textPattern,
            text: currentText,
            before: range.lowerBound
        )
        let numberOfFormatCharsInRange = getNumberOfFormatChars(
            textPattern: textPattern,
            text: currentText,
            in: range
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
        before: String.Index
    ) -> Int {
        let textLeftSlice = text.leftSlice(end: before)
        let patternLeftSlice = textPattern.leftSlice(limit: textLeftSlice.count)
        var result = 0
        for (textSliceChar, patternSliceChar) in zip(textLeftSlice, patternLeftSlice) {
            if textSliceChar == patternSliceChar { result += 1 }
        }
        return result
    }
    
    private func getNumberOfFormatChars(
        textPattern: String,
        text: String,
        in range: Range<String.Index>
    ) -> Int {
        let textSlice = text.slice(in: range)
        let textPatternRange = textPattern.getSameRange(asIn: text, sourceRange: range)
        let patternSlice = textPattern.slice(in: textPatternRange)
        
        var result = 0
        for (textSliceCharIndex, textSliceChar) in textSlice.enumerated() {
            let isSameCharacter = patternSlice.isSameCharacter(at: textSliceCharIndex, character: textSliceChar)
            if isSameCharacter {
                result += 1
            }
        }
        return result
    }
}
