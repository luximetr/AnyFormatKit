#!/bin/bash
xcodebuild -workspace AnyFormatKit.xcworkspace -scheme "AnyFormatKit" -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone XS Max,OS=12.1' test