# LiquidFloatingActionButton

[![CI Status](http://img.shields.io/travis/yoavlt/LiquidFloatingActionButton.svg?style=flat)](https://travis-ci.org/yoavlt/LiquidFloatingActionButton)
[![Version](https://img.shields.io/cocoapods/v/LiquidFloatingActionButton.svg?style=flat)](http://cocoapods.org/pods/LiquidFloatingActionButton)
[![License](https://img.shields.io/cocoapods/l/LiquidFloatingActionButton.svg?style=flat)](http://cocoapods.org/pods/LiquidFloatingActionButton)
[![Platform](https://img.shields.io/cocoapods/p/LiquidFloatingActionButton.svg?style=flat)](http://cocoapods.org/pods/LiquidFloatingActionButton)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)]
(https://github.com/Carthage/Carthage)

LiquidFloatingActionButton is floating action button component of [material design](https://www.google.com/design/spec/material-design/introduction.html) in liquid state, inspired by [Material In a Liquid State](http://www.materialup.com/posts/material-in-a-liquid-state).
This is also [spinner loader](https://github.com/yoavlt/LiquidLoader) components in liquid state.

![Demo](https://github.com/yoavlt/LiquidFloatingActionButton/blob/master/Demo/top.gif?raw=true)

## Features
- [x] liquid animation
- [x] easily custoizable
- [x] Objective-C compatible

You can play a demo with [appetize.io](https://appetize.io/app/f4t42hgqbnbma4m12jcg3aeebg?device=iphone5s&scale=75&orientation=portrait)

## Requirements
- Swift 2.0 is required. The swift-old branch has swift 1.0 compatibility but does not include the icon customization feature

## Usage

You just need implement `LiquidFloatingActionButtonDataSource` and `LiquidFloatingActionButtonDelegate` similar to well-known UIKit design.

```swift
let floatingActionButton = LiquidFloatingActionButton(frame: floatingFrame)
floatingActionButton.dataSource = self
floatingActionButton.delegate = self
```

This fork also allows the use of setting each icon's color intuitively.

``` swift
let floatingActionButton = LiquidFloatingActionButton(frame: floatingFrame)
floatingActionButton.dataSource = self
floatingActionButton.delegate = self

// Button 1 will become a red color!
let button1 = LiquidFloatingCell(icon: UIImage(named: iconNameThatExists)!)
button1.color = UIColor.redColor()

// Button 2 defaults to the floatingActionButton's color.
let button2 = LiquidFloatingCell(icon: UIImage(named: iconNameThatExists)!)
```

This will let you have colored animations:

![Demo](https://github.com/shotaroikeda/LiquidFloatingActionButton/blob/swift-2.0/Demo/colored_example.gif?raw=true)

See the [example](https://github.com/shotaroikeda/LiquidFloatingActionButton/blob/swift-2.0/Example/LiquidFloatingActionButton/ViewController.swift#L97-L105) for more details.



### LiquidFloatingActionButtonDataSource
* func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int
* func cellForIndex(index: Int) -> LiquidFloatingCell

### LiquidFloatingActionButtonDelegate
* optional func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int)

## Easily customizable
![Demo](https://github.com/yoavlt/LiquidFloatingActionButton/blob/master/Demo/customizable.gif?raw=true)

## Installation

LiquidFloatingActionButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LiquidFloatingActionButton", :git => "https://github.com/shotaroikeda/LiquidFloatingActionButton"
```
or, if you use [Carthage](https://github.com/Carthage/Carthage), add the following line to your `Carthage` file.
```
github "shotaroikeda/LiquidFloatingActionButton"
```

## License

LiquidFloatingActionButton is available under the MIT license. See the LICENSE file for more info.
