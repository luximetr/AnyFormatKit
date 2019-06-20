# AnyFormatKit 1.0.0 Migration Guide

## Breaking Changes

### TextFormatterProtocol

- `TextFormatterProtocol` was renamed to `TextFormatter` 
- `formattedText(from:)` method renamed to `format()`
- `unformattedText(from:)` method renamed to `unformat()`

```swift
public protocol TextFormatter {
  func format(_ unformattedText: String?) -> String?
  func unformat(_ formattedText: String?) -> String?
}
```

### TextInputFormatterProtocol

- `TextInputFormatterProtocol` was renamed to `TextInputFormatter`
- now have only one method `formatInput(currentText:)`, how to use it look at [demo](https://github.com/luximetr/AnyFormatKit/tree/master/Example) project 

```swift 
protocol TextInputFormatter: TextFormatter {
  func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue
}
```

### TextFormatter

`TextFormatter` was renamed to `DefaultTextFormatter`

### TextInputFormatter 

- `TextInputFormatter` was renamed to `DefaultTextInputFormatter`
- `var allowedSymbolsRegex: String` was removed. Filter moved to separate pod (look at [Filter](https://github.com/luximetr/TextInputFilter))
- `shouldChangeTextIn(textInput:)` was removed (need to use `formatInput(currentText:)`)

### Removed classes

- `MulticastDelegate`
- `TextInput`
- `TextInputDelegate`
- `AttributedTextInputField`
- `AttributedTextInputView`
- `TextInputField`
- `TextInputFieldDelegate`
- `TextInputView`
- `TextInputViewDelegate`
- `TextInputController`
