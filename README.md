# Tagging
[![Build Status](https://travis-ci.org/k-lpmg/Tagging.svg?branch=master)](https://travis-ci.org/k-lpmg/Tagging)
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![Cocoapods](https://img.shields.io/cocoapods/v/Tagging.svg?style=flat)](https://cocoapods.org/pods/Tagging)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A TextView that provides easy to use tagging feature for Mention or Hashtag.


## Introduction
[Tagging](https://github.com/k-lpmg/Tagging) is a UIView that encloses a TextView that contains an algorithm for tagging.
If you're worried about implementing `Mention` or `Hashtag` in your app, you can easily implement them using the library.

![tagging](https://user-images.githubusercontent.com/15151687/43359597-9be98a16-92df-11e8-8bda-4719502bd907.gif)


## Getting Started

1. Add `Tagging` to the view as a subview.

2. Set the list that you want to tag and tag symbol to `Tagging`.
```swift
tagging.symbol = "#"
tagging.tagableList = ["DOOMFIST", "GENJI", "MCCREE", "PHARAH", "REAPER", "SOLDIER:76", "SOMBRA", "TRACER", "BASTION", "HANZO", "JUNKRAT", "MEI", "TORBJORN", "WIDOWMAKER", "D.VA", "ORISA", "REINHARDT", "ROADHOG", "WINSTON", "ZARYA", "ANA", "BRIGITTE", "LUCIO", "MERCY", "MOIRA", "SYMMETRA", "ZENYATTA"]
```

3. Implement TaggingDataSource on the class that added the `Tagging`.
```swift
tagging.dataSource = self
```

3. Get tagable list and tagged list through `TaggingDataSource`.
```swift
func tagging(_ tagging: Tagging, didChangedTagableList tagableList: [String]) {
    matchedList = tagableList
}

func tagging(_ tagging: Tagging, didChangedTaggedList taggedList: [TaggingModel]) {
    self.taggedList = taggedList
}
```


## Usage

#### Tagging Property

| Property | Type | Description |
| --- | --- | --- |
| `cornerRadius` | `CGFloat` | Corner radius |
| `borderWidth` | `CGFloat` | Border width |
| `borderColor` | `CGColor` | Border color |
| `textInset` | `UIEdgeInsets` | Text inset |
| `backgroundColor` | `UIColor` | Background color |
| `symbol` | `String` | Tagging symbol |
| `tagableList` | `[String]` | Tagable list |
| `defaultAttributes` | `[NSAttributedStringKey: Any]` | Default attributes for all range attributedText of Textview |
| `symbolAttributes` | `[NSAttributedStringKey: Any]` | Aattributes for symbol text |
| `taggedAttributes` | `[NSAttributedStringKey: Any]` | Attributes for tagged text |


## Installation

#### CocoaPods (iOS 8+)

```ruby
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Tagging'
end
```

#### Carthage (iOS 8+)

```ruby
github "k-lpmg/Tagging"
```


## LICENSE

These works are available under the MIT license. See the [LICENSE][license] file
for more info.

[license]: LICENSE
