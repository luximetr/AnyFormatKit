//
//  PlaceholderCaretPositionCalculator.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 25.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import Foundation

class PlaceholderCaretPositionCalculator {
    
    // MARK: - Properties
    let textPattern: String
    let patternSymbol: Character
    private let defaultFormatter: DefaultTextFormatter
    
    // MARK: - Life Cycle
    init(textPattern: String, patternSymbol: Character) {
        self.textPattern = textPattern
        self.patternSymbol = patternSymbol
        self.defaultFormatter = DefaultTextFormatter(textPattern: textPattern, patternSymbol: patternSymbol)
    }
    
    func calculateCaretPositionOffset(newText: String, originalRange range: Range<String.Index>, replacementText: String) -> Int {
        var offset = 0
        if replacementText.isEmpty {
            offset = offsetForRemove(newText: newText, lowerBound: range.lowerBound)
        } else {
            offset = offsetForInsert(newText: newText, lowerBound: range.lowerBound, replacementLength: replacementText.count)
        }
        return offset
    }
    
    private func offsetForRemove(newText: String, lowerBound: String.Index) -> Int {
        let textPatternLowerBound = textPattern.getSameIndex(asIn: newText, sourceIndex: lowerBound)
        let textPatternIndex = textPattern.findIndexBefore(of: patternSymbol, startFrom: textPatternLowerBound)
        let index = newText.getSameIndex(asIn: textPattern, sourceIndex: textPatternIndex)
        let leftSlice = newText.leftSlice(end: index)
        return leftSlice.utf16.count
    }
    
    private func offsetForInsert(newText: String, lowerBound: String.Index, replacementLength: Int) -> Int {
        let textPatternLowerBound = textPattern.getSameIndex(asIn: newText, sourceIndex: lowerBound)
        let textPatternIndex = textPattern.findIndex(of: patternSymbol, skipFirst: replacementLength, startFrom: textPatternLowerBound)
        let index = newText.getSameIndex(asIn: textPattern, sourceIndex: textPatternIndex)
        let leftSlice = newText.leftSlice(end: index)
        let textPatternLeftSlice = textPattern.leftSlice(end: textPatternIndex)
        let diff = getStringRemovingMatches(at: leftSlice, toMatch: textPatternLeftSlice)
        return diff.utf16.count
    }
    
    private func getStringRemovingMatches(at string: String, toMatch: String) -> String {
        guard string != toMatch else { return "" }
        var stringIndex = string.index(before: string.endIndex)
        var toMatchIndex = toMatch.index(before: toMatch.endIndex)
        while stringIndex > string.startIndex && toMatchIndex > toMatch.startIndex {
            let stringChar = string[stringIndex]
            let toMatchChar = toMatch[toMatchIndex]
            if stringChar != toMatchChar {
                break
            }
            stringIndex = string.index(before: stringIndex)
            toMatchIndex = toMatch.index(before: toMatchIndex)
        }
        let slice = string.leftSlice(end: string.index(after: stringIndex))
        return slice
    }
    
    private func findLatestDiffIndex(text1: String, text2: String) -> String.Index? {
        var text1Index = text1.index(before: text1.endIndex)
        var text2Index = text2.getSameIndex(asIn: text1, sourceIndex: text1Index)
        while text1Index > text1.startIndex && text2Index > text2.startIndex {
            let text1Char = text1[text1Index]
            let text2Char = text2[text2Index]
            if text1Char != text2Char {
                return text1Index
            }
            text1Index = text1.index(before: text1Index)
            text2Index = text2.index(before: text2Index)
        }
        return nil
    }
}
