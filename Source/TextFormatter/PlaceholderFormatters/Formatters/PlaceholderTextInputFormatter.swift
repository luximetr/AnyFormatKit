//
//  PlaceholderTextInputFormatter.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

open class PlaceholderTextInputFormatter: TextInputFormatter, TextFormatter, TextUnformatter, CaretPositioner {
    
    // MARK: - Dependencies
    
    private let caretPositionCorrector: PlaceholderCaretPositionCalculator
    private let textFormatter: PlaceholderTextFormatter
    private let rangeCalculator: PlaceholderRangeCalculator
    
    // MARK: - Properties
    
    var textPattern: String { textFormatter.textPattern }
    var patternSymbol: Character { textFormatter.patternSymbol }
    
    // MARK: - Life cycle
    
    public init(
        textPattern: String,
        patternSymbol: Character = "#"
    ) {
        self.caretPositionCorrector = PlaceholderCaretPositionCalculator(
            textPattern: textPattern,
            patternSymbol: patternSymbol
        )
        self.textFormatter = PlaceholderTextFormatter(
            textPattern: textPattern,
            patternSymbol: patternSymbol
        )
        self.rangeCalculator = PlaceholderRangeCalculator()
    }
    
    // MARK: - TextInputFormatter
    
    open func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
        guard let swiftRange = Range(range, in: currentText) else { return .zero }
        let oldUnformattedText = textFormatter.unformat(currentText) ?? ""
        
        let unformattedCurrentTextRange = rangeCalculator.unformattedRange(currentText: currentText, textPattern: textPattern, from: swiftRange)
        let unformattedRange = oldUnformattedText.getSameRange(asIn: currentText, sourceRange: unformattedCurrentTextRange)
        
        let newText = oldUnformattedText.replacingCharacters(in: unformattedRange, with: text)
        
        let formattedText = textFormatter.format(newText) ?? ""
        let formattedTextRange = formattedText.getSameRange(asIn: currentText, sourceRange: swiftRange)
        
        let caretOffset = getCorrectedCaretPosition(newText: formattedText, range: formattedTextRange, replacementString: text)
        
        return FormattedTextValue(formattedText: formattedText, caretBeginOffset: caretOffset)
    }
    
    open func getCaretOffset(for text: String) -> Int {
        return caretPositionCorrector.calculateCaretPositionOffset(currentText: text)
    }
    
    // MARK: - TextFormatter
    
    open func format(_ unformattedText: String?) -> String? {
        return textFormatter.format(unformattedText)
    }
    
    // MARK: - TextUnformatter
    
    open func unformat(_ formattedText: String?) -> String? {
        return textFormatter.unformat(formattedText)
    }
    
    // MARK: - Caret position calculation
    
    private func getCorrectedCaretPosition(newText: String, range: Range<String.Index>, replacementString: String) -> Int {
        return caretPositionCorrector.calculateCaretPositionOffset(
            newText: newText,
            originalRange: range,
            replacementText: replacementString
        )
    }
    
}
