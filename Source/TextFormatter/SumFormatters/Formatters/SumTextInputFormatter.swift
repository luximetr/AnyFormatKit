//
//  SumTextInputFormatter.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 10.11.2017.
//  Copyright © 2017 Oleksandr Orlov. All rights reserved.
//

import Foundation

open class SumTextInputFormatter: TextInputFormatter, TextFormatter, TextUnformatter, TextNumberFormatter, TextNumberUnformatter, CaretPositioner {
    
    // MARK: - Dependencies
    
    private let textFormatter: SumTextFormatter
    private let caretPositionCalculator: SumTextInputFormatterCaretPositionCalculator
    
    // MARK: - Properties
    
    open var maximumIntegerCharacters: Int {
        set { textFormatter.maximumIntegerCharacters = newValue }
        get { textFormatter.maximumIntegerCharacters }
    }
    open var maximumDecimalCharacters: Int { textFormatter.maximumDecimalCharacters }
    open var prefix: String? { textFormatter.prefix }
    open var suffix: String? { textFormatter.suffix }
    open var groupingSeparator: String { textFormatter.groupingSeparator }
    open var decimalSeparator: String { textFormatter.decimalSeparator }
    open var groupingSize: Int { textFormatter.groupingSize }
    open var numberFormatter: NumberFormatter { textFormatter.numberFormatter }
    
    private let negativePrefix = "-"
    
    // MARK: - Life cycle
    /**
     Initializes formatter with patternString
     
     - Parameters:
     - textPattern: String with special characters, that will be used for formatting
     - patternSymbol: Optional parameter, that represent character, that will be replaced in formatted string
     */
    
    public init(numberFormatter: NumberFormatter) {
        caretPositionCalculator = SumTextInputFormatterCaretPositionCalculator(
            decimalSeparator: numberFormatter.decimalSeparator,
            suffix: numberFormatter.positiveSuffix,
            prefix: numberFormatter.positivePrefix
        )
        textFormatter = SumTextFormatter(numberFormatter: numberFormatter)
    }
    
    public init(textPattern: String, patternSymbol: Character = "#") {
        let formatter = SumTextFormatter(textPattern: textPattern, patternSymbol: patternSymbol)
        self.caretPositionCalculator = SumTextInputFormatterCaretPositionCalculator(
            decimalSeparator: formatter.decimalSeparator,
            suffix: formatter.suffix,
            prefix: formatter.prefix
        )
        self.textFormatter = formatter
    }
    
    // MARK: - TextInputFormatter
    
    open func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
        let unformattedCurrentText = textFormatter.unformat(currentText) ?? ""
        let unformattedRange = convertToUnformattedRange(currentText: currentText, unformattedCurrentText: unformattedCurrentText, range: range)
        let newUnformattedText = unformattedCurrentText.replacingCharacters(in: unformattedRange, with: text)
        let newFormattedText = format(newUnformattedText) ?? ""
        
        let caretOffset = caretPositionCalculator.calculateCaretOffset(range: range, replacementText: text, unformattedRange: unformattedRange, currentFormattedText: currentText, newFormattedText: newFormattedText, currentUnformattedText: unformattedCurrentText, newUnformattedText: newUnformattedText)
        return FormattedTextValue(formattedText: newFormattedText, caretBeginOffset: caretOffset)
    }
    
    // MARK: - TextFormatter
    
    open func format(_ unformatted: String?) -> String? {
        guard let unformatted = unformatted else { return nil }
        let minimumFractionDigits = calculateMinimumFractionDigits(unformatted: unformatted, divider: decimalSeparator, maximumFractionDigits: numberFormatter.maximumFractionDigits)
        numberFormatter.minimumFractionDigits = minimumFractionDigits
        
        let needAlwaysShowDecimalSeparator = minimumFractionDigits == 0 && unformatted.contains(decimalSeparator)
        numberFormatter.alwaysShowsDecimalSeparator = needAlwaysShowDecimalSeparator
        
        numberFormatter.minimumIntegerDigits = calculateMinimumIntegerDigits(unformatted: unformatted, decimalSeparator: decimalSeparator)
        if unformatted == decimalSeparator {
            return (prefix ?? "") + decimalSeparator + (suffix ?? "")
        } else {
            let correctedUnformatted = correctUnformatted(unformatted, maximumIntegerDigits: maximumIntegerCharacters, decimalSeparator: decimalSeparator, negativePrefix: negativePrefix)
            return textFormatter.format(correctedUnformatted)
        }
    }
    
    // MARK: - TextNumberFormatter
        
    open func format(_ number: NSNumber) -> String? {
        return textFormatter.format(number)
    }
    
    // MARK: - TextUnformatter
    
    open func unformat(_ formattedText: String?) -> String? {
        return textFormatter.unformat(formattedText)
    }
    
    // MARK: - TextNumberUnformatter
    
    open func unformatNumber(_ formattedText: String?) -> NSNumber? {
        return textFormatter.unformatNumber(formattedText)
    }
    
    // MARK: - CaretPositioner
        
    open func getCaretOffset(for text: String) -> Int {
        return caretPositionCalculator.calculateCaretPositionOffset(currentText: text)
    }
    
    // MARK: - Caclulation
    
    private func calculateMinimumFractionDigits(unformatted: String, divider: String, maximumFractionDigits: Int) -> Int {
        let currentFractionDigitsCount = getFractionDigitsCount(unformatted: unformatted, divider: divider)
        if currentFractionDigitsCount >= maximumFractionDigits { return maximumFractionDigits }
        return currentFractionDigitsCount
    }
    
    private func getFractionDigitsCount(unformatted: String, divider: String) -> Int {
        let parts = unformatted.components(separatedBy: divider)
        guard parts.count > 1 else { return 0 }
        return parts[1].count
    }
    
    private func calculateMinimumIntegerDigits(unformatted: String, decimalSeparator: String) -> Int {
        let isBeginFromDecimalSeparator = unformatted.hasPrefix(decimalSeparator)
        let hasIntegerPart = !isBeginFromDecimalSeparator
        if hasIntegerPart {
            return 1
        } else {
            return 0
        }
    }
    
    private func convertToUnformattedRange(currentText: String, unformattedCurrentText: String, range: NSRange) -> NSRange {
        let currentTextBeforeRangeLocation = currentText.leftSlice(limit: range.location)
        let unformattedTextBeforeRangeLocation = textFormatter.removeAllFormatSymbols(text: currentTextBeforeRangeLocation)
        
        let textLengthDifference = currentTextBeforeRangeLocation.count - unformattedTextBeforeRangeLocation.count
        var convertedRange = range
        
        convertedRange.location -= textLengthDifference
        if range.length > 0 {
            let rangeSlice = currentText.slice(from: range.location, length: range.length) ?? ""
            let uls = textFormatter.removeAllFormatSymbols(text: rangeSlice)
            convertedRange.length -= rangeSlice.count - uls.count
        }
        
        return convertedRange
    }
    
    // MARK: - Correct unformatted
    
    private func correctUnformatted(_ unformatted: String, maximumIntegerDigits: Int, decimalSeparator: String, negativePrefix: String) -> String {
        let decimalPart = unformatted.sliceBefore(substring: decimalSeparator)
        let floatingPart = unformatted.sliceAfter(substring: decimalSeparator)
        let correctedDecimalPart = correctUnformattedDecimalPart(decimalPart, maximumIntegerDigits: maximumIntegerDigits, negativePrefix: negativePrefix)
        if unformatted.contains(decimalSeparator) {
            return correctedDecimalPart + decimalSeparator + floatingPart
        } else {
            return correctedDecimalPart
        }
    }

    private func correctUnformattedDecimalPart(_ decimalPart: String, maximumIntegerDigits: Int, negativePrefix: String) -> String {
        if !negativePrefix.isEmpty && decimalPart.contains(negativePrefix) {
            return decimalPart.leftSlice(limit: maximumIntegerDigits + negativePrefix.count)
        } else {
            return decimalPart.leftSlice(limit: maximumIntegerDigits)
        }
    }
}
