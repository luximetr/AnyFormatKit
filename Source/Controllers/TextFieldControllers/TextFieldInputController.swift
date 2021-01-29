//
//  TextFieldInputController.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

open class TextFieldInputController: NSObject, UITextFieldDelegate {
    
    // MARK: - Dependencies
    
    open var formatter: TextInputFormatter?
    
    // MARK: - Actions
    
    open var onEditingBegan: AnyFormatTextAction?
    open var onEditingEnd: AnyFormatTextAction?
    open var onTextChange: AnyFormatTextAction?
    open var onClear: AnyFormatVoidAction?
    open var onReturn: AnyFormatVoidAction?
    
    // MARK: - UITextFieldDelegate
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let formatter = formatter else { return true }
        let result = formatter.formatInput(
            currentText: textField.text ?? "",
            range: range,
            replacementString: string
        )
        let currentText = textField.text
        let newText = result.formattedText
        textField.text = newText
        textField.setCursorLocation(result.caretBeginOffset)
        notifyTextChangedIfNeeded(currentText: currentText, newText: newText)
        return false
    }
    
    private func notifyTextChangedIfNeeded(currentText: String?, newText: String) {
        guard let currentText = currentText, currentText != newText else { return }
        onTextChange?(newText)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        onEditingBegan?(textField.text)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        onEditingEnd?(textField.text)
    }
    
    @available(iOS 10.0, *)
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        onEditingEnd?(textField.text)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        onClear?()
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.onReturn?()
        return true
    }
}
