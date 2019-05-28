# AnyFormatKit 0.2.0 Migration Guide

## Breaking Changes

### SumTextFormatter

#### Maximum Decimal Characters

Variable, that allowed to input limited number of characters after decimal separator now get-only.

```swift
// open var maximumDecimalCharacters: Int = 2
open var maximumDecimalCharacters: Int {
  return numberFormatter.maximumFractionDigits
}
```
Now maximumFractionDigits parse from format (number of '#' after decimal separator).

```swift
SumTextInputFormatter(textPattern: "#.###,#### $") // 4 '#' after ',' - maximumFractionDigits
```

#### Number of characters in group

Variable. that allow control number of characters in group now get-only.

```swift
// var numberOfCharactersInGroup = 3
open var numberOfCharactersInGroup: Int {
  return numberFormatter.groupingSize
}
```
Now numberOfCharactersInGroup parse from format (number of '#' between grouping separator and decimal separator).

```swift
SumTextInputFormatter(textPattern: "#.###,#### $") // 3 '#' between '.' and ',' - numberOfCharactersInGroup
```

## Updates 

#### Format input method

func formatInput() - method, that format text and return it as result with new caret offset. Now TextInputFormatter use this method in shouldChangeTextIn() by default.

```swift
func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue
```

#### FormattedTextValue

FormattedTextValue is a tuple, that use for return formatted text and caret offset from begin from input formatter.

```swift
public typealias FormattedTextValue = (formattedText: String, caretBeginOffset: Int)
```

#### NumberFormatter

Now sum text formatter use NumberFormatter under the hood.

```swift
private let numberFormatter: NumberFormatter
```
Was added init method with number formatter. Old init method still works.

```swift
public init(numberFormatter: NumberFormatter) {
  self.numberFormatter = numberFormatter
}
```
