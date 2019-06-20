# AnyFormatKit 1.0.0 Migration Guide

## Breaking Changes

### TextFormatterProtocol

- TextFormatterProtocol was renamed to TextFormatter 
- 'formattedText(from:)' method renamed to 'format()'
- 'unformattedText(from:)' method renamed to 'unformat()'

```swift
public protocol TextFormatter {
  func format(_ unformattedText: String?) -> String?
  func unformat(_ formattedText: String?) -> String?
}
```

### TextInputFormatterProtocol

- TextInputFormatterProtocol was renamed to TextInputFormatter
- now have only one method `swift formatInput(currentText:) `

```swift 
// protocol TextInputFormatterProtocol {
protocol TextInputFormatter {
```


