# TextDrawer
![Version Status](http://img.shields.io/cocoapods/v/TextDrawer.png) ![license MIT](http://img.shields.io/badge/license-MIT-orange.png) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

*TextDrawer, is a UIView allows you to add text, with gesture, on UIView, or UIImage.*

## About

Annotating Images

TextDrawer is the easiest way to add text to `UIImage` with a touch interface. You can add text, with resizable, move, and rotate gesture with `UIGestureRecognizer`.
With TextDrawer, it's easily save the notes on top of a `UIImage`.

## Requirements

* iOS 8
* Swift 1.2

## Installation

#### [CocoaPods](http://cocoapods.org)

````ruby
use_frameworks!
pod 'TextDrawer', '~> 1.0.6'
````

#### [Carthage](https://github.com/Carthage/Carthage)

````bash
github "remirobert/TextDrawer"
````

#### Manually

1. Clone this repo and add the `TextDrawer/TextDrawer.xcodeproj` to your project
2. Select your project app target "Build Phases" tab
3. Add the `TextDrawer.framework` to the "Link Binary With Libraries"  
4. Create a new build phase of type "Copy Files" and set the "Destination" to "Frameworks"
5. Add the `TextDrawer.framework` and check "Code Sign On Copy"

For an example, see the demo project included in this repo.
To run the example project, clone the repo, and run `pod install` from the Example directory.

## Getting Started

````swift
import TextDrawer
````

##### Design

This framework is composed on different parts.
The first one is the `TextEditView`. It allows you to edit the text. it is composed of a `UITextView`, and manage the keyboard notifications.
Next, `DrawTextView`, is a `UIView`, showing your text in the view.
And, `TextDrawer`, it contains the above views. Tt allows to configure some parameter (like font, size, color, etc ...). All the gestures are managed here.

