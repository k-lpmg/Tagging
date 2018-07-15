# Tagging
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square)](https://raw.githubusercontent.com/k-lpmg/RealmWrapper/master/LICENSE) [![Cocoapods](https://img.shields.io/cocoapods/v/Tagging.svg?style=flat-square)](https://cocoapods.org/pods/Tagging)

✍️ TextView that provides a tagging feature to Mention or Hashtag.


## Introduction
[Tagging](https://github.com/k-lpmg/Tagging) is a UIView that encloses a TextView that contains an algorithm for tagging.
If you're worried about implementing `Mention` or `Hashtag` in your app, you can easily implement them using the library.

![taggingtooverwatchhero](https://user-images.githubusercontent.com/15151687/42734216-23087396-887b-11e8-9ad9-16975de922c8.gif)


## Getting Started

1. Add `Tagging` to the view as a subview.

2. Set the list that you want to tag and tag symbol to `Tagging`.
```swift
tagging.symbol = "#"
tagging.tagableList = ["DOOMFIST", "GENJI", "MCCREE", "PHARAH", "REAPER", "SOLDIER: 76", "SOMBRA", "TRACER", "BASTION", "HANZO", "JUNKRAT", "MEI", "TORBJORN", "WIDOWMAKER", "D.VA", "ORISA", "REINHARDT", "ROADHOG", "WINSTON", "ZARYA", "ANA", "BRIGITTE", "LUCIO", "MERCY", "MOIRA", "SYMMETRA", "ZENYATTA"]
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

You can use [CocoaPods](http://cocoapods.org/) to install `Tagging` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
pod 'Tagging'
end
```


## LICENSE

These works are available under the MIT license. See the [LICENSE][license] file
for more info.

[license]: LICENSE
