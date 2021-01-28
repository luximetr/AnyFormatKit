#!/bin/bash
xcodebuild -project AnyFormatKit.xcodeproj -scheme "AnyFormatKit" -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 12 Pro Max,OS=14.3' test
