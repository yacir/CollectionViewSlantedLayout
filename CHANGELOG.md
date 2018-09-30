# CollectionViewSlantedLayout CHANGELOG

## 3.1.1 (09/30/2018)

* Invalidate the cache for bounds only if the size has changed

## 3.1.0 (09/29/2018)

* Updates to build specs with Xcode10 / Swift 4.2
* Fixes Identifier Name Violation #20
* Improves the performances by using the cache effectively #23
* Fixes SwiftLint errors & warnings
* Removes the deprecated `isFistCellExcluded` property 
* Refactor mask calculation #26
* Others minor enhancements

## 3.0.1 (01/04/2018)

* Fixes typo for `isFirstCellExcluded` property, closes #5

## 3.0 (12/30/2017)
The CollectionViewSlantedLayout 3.0 version introduce a full new APIs and remove all the old ones.

* Initial 3.0.0 Release
* Swift 4.0 version

## 2.2.0
* Swift 3.0 version
* Swift Package Manager support

## 2.1.1
* Add a public initializer for YBSlantedCollectionViewLayoutSizeOptions.

## 2.1.0

* Add tests
* Remove the `applyMaskToCellView (cellView : UICollectionViewCell, forIndexPath: NSIndexPath)` method

## 2.0.0

* Carthage support
* Improve the attribution of the clic.
* Add size options depending on the scroll direction
* New class added : `YBSlantedCollectionViewCell`
* Deprecat the `applyMaskToCellView (cellView : UICollectionViewCell, forIndexPath: NSIndexPath)` method

## 1.0.0

* Initial release.
