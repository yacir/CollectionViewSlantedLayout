/**
 This file is part of the CollectionViewSlantedLayout package.

 Copyright © 2017 Yassir Barchi <github@yassir.fr>

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

@testable import CollectionViewSlantedLayout
import XCTest

class CollectionViewSlantedLayoutTests: XCTestCase {

    var verticalSlantedViewLayout: CollectionViewSlantedLayout!
    var collectionViewController: CollectionViewController!

    var horizontalSlantedViewLayout: CollectionViewSlantedLayout!
    var horizontalCollectionViewController: CollectionViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        verticalSlantedViewLayout = CollectionViewSlantedLayout()
        verticalSlantedViewLayout.itemSize = 225
        verticalSlantedViewLayout.slantingSize = 50
        verticalSlantedViewLayout.lineSpacing = 0
        verticalSlantedViewLayout.slantingDirection = .downward

        collectionViewController = CollectionViewController(collectionViewLayout: verticalSlantedViewLayout)
        collectionViewController.view.frame = CGRect(x: 0, y: 0, width: 600, height: 600)

        horizontalSlantedViewLayout = CollectionViewSlantedLayout()
        horizontalSlantedViewLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        horizontalSlantedViewLayout.lineSpacing = 3
        horizontalSlantedViewLayout.itemSize = 300
        horizontalSlantedViewLayout.slantingDirection = .downward
        horizontalSlantedViewLayout.zIndexOrder = .descending
        horizontalSlantedViewLayout.isFirstCellExcluded = true
        horizontalSlantedViewLayout.isLastCellExcluded = true
        horizontalCollectionViewController = CollectionViewController(collectionViewLayout: horizontalSlantedViewLayout)
        horizontalCollectionViewController.view.frame = CGRect(x: 0, y: 0, width: 600, height: 600)
    }

    func testSlantedViewLayoutHasDefaultValues() {
        let defaultSlantedViewLayout = CollectionViewSlantedLayout()
        XCTAssertEqual(defaultSlantedViewLayout.slantingSize, 75)
        XCTAssertEqual(defaultSlantedViewLayout.slantingDirection, .upward)
        XCTAssertEqual(defaultSlantedViewLayout.isFirstCellExcluded, false)
        XCTAssertEqual(defaultSlantedViewLayout.isLastCellExcluded, false)
        XCTAssertEqual(defaultSlantedViewLayout.lineSpacing, 10)
        XCTAssertEqual(defaultSlantedViewLayout.scrollDirection, UICollectionView.ScrollDirection.vertical)
        XCTAssertEqual(defaultSlantedViewLayout.itemSize, 225)
        XCTAssertEqual(defaultSlantedViewLayout.zIndexOrder, .ascending)
    }

    func testLayoutContentViewSizeUsesController() {
        collectionViewController.items = [0, 1, 2, 3, 5, 6, 7, 8, 9]
        collectionViewController.itemSize = 150
        collectionViewController.view.layoutIfNeeded()

        let verticalSlantedViewLayoutSize = self.verticalSlantedViewLayout.collectionViewContentSize
        let collectionViewControllerSize = self.collectionViewController.view.frame.size

        let size = collectionViewController.itemSize
        let lineSpicing = verticalSlantedViewLayout.lineSpacing
        let slantingDelta = CGFloat(verticalSlantedViewLayout.slantingSize)
        let itemSize = size! - slantingDelta + lineSpicing
        let contentSize = (CGFloat(collectionViewController.items.count) * itemSize) + slantingDelta - lineSpicing
        XCTAssertEqual(verticalSlantedViewLayoutSize.width, collectionViewControllerSize.width)
        XCTAssertEqual(verticalSlantedViewLayoutSize.height, contentSize)
    }

    func testHorizontalLayoutContentViewSizeUsesController() {
        horizontalCollectionViewController.items = [0, 1, 2, 3, 5, 6, 7, 8, 9]
        horizontalCollectionViewController.view.layoutIfNeeded()

        let horizontalSlantedViewLayoutSize = horizontalSlantedViewLayout.collectionViewContentSize
        let collectionViewControllerSize = horizontalCollectionViewController.view.frame.size

        let size = horizontalSlantedViewLayout.itemSize
        let lineSpicing = horizontalSlantedViewLayout.lineSpacing
        let slantingDelta = CGFloat(horizontalSlantedViewLayout.slantingSize)

        let sectionSize = size - slantingDelta + lineSpicing
        let count = CGFloat(horizontalCollectionViewController.items.count)
        let contentSize = (count * sectionSize) + slantingDelta - lineSpicing

        XCTAssertEqual(horizontalSlantedViewLayoutSize.width, contentSize)
        XCTAssertEqual(horizontalSlantedViewLayoutSize.height, collectionViewControllerSize.height)
    }

    func testLayoutContentViewSizeUsesItemSizeIfDelegateMethodIsNotImplemented() {
        collectionViewController.items = [0, 1, 2, 3, 5, 6, 7, 8, 9]
        collectionViewController.collectionView?.delegate = nil
        collectionViewController.view.layoutIfNeeded()

        let verticalSlantedViewLayoutSize = self.verticalSlantedViewLayout.collectionViewContentSize
        let collectionViewControllerSize = self.collectionViewController.view.frame.size

        let size = verticalSlantedViewLayout.itemSize
        let lineSpicing = verticalSlantedViewLayout.lineSpacing
        let slantingDelta = CGFloat(verticalSlantedViewLayout.slantingSize)

        let sectionSize = size - slantingDelta + lineSpicing
        let count = CGFloat(collectionViewController.items.count)
        let contentSize = (count * sectionSize) + slantingDelta - lineSpicing

        XCTAssertEqual(verticalSlantedViewLayoutSize.width, collectionViewControllerSize.width)
        XCTAssertEqual(verticalSlantedViewLayoutSize.height, contentSize)

        collectionViewController.collectionView?.delegate = collectionViewController
    }

    func testThatZIndexAscendingOrderWorksAsExcpected() {
        verticalSlantedViewLayout.slantingDirection = .upward
        collectionViewController.items = [0, 1]
        collectionViewController.view.layoutIfNeeded()
        let firstItemIndexPath = IndexPath(item: 0, section: 0)
        let firstItemZIndex = verticalSlantedViewLayout.layoutAttributesForItem(at: firstItemIndexPath)?.zIndex
        let secondItemIndexPath = IndexPath(item: 1, section: 0)
        let secondItemZIndex = verticalSlantedViewLayout.layoutAttributesForItem(at: secondItemIndexPath)?.zIndex
        XCTAssertTrue(firstItemZIndex! < secondItemZIndex!)
    }

    func testThatZIndexDescendingOrderWorksAsExcpected() {
        horizontalSlantedViewLayout.slantingDirection = .upward
        horizontalCollectionViewController.items = [0, 1]
        horizontalCollectionViewController.view.layoutIfNeeded()
        let firstItemIndexPath = IndexPath(item: 0, section: 0)
        let firstItemZIndex = horizontalSlantedViewLayout.layoutAttributesForItem(at: firstItemIndexPath)?.zIndex
        let secondItemIndexPath = IndexPath(item: 1, section: 0)
        let secondItemZIndex = horizontalSlantedViewLayout.layoutAttributesForItem(at: secondItemIndexPath)?.zIndex
        XCTAssertTrue(firstItemZIndex! > secondItemZIndex!)
    }

    func testThatSlantingAngleIsWellCalculated() {

        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 600),
                                              collectionViewLayout: verticalSlantedViewLayout)

        let layout = CollectionViewSlantedLayout()
        collectionView.collectionViewLayout = layout
        layout.slantingSize = 150
        XCTAssertEqual(layout.slantingAngle, -0.5)

        layout.slantingDirection = .downward
        XCTAssertEqual(layout.slantingAngle, 0.5)

        layout.scrollDirection = .horizontal
        XCTAssertEqual(layout.slantingAngle, -0.25)

        layout.slantingDirection = .upward
        XCTAssertEqual(layout.slantingAngle, 0.25)
    }

    func testLayoutHasSmoothScrolling() {
        let proposedOffset = verticalSlantedViewLayout.targetContentOffset(forProposedContentOffset: CGPoint(),
                                                                           withScrollingVelocity: CGPoint())
        XCTAssertEqual(proposedOffset.x, 0)
        XCTAssertEqual(proposedOffset.y, 0)
    }

    func testLayoutHasCachedLayoutAttributes() {
        collectionViewController.items = [0]
        collectionViewController.view.layoutIfNeeded()
        XCTAssertEqual(verticalSlantedViewLayout.cachedAttributes.count, 1)
    }

    func testLayoutAttributeIsCached() {
        collectionViewController.items = [0]
        collectionViewController.view.layoutIfNeeded()
        let attributes = verticalSlantedViewLayout.layoutAttributesForElements(in: CGRect())!
        XCTAssertEqual(verticalSlantedViewLayout.cachedAttributes, attributes)
    }

    func testLayoutHasLayoutAttributesAtIndexPath() {
        collectionViewController.items = [0, 1, 2]
        collectionViewController.view.layoutIfNeeded()
        let indexPath = IndexPath(item: 0, section: 0)
        let attribute = verticalSlantedViewLayout.layoutAttributesForItem(at: indexPath)
        XCTAssertEqual(verticalSlantedViewLayout.cachedAttributes[0], attribute)
    }

    func testLayoutShouldInvalidateLayoutForBoundsChange() {
        collectionViewController.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        collectionViewController.view.layoutIfNeeded()
        XCTAssertTrue(verticalSlantedViewLayout.shouldInvalidateLayout(forBoundsChange: CGRect()))
    }

}
