# YBSlantedCollectionViewLayout

[![Version](https://img.shields.io/cocoapods/v/YBSlantedCollectionViewLayout.svg?style=flat)](http://cocoapods.org/pods/YBSlantedCollectionViewLayout)
[![License](https://img.shields.io/cocoapods/l/YBSlantedCollectionViewLayout.svg?style=flat)](http://cocoapods.org/pods/YBSlantedCollectionViewLayout)
[![Platform](https://img.shields.io/cocoapods/p/YBSlantedCollectionViewLayout.svg?style=flat)](http://cocoapods.org/pods/YBSlantedCollectionViewLayout)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Overview
YBSlantedCollectionViewLayout is a subclass of UICollectionViewLayout allowing the display of slanted content on UICollectionView.

## [Live Demo] (https://appetize.io/app/nd8vgwg0rkke19nmw3wzkapr5g)

<p align="center" >
  	<img src="https://cloud.githubusercontent.com/assets/2587473/13427516/d9af399e-dfb4-11e5-8109-ae997dc7c340.gif" alt="YBSlantedCollectionViewLayout" title="YBSlantedCollectionViewLayout"> 
</p>

## Usage

YBSlantedCollectionViewLayout contains six properties to customize the interface.

```swift
var slantingDelta: UInt
var reverseSlantingAngle: Bool
var firstCellSlantingEnabled: Bool
var lastCellSlantingEnabled: Bool
var lineSpacing: CGFloat
var scrollDirection: UICollectionViewScrollDirection
var itemSizeOptions: YBSlantedCollectionViewLayoutSizeOptions
```

- _slantingDelta_ is the slanting delta.  Defaults to 50
- _reverseSlantingAngle_ allows to reverse the slanting angle if the value is `true`. By default, this property is set to `false`
- _firstCellSlantingEnabled_ allows to enable the slanting for the first cell. By default, this property is set to `true`
- _lastCellSlantingEnabled_ allows to enable the slanting for the last cell. By default, this property is set to `true`
- _lineSpacing_ is the spacing to use between two items. Defaults to 10.0
- _scrollDirection_ is the scroll direction. Defaults to `UICollectionViewScrollDirectionVertical`
- _itemSizeOptions_ allows to set the item's width/height depending on the scroll direction.

### Apply the slanting mask 

To apply the slanting mask on the cellView, use the `YBSlantedCollectionViewCell` or subclass it.

## Installation

### CocoaPods
YBSlantedCollectionViewLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YBSlantedCollectionViewLayout", '~> 2.0'
```

### Carthage

You can also install it via [Carthage](https://github.com/Carthage/Carthage). To do so, add the following to your Cartfile:

```terminal
github 'yacir/YBSlantedCollectionViewLayout'
```

## Roadmap
- [x] Improve the attribution of the clic
- [x] Carthage support
- [] Tests

## Author

[Yassir Barchi](https://linkedin.com/in/yassir-barchi-318a7949)

## Acknowledgement

This framework is inspired by [this prototype](https://dribbble.com/shots/1727594-Slanted-Table-Cells-With-Parallax?_=1456679145403) released by [Matt Bridges](https://dribbble.com/rrridges).


## License

YBSlantedCollectionViewLayout is available under the MIT license. See the LICENSE file for more info.
