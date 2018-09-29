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

class CollectionViewSlantedMasksTests: XCTestCase {

    var size: CGSize!
    var slantingSize: CGFloat!

    override func setUp() {
        super.setUp()
        size = CGSize(width: 200, height: 200)
        slantingSize = 50
    }

    // swiftlint:disable function_body_length
    func testThatVerticalUpwardMasksAreWellCalculated() {
        let masks = CollectionViewSlantedMasks(size: size,
                                               slantingSize: slantingSize,
                                               scrollDirection: UICollectionView.ScrollDirection.vertical,
                                               slantingDirection: .upward)
        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: size.width - 1, y: 0)
        let point3 = CGPoint(x: size.width, y: 0)
        let point4 = CGPoint(x: size.width, y: size.height - slantingSize)
        let point5 = CGPoint(x: size.width, y: size.height - slantingSize + 1)
        let point6 = CGPoint(x: size.width, y: size.height)
        let point7 = CGPoint(x: 1, y: size.height)
        let point8 = CGPoint(x: 0, y: size.height)
        let point9 = CGPoint(x: 0, y: slantingSize)
        let point10 = CGPoint(x: 0, y: slantingSize - 1)

        XCTAssertFalse(masks.defaultMask.path!.contains(point1))
        XCTAssertFalse(masks.defaultMask.path!.contains(point2))
        XCTAssertTrue(masks.defaultMask.path!.contains(point3))
        XCTAssertTrue(masks.defaultMask.path!.contains(point4))
        XCTAssertFalse(masks.defaultMask.path!.contains(point5))
        XCTAssertFalse(masks.defaultMask.path!.contains(point6))
        XCTAssertFalse(masks.defaultMask.path!.contains(point7))
        XCTAssertTrue(masks.defaultMask.path!.contains(point8))
        XCTAssertTrue(masks.defaultMask.path!.contains(point9))
        XCTAssertFalse(masks.defaultMask.path!.contains(point10))

        XCTAssertTrue(masks.startingMask.path!.contains(point1))
        XCTAssertTrue(masks.startingMask.path!.contains(point2))
        XCTAssertTrue(masks.startingMask.path!.contains(point3))
        XCTAssertTrue(masks.startingMask.path!.contains(point4))
        XCTAssertFalse(masks.startingMask.path!.contains(point5))
        XCTAssertFalse(masks.startingMask.path!.contains(point6))
        XCTAssertFalse(masks.startingMask.path!.contains(point7))
        XCTAssertTrue(masks.startingMask.path!.contains(point8))
        XCTAssertTrue(masks.startingMask.path!.contains(point9))
        XCTAssertTrue(masks.startingMask.path!.contains(point10))

        XCTAssertFalse(masks.endingMask.path!.contains(point1))
        XCTAssertFalse(masks.endingMask.path!.contains(point2))
        XCTAssertTrue(masks.endingMask.path!.contains(point3))
        XCTAssertTrue(masks.endingMask.path!.contains(point4))
        XCTAssertTrue(masks.endingMask.path!.contains(point5))
        XCTAssertTrue(masks.endingMask.path!.contains(point6))
        XCTAssertTrue(masks.endingMask.path!.contains(point7))
        XCTAssertTrue(masks.endingMask.path!.contains(point8))
        XCTAssertTrue(masks.endingMask.path!.contains(point9))
        XCTAssertFalse(masks.endingMask.path!.contains(point10))
    }

    // swiftlint:disable function_body_length
    func testThatVerticalDownwardMasksAreWellCalculated() {
        let masks = CollectionViewSlantedMasks(size: size,
                                               slantingSize: slantingSize,
                                               scrollDirection: UICollectionView.ScrollDirection.vertical,
                                               slantingDirection: .downward)
        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: 1, y: 0)
        let point3 = CGPoint(x: size.width, y: 0)
        let point4 = CGPoint(x: size.width, y: slantingSize - 1)
        let point5 = CGPoint(x: size.width, y: slantingSize)
        let point6 = CGPoint(x: size.width, y: size.height)
        let point7 = CGPoint(x: size.width - 1, y: size.height)
        let point8 = CGPoint(x: 0, y: size.height)
        let point9 = CGPoint(x: 0, y: size.height - slantingSize + 1)
        let point10 = CGPoint(x: 0, y: size.height - slantingSize)

        XCTAssertTrue(masks.defaultMask.path!.contains(point1))
        XCTAssertFalse(masks.defaultMask.path!.contains(point2))
        XCTAssertFalse(masks.defaultMask.path!.contains(point3))
        XCTAssertFalse(masks.defaultMask.path!.contains(point4))
        XCTAssertTrue(masks.defaultMask.path!.contains(point5))
        XCTAssertTrue(masks.defaultMask.path!.contains(point6))
        XCTAssertFalse(masks.defaultMask.path!.contains(point7))
        XCTAssertFalse(masks.defaultMask.path!.contains(point8))
        XCTAssertFalse(masks.defaultMask.path!.contains(point9))
        XCTAssertTrue(masks.defaultMask.path!.contains(point10))

        XCTAssertTrue(masks.startingMask.path!.contains(point1))
        XCTAssertTrue(masks.startingMask.path!.contains(point2))
        XCTAssertTrue(masks.startingMask.path!.contains(point3))
        XCTAssertTrue(masks.startingMask.path!.contains(point4))
        XCTAssertTrue(masks.startingMask.path!.contains(point5))
        XCTAssertTrue(masks.startingMask.path!.contains(point6))
        XCTAssertFalse(masks.startingMask.path!.contains(point7))
        XCTAssertFalse(masks.startingMask.path!.contains(point8))
        XCTAssertFalse(masks.startingMask.path!.contains(point9))
        XCTAssertTrue(masks.startingMask.path!.contains(point10))

        XCTAssertTrue(masks.endingMask.path!.contains(point1))
        XCTAssertFalse(masks.endingMask.path!.contains(point2))
        XCTAssertFalse(masks.endingMask.path!.contains(point3))
        XCTAssertFalse(masks.endingMask.path!.contains(point4))
        XCTAssertTrue(masks.endingMask.path!.contains(point5))
        XCTAssertTrue(masks.endingMask.path!.contains(point6))
        XCTAssertTrue(masks.endingMask.path!.contains(point7))
        XCTAssertTrue(masks.endingMask.path!.contains(point8))
        XCTAssertTrue(masks.endingMask.path!.contains(point9))
        XCTAssertTrue(masks.endingMask.path!.contains(point10))
    }

    // swiftlint:disable function_body_length
    func testThatHorizontalUpwardMasksAreWellCalculated() {
        let masks = CollectionViewSlantedMasks(size: size,
                                               slantingSize: slantingSize,
                                               scrollDirection: UICollectionView.ScrollDirection.horizontal,
                                               slantingDirection: .upward)
        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: slantingSize - 1, y: 0)
        let point3 = CGPoint(x: slantingSize, y: 0)
        let point4 = CGPoint(x: size.width, y: 0)
        let point5 = CGPoint(x: size.width, y: 1)
        let point6 = CGPoint(x: size.width, y: size.height)
        let point7 = CGPoint(x: size.width - slantingSize + 1, y: size.height)
        let point8 = CGPoint(x: size.width - slantingSize, y: size.height)
        let point9 = CGPoint(x: 0, y: size.height)
        let point10 = CGPoint(x: 0, y: size.height - 1)

        XCTAssertFalse(masks.defaultMask.path!.contains(point1))
        XCTAssertFalse(masks.defaultMask.path!.contains(point2))
        XCTAssertTrue(masks.defaultMask.path!.contains(point3))
        XCTAssertTrue(masks.defaultMask.path!.contains(point4))
        XCTAssertFalse(masks.defaultMask.path!.contains(point5))
        XCTAssertFalse(masks.defaultMask.path!.contains(point6))
        XCTAssertFalse(masks.defaultMask.path!.contains(point7))
        XCTAssertTrue(masks.defaultMask.path!.contains(point8))
        XCTAssertTrue(masks.defaultMask.path!.contains(point9))
        XCTAssertFalse(masks.defaultMask.path!.contains(point10))

        XCTAssertTrue(masks.startingMask.path!.contains(point1))
        XCTAssertTrue(masks.startingMask.path!.contains(point2))
        XCTAssertTrue(masks.startingMask.path!.contains(point3))
        XCTAssertTrue(masks.startingMask.path!.contains(point4))
        XCTAssertFalse(masks.startingMask.path!.contains(point5))
        XCTAssertFalse(masks.startingMask.path!.contains(point6))
        XCTAssertFalse(masks.startingMask.path!.contains(point7))
        XCTAssertTrue(masks.startingMask.path!.contains(point8))
        XCTAssertTrue(masks.startingMask.path!.contains(point9))
        XCTAssertTrue(masks.startingMask.path!.contains(point10))

        XCTAssertFalse(masks.endingMask.path!.contains(point1))
        XCTAssertFalse(masks.endingMask.path!.contains(point2))
        XCTAssertTrue(masks.endingMask.path!.contains(point3))
        XCTAssertTrue(masks.endingMask.path!.contains(point4))
        XCTAssertTrue(masks.endingMask.path!.contains(point5))
        XCTAssertTrue(masks.endingMask.path!.contains(point6))
        XCTAssertTrue(masks.endingMask.path!.contains(point7))
        XCTAssertTrue(masks.endingMask.path!.contains(point8))
        XCTAssertTrue(masks.endingMask.path!.contains(point9))
        XCTAssertFalse(masks.endingMask.path!.contains(point10))

    }

    func testThatHorizontalDownwardMasksAreWellCalculated() {
        let masks = CollectionViewSlantedMasks(size: size,
                                               slantingSize: slantingSize,
                                               scrollDirection: UICollectionView.ScrollDirection.horizontal,
                                               slantingDirection: .downward)
        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: size.width - slantingSize, y: 0)
        let point3 = CGPoint(x: size.width - slantingSize + 1, y: 0)
        let point4 = CGPoint(x: size.width, y: 0)
        let point5 = CGPoint(x: size.width, y: size.height - 1)
        let point6 = CGPoint(x: size.width, y: size.height)
        let point7 = CGPoint(x: slantingSize, y: size.height)
        let point8 = CGPoint(x: slantingSize - 1, y: size.height)
        let point9 = CGPoint(x: 0, y: size.height)
        let point10 = CGPoint(x: 0, y: 1)

        XCTAssertTrue(masks.defaultMask.path!.contains(point1))
        XCTAssertTrue(masks.defaultMask.path!.contains(point2))
        XCTAssertFalse(masks.defaultMask.path!.contains(point3))
        XCTAssertFalse(masks.defaultMask.path!.contains(point4))
        XCTAssertFalse(masks.defaultMask.path!.contains(point5))
        XCTAssertTrue(masks.defaultMask.path!.contains(point6))
        XCTAssertTrue(masks.defaultMask.path!.contains(point7))
        XCTAssertFalse(masks.defaultMask.path!.contains(point8))
        XCTAssertFalse(masks.defaultMask.path!.contains(point9))
        XCTAssertFalse(masks.defaultMask.path!.contains(point10))

        XCTAssertTrue(masks.startingMask.path!.contains(point1))
        XCTAssertTrue(masks.startingMask.path!.contains(point2))
        XCTAssertFalse(masks.startingMask.path!.contains(point3))
        XCTAssertFalse(masks.startingMask.path!.contains(point4))
        XCTAssertFalse(masks.startingMask.path!.contains(point5))
        XCTAssertTrue(masks.startingMask.path!.contains(point6))
        XCTAssertTrue(masks.startingMask.path!.contains(point7))
        XCTAssertTrue(masks.startingMask.path!.contains(point8))
        XCTAssertTrue(masks.startingMask.path!.contains(point9))
        XCTAssertTrue(masks.startingMask.path!.contains(point10))

        XCTAssertTrue(masks.endingMask.path!.contains(point1))
        XCTAssertTrue(masks.endingMask.path!.contains(point2))
        XCTAssertTrue(masks.endingMask.path!.contains(point3))
        XCTAssertTrue(masks.endingMask.path!.contains(point4))
        XCTAssertTrue(masks.endingMask.path!.contains(point5))
        XCTAssertTrue(masks.endingMask.path!.contains(point6))
        XCTAssertTrue(masks.endingMask.path!.contains(point7))
        XCTAssertFalse(masks.endingMask.path!.contains(point8))
        XCTAssertFalse(masks.endingMask.path!.contains(point9))
        XCTAssertFalse(masks.endingMask.path!.contains(point10))
    }

}
