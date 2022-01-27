//
//  DefaultTextInputFormatter.swift
//
//  Created by Oleksandr Orlov on 12/14/18.
//  Copyright © 2018 Oleksandr Orlov. All rights reserved.
//

import Foundation

open class DefaultTextInputFormatter: TextInputFormatter, TextFormatter, TextUnformatter {
    
    // MARK: - Dependencies
    
    private let caretPositionCorrector: DefaultCaretPositionCorrector
    private let textFormatter: DefaultTextFormatter
    private let rangeCalculator: DefaultRangeCalculator
    
    // MARK: - Properties
    
    private var textPattern: String { textFormatter.textPattern }
    private var patternSymbol: Character { textFormatter.patternSymbol }
    
    // MARK: - Life cycle
    /**
     Initializes formatter with patternString
     
     - Parameters:
     - textPattern: String with special characters, that will be used for formatting
     - patternSymbol: Optional parameter, that represent character, that will be replaced in formatted string
     - prefix: String, that always will be at beggining of text during editing
     */
    public init(
        textPattern: String,
        patternSymbol: Character = "#"
    ) {
        self.caretPositionCorrector = DefaultCaretPositionCorrector(
            textPattern: textPattern,
            patternSymbol: patternSymbol
        )
        self.textFormatter = DefaultTextFormatter(
            textPattern: textPattern,
            patternSymbol: patternSymbol
        )
        self.rangeCalculator = DefaultRangeCalculator()
    }
    
    // MARK: - TextInputFormatter
    
    open func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
        guard let swiftRange = Range(range, in: currentText) else { return .zero }
        
        let oldUnformattedText = textFormatter.unformat(currentText) ?? ""
        
        let unformattedCurrentTextRange = rangeCalculator.unformattedRange(
            currentText: currentText,
            textPattern: textPattern,
            from: swiftRange,
            patternSymbol: patternSymbol
        )
        let unformattedRange = oldUnformattedText.getSameRange(
            asIn: currentText,
            sourceRange: unformattedCurrentTextRange
        )
        
        let newText = oldUnformattedText.replacingCharacters(
            in: unformattedRange,
            with: text
        )
        
        let formattedText = textFormatter.format(newText) ?? ""
        let formattedTextRange = formattedText.getSameRange(
            asIn: currentText,
            sourceRange: swiftRange
        )
        
        let caretOffset = getCorrectedCaretPosition(
            newText: formattedText,
            range: formattedTextRange,
            replacementString: text
        )
        
        return FormattedTextValue(
            formattedText: formattedText,
            caretBeginOffset: caretOffset
        )
    }
    
    // MARK: - TextFormatter
    
    open func format(_ unformattedText: String?) -> String? {
        return textFormatter.format(unformattedText)
    }
    
    // MARK: - TextUnformatter
    
    open func unformat(_ formatted: String?) -> String? {
        return textFormatter.unformat(formatted)
    }
    
    // MARK: - Private
    
    /**
     Convert range in formatted string to range in unformatted string
     
     - Parameters:
     - range: Range in formatted (with current textPattern) string
     
     - Returns: Range in unformatted (with current textPattern) string
     */
    
    // MARK: - Caret position calculation
    
    private func getCorrectedCaretPosition(newText: String, range: Range<String.Index>, replacementString: String) -> Int {
        return caretPositionCorrector.calculateCaretPositionOffset(
            newText: newText,
            originalRange: range,
            replacementText: replacementString
        )
    }
    
}
