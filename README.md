![AnyFormatKit: Simple text formatting in Swift](Assets/anyformatkit.jpeg)


[![CI Status](http://img.shields.io/travis/luximetr/AnyFormatKit.svg?style=flat)](https://travis-ci.org/luximetr/AnyFormatKit)
[![Pod Version](https://img.shields.io/cocoapods/v/AnyFormatKit.svg?style=flat)](http://cocoapods.org/pods/AnyFormatKit)
[![License](https://img.shields.io/cocoapods/l/AnyFormatKit.svg?style=flat)](http://cocoapods.org/pods/AnyFormatKit)
[![Platform](https://img.shields.io/cocoapods/p/AnyFormatKit.svg?style=flat)](http://cocoapods.org/pods/AnyFormatKit)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
![Swift](https://img.shields.io/badge/%20in-swift%205.0-brightgreen.svg)

Text formatting framework written on Swift 5.0.

## Features

| |Features |
|-------------------|------------------------------------------------------------|
:performing_arts:| Convert string into formatted string and vice versa
:bicyclist:| Formatting text during typing
:hash:| Set format using '#' characters like '### ##-###'
:stuck_out_tongue:| Supporting emojis
:heavy_dollar_sign:| Formatting money amount
:parking:| Formatting with placeholders
:seedling:| UITextField and UITextView support


## Example

To run the example project, clone the repo and run `pod install` from the Example directory first.

## Demo

![Phone number example](Assets/example_phone_number.gif)

![Currency example](Assets/example_sum.gif)

![Card number example](Assets/example_card_number.gif)

![Placeholder number number example](Assets/example_placeholder_phone_number.gif)

## Requirements

- iOS 8.0+
- Swift 4.0+
- Xcode 9.0+

## SwiftUI

AnyFormatKit has SwiftUI version, that exists as separate framework [AnyFormatKitSwiftUI](https://github.com/luximetr/AnyFormatKitSwiftUI)

## Migration Guides

- [AnyFormatKit 0.2.0 MigrationGuide](Documentation/AnyFormatKit%200.2.0%20MigrationGuide.md)
- [AnyFormatKit 1.0.0 MigrationGuide](Documentation/AnyFormatKit%201.0.0%20MigrationGuide.md)
- [AnyFormatKit 2.4.0 MigrationGuide](Documentation/AnyFormatKit%202.4.0%20MigrationGuide.md)

## Installation

### CocoaPods

AnyFormatKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AnyFormatKit', '~> 2.5.2'
```

Then, run the following command:

```bash
$ pod install
```

### Swift Package Manager
AnyFormatKit is available with [Swift Package Manager](https://swift.org/package-manager/). 
Once you have your Swift package set up, than simply add AnyFormatKit to the `dependencies` value of your `Package.swift`

```swift
dependencies: [
    .package(url: "https://github.com/luximetr/AnyFormatKit.git", .upToNextMajor(from: "2.5.2"))
]
```

## Usage

### Import

```swift
import AnyFormatKit
```

#### Formatting with TextFormatter

```swift
let phoneFormatter = DefaultTextInputFormatter(textPattern: "### (###) ###-##-##")
let phoneInputController = TextFieldInputController()

textField.delegate = phoneInputController
phoneInputController.formatter = phoneFormatter
```

#### Get only your input
```swift
phoneNumberFormatter.unformat("+51 (013) 442-55-11") // +51013442551 
```

#### In case you want to use `textField.delegate` by yourself 

```swift
let phoneFormatter = DefaultTextInputFormatter(textPattern: "### (###) ###-##-##")

// inside of UITextFieldDelegate shouldChangeTextIn method
let result = formatter.formatInput(currentText: textField.text ?? "", range: range, replacementString: string)
textField.text = result.formattedText
textField.setCursorLocation(result.caretBeginOffset)
```

> You can find example of `setCursorLocation` [here](Source/Extensions/UITextField%2BExtension.swift) 

### Formatter kinds

- `DefaultTextInputFormatter` - formatting [symbol by symbol](Assets/example_phone_number.gif)
- `SumTextInputFormatter` - formatting like a [money format](Assets/example_sum.gif)
- `PlaceholderTextInputFormatter` - formatting with all textPattern as [placeholder](Assets/example_placeholder_phone_number.gif)

## Author

luximetr, luximetr.notification@gmail.com

### Say thank you

<a href="https://paypal.me/luximetr/"><img src="https://github.com/andreostrovsky/donate-with-paypal/blob/master/PNG/blue.png" height="40"></a>

## License

AnyFormatKit is available under the MIT license. See the LICENSE file for more info.
