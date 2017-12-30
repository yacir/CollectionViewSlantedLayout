# CollectionViewSlantedLayout

[![Version](https://img.shields.io/cocoapods/v/CollectionViewSlantedLayout.svg?style=flat)](http://cocoapods.org/pods/CollectionViewSlantedLayout)
[![SPM](https://img.shields.io/badge/SPM-ready-orange.svg)]()
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Version](https://img.shields.io/badge/Swift-4.0-orange.svg)]()
[![Build Status](https://travis-ci.org/yacir/CollectionViewSlantedLayout.svg?branch=master)](https://travis-ci.org/yacir/CollectionViewSlantedLayout)
[![codecov](https://codecov.io/gh/yacir/CollectionViewSlantedLayout/branch/master/graph/badge.svg)](https://codecov.io/gh/yacir/CollectionViewSlantedLayout)
[![Platform](https://img.shields.io/cocoapods/p/CollectionViewSlantedLayout.svg?style=flat)](http://cocoapods.org/pods/CollectionViewSlantedLayout)
[![License](https://img.shields.io/cocoapods/l/CollectionViewSlantedLayout.svg?style=flat)](http://cocoapods.org/pods/CollectionViewSlantedLayout)

## Overview
CollectionViewSlantedLayout is a subclass of UICollectionViewLayout allowing the display of slanted content on UICollectionView.

<p align="center">
  	<img src="https://cloud.githubusercontent.com/assets/2587473/13427516/d9af399e-dfb4-11e5-8109-ae997dc7c340.gif" alt="CollectionViewSlantedLayout" title="CollectionViewSlantedLayout"> 
</p>

## Usage

CollectionViewSlantedLayout contains six properties to customize the interface.

```swift
var slantingDelta: UInt
var slantingDirection: SlantingDirection
var firstCellSlantingEnabled: Bool
var lastCellSlantingEnabled: Bool
var lineSpacing: CGFloat
var scrollDirection: UICollectionViewScrollDirection
var itemSize: CGFloat
```

- _slantingDelta_ is the slanting delta.  Defaults to `75`
- _slantingDirection_ allows to set slanting direction. Defaults to `.upward`
- _firstCellSlantingEnabled_ allows to enable the slanting for the first cell. By default, this property is set to `true`
- _lastCellSlantingEnabled_ allows to enable the slanting for the last cell. By default, this property is set to `true`
- _lineSpacing_ is the spacing to use between two items. Defaults to `10.0`
- _scrollDirection_ is the scroll direction. Defaults to `.vertical`
- _itemSize_ allows to set the item's defaulf width/height depending on the scroll direction if the delegate does not implement the collectionView(_:layout:sizeForItemAt:) method. Defaults to `225`

### Apply the slanting mask 

To apply the slanting mask on the cellView, use the `CollectionViewSlantedCell` or subclass it.

## Installation

### CocoaPods
CollectionViewSlantedLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CollectionViewSlantedLayout", '~> 3.0'
```

### Carthage

You can also install it via [Carthage](https://github.com/Carthage/Carthage). To do so, add the following to your Cartfile:

```terminal
github 'yacir/CollectionViewSlantedLayout'
```

## Roadmap
- [x] Improve the attribution of the clic
- [x] Carthage support
- [x] Tests
- [x] Swift 3 support
- [x] Swift Package Manager support
- [x] Use delegate method to implent dynamic items sizes.

## Author

[Yassir Barchi](https://linkedin.com/in/yassir-barchi-318a7949)

## Acknowledgement

This framework is inspired by [this prototype](https://dribbble.com/shots/1727594-Slanted-Table-Cells-With-Parallax?_=1456679145403) released by [Matt Bridges](https://dribbble.com/rrridges).


## License

CollectionViewSlantedLayout is available under the MIT license. See the LICENSE file for more info.
