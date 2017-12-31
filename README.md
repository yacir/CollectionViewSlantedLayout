<p align="center">
    <img src="https://cdn.rawgit.com/yacir/CollectionViewSlantedLayout/3b5e08c1/Resources/SlantedLayout.svg" alt="CollectionViewSlantedLayout" title="CollectionViewSlantedLayout" width="700"/>
</p>

**CollectionViewSlantedLayout** is a subclass of the [UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout) allowing the display of slanted cells in a [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview).


[![Version](https://img.shields.io/cocoapods/v/CollectionViewSlantedLayout.svg?style=flat)](http://cocoapods.org/pods/CollectionViewSlantedLayout)
[![SPM](https://img.shields.io/badge/SPM-ready-orange.svg)]()
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Version](https://img.shields.io/badge/Swift-4.0-orange.svg)]()
[![Build Status](https://travis-ci.org/yacir/CollectionViewSlantedLayout.svg?branch=master)](https://travis-ci.org/yacir/CollectionViewSlantedLayout)
[![codecov](https://codecov.io/gh/yacir/CollectionViewSlantedLayout/branch/master/graph/badge.svg)](https://codecov.io/gh/yacir/CollectionViewSlantedLayout)
[![Platform](https://img.shields.io/cocoapods/p/YBSlantedCollectionViewLayout.svg?style=flat)](http://cocoapods.org/pods/CollectionViewSlantedLayout)
[![License](https://img.shields.io/cocoapods/l/YBSlantedCollectionViewLayout.svg?style=flat)](http://cocoapods.org/pods/CollectionViewSlantedLayout)


<p align="center">
  	<img src="https://user-images.githubusercontent.com/2587473/34458447-9f434c8a-edd3-11e7-98b7-f32b4284268d.gif" alt="CollectionViewSlantedLayout" title="CollectionViewSlantedLayout"> 
</p>

## Features
- [x] Pure Swift 4.
- [x] Works with every UICollectionView.
- [x] Horizontal and vertical scrolling support.
- [x] Dynamic cells height
- [x] Fully Configurable

## Installation

### CocoaPods
CollectionViewSlantedLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
use_frameworks!
pod "CollectionViewSlantedLayout", '~> 3.0'
```

### Carthage

You can also install it via [Carthage](https://github.com/Carthage/Carthage). To do so, add the following to your Cartfile:

```terminal
github 'yacir/CollectionViewSlantedLayout'
```

## Usage

1. Import `CollectionViewSlantedLayout ` module to your controller

    ```swift
    import CollectionViewSlantedLayout
    ```
    
2. Create an instance and add it to your `UICollectionView`.

    ```swift
	let slantedSayout = CollectionViewSlantedLayout()
	UICollectionView(frame: .zero, collectionViewLayout: slantedSayout)
    ```
    
3. Use the `CollectionViewSlantedCell` class for your cells or subclass it.


Find a demo in the Examples folder.

## Properties

- **slantingSize**:

	```swift
	@IBInspectable var slantingSize: UInt
	```
	The slanting size. The default value of this property is `75`.

- **slantingDirection**:
	
	```swift
	var slantingDirection: SlantingDirection
	```
	The slanting direction. The default value of this property is `upward`.
	
- **slantingAngle**:

	```swift
	fileprivate(set) var slantingAngle: CGFloat
	```
	The angle, in radians, of the slanting. The value of this property could be used to apply a rotation transform on the cell's contentView in the `collectionView(_:cellForItemAt:)` method implementation.
	     
	```swift
	if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
		cell.contentView.transform = CGAffineTransform(rotationAngle: layout.rotationAngle)
	}
	```
- **scrollDirection**:
	
	```swift
	var scrollDirection: UICollectionViewScrollDirection
	```
	The scroll direction of the grid. The grid layout scrolls along one axis only, either horizontally or vertically. The default value of this property is `vertical`.
	
- **isFistCellExcluded**:
	
	```swift
	@IBInspectable var isFistCellExcluded: Bool
	```
	Allows to disable the slanting for the first cell. Set it to `true` to disable the slanting for the first cell. The default value of this property is `false`.
	
- **isLastCellExcluded**:
	
	```swift
	@IBInspectable var isLastCellExcluded: Bool
	```
	Allows to disable the slanting for the last cell. Set it to `true` to disable the slanting for the last cell. The default value of this property is `false`.
	
- **lineSpacing**:
	
	```swift
	@IBInspectable var lineSpacing: CGFloat
	```
	The spacing to use between two items. The default value of this property is `10.0`.
	
- **itemSize**:
	
	```swift
	@IBInspectable var itemSize: CGFloat
	```
	The default size to use for cells. If the delegate does not implement the `collectionView(_:layout:sizeForItemAt:)` method, the slanted layout uses the value in this property to set the size of each cell. This results in cells that all have the same size. The default value of this property is `225`.
	
- **zIndexOrder**:
	
	```swift
	var zIndexOrder: ZIndexOrder
	```
	The zIndex order of the items in the layout. The default value of this property is `ascending`.

	
## Protocols

The `CollectionViewDelegateSlantedLayout` protocol defines methods that let you coordinate with a `CollectionViewSlantedLayout` object to implement a slanted layout. The `CollectionViewDelegateSlantedLayout` protocol has the following methods:

```swift
optional func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: CollectionViewSlantedLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGFloat
```

This method asks the delegate for the size of the specified item’s cell.
     
If you do not implement this method, the slanted layout uses the values in its `itemSize` property to set the size of items instead. Your implementation of this method can return a fixed set of sizes or dynamically adjust the sizes based on the cell’s content.

## Author

[Yassir Barchi](https://yassir.fr)

## Acknowledgement

This framework is inspired by [this prototype](https://dribbble.com/shots/1727594-Slanted-Table-Cells-With-Parallax?_=1456679145403) released by [Matt Bridges](https://dribbble.com/rrridges).


## License

**CollectionViewSlantedLayout** is available under the MIT license. See the LICENSE file for more info.
