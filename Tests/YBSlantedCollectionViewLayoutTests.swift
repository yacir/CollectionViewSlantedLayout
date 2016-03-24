//
//  YBSlantedCollectionViewLayoutTests.swift
//  YBSlantedCollectionViewLayoutTests
//
//  Created by Yassir Barchi on 10/03/2016.
//  Copyright © 2016 Yassir Barchi. All rights reserved.
//

import XCTest
@testable import YBSlantedCollectionViewLayout

class YBSlantedCollectionViewLayoutTests: XCTestCase {
    
    var verticalSlantedViewLayout: YBSlantedCollectionViewLayout!
    var collectionViewController: CollectionViewController!
    
    var horizontalSlantedViewLayout: YBSlantedCollectionViewLayout!
    var horizontalCollectionViewController: CollectionViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        verticalSlantedViewLayout = YBSlantedCollectionViewLayout()
        collectionViewController = CollectionViewController(collectionViewLayout: verticalSlantedViewLayout)
        collectionViewController.view.frame = CGRect(x: 0, y: 0, width: 600, height: 600)
        
        horizontalSlantedViewLayout = YBSlantedCollectionViewLayout()
        horizontalSlantedViewLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        horizontalSlantedViewLayout.lineSpacing = 3
        horizontalSlantedViewLayout.itemSizeOptions = YBSlantedCollectionViewLayoutSizeOptions(VerticalSize: 100, HorizontalSize: 210)
        horizontalSlantedViewLayout.reverseSlantingAngle = true
        horizontalCollectionViewController = CollectionViewController(collectionViewLayout: horizontalSlantedViewLayout)
        horizontalCollectionViewController.view.frame = CGRect(x: 0, y: 0, width: 600, height: 600)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSlantedViewLayoutHasDefaultValues() {
        XCTAssertEqual(verticalSlantedViewLayout.slantingDelta, 50)
        XCTAssertEqual(verticalSlantedViewLayout.reverseSlantingAngle, false)
        XCTAssertEqual(verticalSlantedViewLayout.firstCellSlantingEnabled, true)
        XCTAssertEqual(verticalSlantedViewLayout.lastCellSlantingEnabled, true)
        XCTAssertEqual(verticalSlantedViewLayout.lineSpacing, 10)
        XCTAssertEqual(verticalSlantedViewLayout.scrollDirection, UICollectionViewScrollDirection.Vertical)
        XCTAssertEqual(verticalSlantedViewLayout.itemSizeOptions.VerticalSize, 220)
        XCTAssertEqual(verticalSlantedViewLayout.itemSizeOptions.HorizontalSize, 290)
    }
    
    func testLayoutContentViewSizeUsesController() {
        collectionViewController.items = [0, 1, 2, 3, 5, 6, 7, 8, 9]
        collectionViewController.view.layoutIfNeeded()

        let verticalSlantedViewLayoutSize = self.verticalSlantedViewLayout.collectionViewContentSize()
        let collectionViewControllerSize = self.collectionViewController.view.frame.size
        
        let size = verticalSlantedViewLayout.itemSizeOptions.VerticalSize
        let lineSpicing = verticalSlantedViewLayout.lineSpacing
        let slantingDelta = CGFloat(verticalSlantedViewLayout.slantingDelta)
        
        let contentSize = CGFloat(collectionViewController.items.count) * (size - slantingDelta + lineSpicing ) + slantingDelta - lineSpicing
        XCTAssertEqual(verticalSlantedViewLayoutSize.width, collectionViewControllerSize.width)
        XCTAssertEqual(verticalSlantedViewLayoutSize.height,  contentSize)
    }
    
    func testHorizontalLayoutContentViewSizeUsesController() {
        horizontalCollectionViewController.items = [0, 1, 2, 3, 5, 6, 7, 8, 9]
        horizontalCollectionViewController.view.layoutIfNeeded()
        
        let verticalSlantedViewLayoutSize = horizontalSlantedViewLayout.collectionViewContentSize()
        let collectionViewControllerSize = horizontalCollectionViewController.view.frame.size
        
        let size = horizontalSlantedViewLayout.itemSizeOptions.HorizontalSize
        let lineSpicing = horizontalSlantedViewLayout.lineSpacing
        let slantingDelta = CGFloat(horizontalSlantedViewLayout.slantingDelta)
        
        let contentSize = CGFloat(horizontalCollectionViewController.items.count) * (size - slantingDelta + lineSpicing ) + slantingDelta - lineSpicing
        XCTAssertEqual(verticalSlantedViewLayoutSize.width, contentSize)
        XCTAssertEqual(verticalSlantedViewLayoutSize.height,  collectionViewControllerSize.height)
    }

    
    func testLayoutHasSmoothScrolling() {
        let proposedOffset = verticalSlantedViewLayout.targetContentOffsetForProposedContentOffset(CGPoint(), withScrollingVelocity: CGPoint())
        
        XCTAssertEqual(proposedOffset.x, 0)
        XCTAssertEqual(proposedOffset.y, 0)
    }
    
    func testLayoutHasCachedLayoutAttributes() {
        collectionViewController.items = [0]
        
        collectionViewController.view.layoutIfNeeded()
        
        XCTAssertEqual(verticalSlantedViewLayout.cached.count, 1);
    }
    
    func testLayoutAttributeIsCached() {
        collectionViewController.items = [0]
        
        collectionViewController.view.layoutIfNeeded()
        
        let attributes = verticalSlantedViewLayout.layoutAttributesForElementsInRect(CGRect())!
        
        XCTAssertEqual(verticalSlantedViewLayout.cached, attributes)
    }
    
    func testLayoutHasLayoutAttributesAtIndexPath() {
        collectionViewController.items = [0, 1, 2]
        
        collectionViewController.view.layoutIfNeeded()
        
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        let attribute = verticalSlantedViewLayout.layoutAttributesForItemAtIndexPath(indexPath)
        
        XCTAssertEqual(verticalSlantedViewLayout.cached[0], attribute)
    }
    
    func testLayoutShouldInvalidateLayoutForBoundsChange() {
        XCTAssertTrue(verticalSlantedViewLayout.shouldInvalidateLayoutForBoundsChange(CGRect()))
    }
    
}
