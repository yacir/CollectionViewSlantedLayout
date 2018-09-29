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

import UIKit

/// :nodoc:
private typealias MaskPoints = (starting: [CGPoint], default: [CGPoint], ending: [CGPoint])

/// :nodoc:
public struct CollectionViewSlantedMasks {

    /// :nodoc:
    public var startingMask: CAShapeLayer
    /// :nodoc:
    public var defaultMask: CAShapeLayer
    /// :nodoc:
    public var endingMask: CAShapeLayer

    /// :nodoc:
    public init(masks: CollectionViewSlantedMasks) {
        startingMask = CAShapeLayer(path: masks.startingMask.path)
        defaultMask = CAShapeLayer(path: masks.defaultMask.path)
        endingMask = CAShapeLayer(path: masks.endingMask.path)
    }

    /// :nodoc:
    public init(size: CGSize,
                slantingSize: CGFloat,
                scrollDirection: UICollectionView.ScrollDirection,
                slantingDirection: SlantingDirection) {

        let points: MaskPoints

        if scrollDirection.isVertical {
            if slantingDirection  == .downward {
                points = CollectionViewSlantedMasks.verticalDownwardMaskPoints(size: size, slantingSize: slantingSize)
            } else {
                points = CollectionViewSlantedMasks.verticalUpwardMaskPoints(size: size, slantingSize: slantingSize)
            }
        } else {
            if slantingDirection  == .downward {
                points = CollectionViewSlantedMasks.horizontalDownwardMaskPoints(size: size, slantingSize: slantingSize)
            } else {
                points = CollectionViewSlantedMasks.horizontalUpwardMaskPoints(size: size, slantingSize: slantingSize)
            }
        }

        startingMask = CAShapeLayer(pathPoints: points.starting)
        defaultMask = CAShapeLayer(pathPoints: points.default)
        endingMask = CAShapeLayer(pathPoints: points.ending)
    }

    /// :nodoc:
    static private func verticalUpwardMaskPoints(size: CGSize, slantingSize: CGFloat) -> MaskPoints {
        let startingPoints = [CGPoint(x: 0, y: 0),
                              CGPoint(x: size.width, y: 0),
                              CGPoint(x: size.width, y: size.height - slantingSize),
                              CGPoint(x: 0, y: size.height)]

        let defaultPoints = [CGPoint(x: 0, y: slantingSize),
                             CGPoint(x: size.width, y: 0),
                             CGPoint(x: size.width, y: size.height - slantingSize),
                             CGPoint(x: 0, y: size.height)]

        let endingPoints = [CGPoint(x: 0, y: slantingSize),
                            CGPoint(x: size.width, y: 0),
                            CGPoint(x: size.width, y: size.height),
                            CGPoint(x: 0, y: size.height)]

        return (startingPoints, defaultPoints, endingPoints)
    }

    /// :nodoc:
    static private func verticalDownwardMaskPoints(size: CGSize, slantingSize: CGFloat) -> MaskPoints {
        let startingPoints = [CGPoint(x: 0, y: 0),
                              CGPoint(x: size.width, y: 0),
                              CGPoint(x: size.width, y: size.height),
                              CGPoint(x: 0, y: size.height - slantingSize)]

        let defaultPoints = [CGPoint(x: 0, y: 0),
                             CGPoint(x: size.width, y: slantingSize),
                             CGPoint(x: size.width, y: size.height),
                             CGPoint(x: 0, y: size.height - slantingSize)]

        let endingPoints = [CGPoint(x: 0, y: 0),
                            CGPoint(x: size.width, y: slantingSize),
                            CGPoint(x: size.width, y: size.height),
                            CGPoint(x: 0, y: size.height)]

        return (startingPoints, defaultPoints, endingPoints)
    }

    /// :nodoc:
    static private func horizontalUpwardMaskPoints(size: CGSize, slantingSize: CGFloat) -> MaskPoints {
        let startingPoints = [CGPoint(x: 0, y: 0),
                              CGPoint(x: size.width, y: 0),
                              CGPoint(x: size.width - slantingSize, y: size.height),
                              CGPoint(x: 0, y: size.height)]

        let defaultPoints = [CGPoint(x: slantingSize, y: 0),
                             CGPoint(x: size.width, y: 0),
                             CGPoint(x: size.width - slantingSize, y: size.height),
                             CGPoint(x: 0, y: size.height)]

        let endingPoints = [CGPoint(x: slantingSize, y: 0),
                            CGPoint(x: size.width, y: 0),
                            CGPoint(x: size.width, y: size.height),
                            CGPoint(x: 0, y: size.height)]

        return (startingPoints, defaultPoints, endingPoints)
    }

    /// :nodoc:
    static private func horizontalDownwardMaskPoints(size: CGSize, slantingSize: CGFloat) -> MaskPoints {
        let startingPoints = [CGPoint(x: 0, y: 0),
                              CGPoint(x: size.width - slantingSize, y: 0),
                              CGPoint(x: size.width, y: size.height),
                              CGPoint(x: 0, y: size.height)]

        let defaultPoints = [CGPoint(x: 0, y: 0),
                             CGPoint(x: size.width - slantingSize, y: 0),
                             CGPoint(x: size.width, y: size.height),
                             CGPoint(x: slantingSize, y: size.height)]

        let endingPoints = [CGPoint(x: 0, y: 0),
                            CGPoint(x: size.width, y: 0),
                            CGPoint(x: size.width, y: size.height),
                            CGPoint(x: slantingSize, y: size.height)]

        return (startingPoints, defaultPoints, endingPoints)
    }

}
