/**
 This file is part of the YBSlantedCollectionViewLayout package.

 Copyright (c) 2016 Yassir Barchi <dev.yassir@gmail.com>
 
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

import UIKit;

/// The item size options
public struct YBSlantedCollectionViewLayoutSizeOptions {
    /**
     * The item height if the scroll direction is setted to `Vertical`.
     * Default value is `220`
     */
    var VerticalSize: CGFloat = 220
    
    /**
     * The item width if the scroll direction is setted to `Horizontal`.
     * Default value is `290`
     */
    var HorizontalSize: CGFloat = 290
}

/**
 YBSlantedCollectionViewLayout is a subclass of UICollectionViewLayout 
 allowing the display of slanted content on UICollectionView.
 
 By default, this UICollectionViewLayout has initialize a set
 of properties to work as designed.
 */
public class YBSlantedCollectionViewLayout: UICollectionViewLayout {

    /**
     The slanting delta.
     
     By default, this property is set to `50`.
     
     - Parameter slantingDelta:     The slantin delta
     */
    @IBInspectable public var slantingDelta: UInt = 50
    
    /**
     Reverse the slanting angle.
     
     Set it to `true` to reverse the slanting angle. By default, this property is set to `false`.
     
     - Parameter reverseSlantingAngle:     The slanting angle reversing status
     */
    @IBInspectable public var reverseSlantingAngle: Bool = false

    /**
     Allows to disable the slanting for the first cell.
     
     Set it to `false` to disable the slanting for the first cell. By default, this property is set to `true`.
     
     - Parameter firstCellSlantingEnabled:     The first cell slanting status
     */
    @IBInspectable public var firstCellSlantingEnabled: Bool = true

    /**
     Allows to disable the slanting for the last cell.
     
     Set it to `false` to disable the slanting for the last cell. By default, this property is set to `true`.
     
     - Parameter lastCellSlantingEnabled:     The last cell slanting status
     */
    @IBInspectable public var lastCellSlantingEnabled: Bool = true
    
    /**
     The spacing to use between two items.
     
     The spacing to use between two items. The default value of this property is 10.0.
     
     - Parameter lineSpacing:     The spacing to use between two items
     */
    @IBInspectable public var lineSpacing: CGFloat = 10

    /**
     The scroll direction of the grid.
     
     The grid layout scrolls along one axis only, either horizontally or vertically. 
     The default value of this property is `UICollectionViewScrollDirectionVertical`.
     
     - Parameter scrollDirection:     The scroll direction of the grid
     */
    public var scrollDirection: UICollectionViewScrollDirection = UICollectionViewScrollDirection.Vertical
    
    
    /**
     The item size options
     
     Allows to set the item's width/height depending on the scroll direction.
     */
    public var itemSizeOptions: YBSlantedCollectionViewLayoutSizeOptions = YBSlantedCollectionViewLayoutSizeOptions()
    
    //MARK: Private
    internal var cached = [YBSlantedCollectionViewLayoutAttributes]()

    internal var size: CGFloat {
        if ( hasVerticalDirection ) {
            return itemSizeOptions.VerticalSize
        }
        
        return itemSizeOptions.HorizontalSize
    }
    
    internal var hasVerticalDirection: Bool {
        return scrollDirection == UICollectionViewScrollDirection.Vertical
    }

    /// :nodoc:
    @available(*, deprecated, message="Use YBSlantedCollectionViewCell")
    public func applyMaskToCellView (cellView : UICollectionViewCell, forIndexPath: NSIndexPath) {
        cellView.layer.mask = self.maskForItemAtIndexPath(forIndexPath)
    }
    
    /// :nodoc:
    private func maskForItemAtIndexPath(indexPath: NSIndexPath) -> CAShapeLayer {
        let slantedLayerMask = CAShapeLayer()
        let bezierPath = UIBezierPath()
        
        let disableSlantingForTheFirstCell = indexPath.row == 0 && !firstCellSlantingEnabled;
        
        let disableSlantingForTheFirstLastCell = indexPath.row == numberOfItems-1 && !lastCellSlantingEnabled;
        
        if ( hasVerticalDirection ) {
            if (reverseSlantingAngle) {
                bezierPath.moveToPoint(CGPoint.init(x: 0, y: 0))
                bezierPath.addLineToPoint(CGPoint.init(x: width, y: disableSlantingForTheFirstCell ? 0 : CGFloat(slantingDelta)))
                bezierPath.addLineToPoint(CGPoint.init(x: width, y: size))
                bezierPath.addLineToPoint(CGPoint.init(x: 0, y: disableSlantingForTheFirstLastCell ? size : size-CGFloat(slantingDelta)))
                bezierPath.addLineToPoint(CGPoint.init(x: 0, y: 0))
            }
            else {
                let startPoint = CGPoint.init(x: 0, y: disableSlantingForTheFirstCell ? 0 : CGFloat(slantingDelta))
                bezierPath.moveToPoint(startPoint)
                bezierPath.addLineToPoint(CGPoint.init(x: width, y: 0))
                bezierPath.addLineToPoint(CGPoint.init(x: width, y: disableSlantingForTheFirstLastCell ? size : size-CGFloat(slantingDelta)))
                bezierPath.addLineToPoint(CGPoint.init(x: 0, y: size))
                bezierPath.addLineToPoint(startPoint)
            }
        }
        else {
            if (reverseSlantingAngle) {
                let startPoint = CGPoint.init(x: disableSlantingForTheFirstCell ? 0 : CGFloat(slantingDelta), y: 0)
                bezierPath.moveToPoint(startPoint)
                bezierPath.addLineToPoint(CGPoint.init(x: size, y: 0))
                bezierPath.addLineToPoint(CGPoint.init(x: disableSlantingForTheFirstLastCell ? size : size-CGFloat(slantingDelta), y: height))
                bezierPath.addLineToPoint(CGPoint.init(x: 0, y: height))
                bezierPath.addLineToPoint(startPoint)
            }
            else {
                bezierPath.moveToPoint(CGPoint.init(x: 0, y: 0))
                bezierPath.addLineToPoint(CGPoint.init(x: disableSlantingForTheFirstLastCell ? size : size-CGFloat(slantingDelta), y: 0))
                bezierPath.addLineToPoint(CGPoint.init(x: size, y: height))
                bezierPath.addLineToPoint(CGPoint.init(x: disableSlantingForTheFirstCell ? 0 : CGFloat(slantingDelta), y: height))
                bezierPath.addLineToPoint(CGPoint.init(x: 0, y: 0))
            }
        }
        
        bezierPath.closePath()
        
        slantedLayerMask.path = bezierPath.CGPath
        
        return slantedLayerMask
    }
    
    //MARK: CollectionViewLayout methods overriding
    /// :nodoc:
    override public func collectionViewContentSize() -> CGSize {
        
        let contentSize = CGFloat(numberOfItems) * (size + lineSpacing - CGFloat(slantingDelta)) - lineSpacing + CGFloat(slantingDelta)
        
        if ( hasVerticalDirection ) {
            return CGSize(width: width, height: contentSize)
        }
        
        return CGSize(width: contentSize, height: height)
    }

    /// :nodoc:
    override public func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true;
    }
    
    /// :nodoc:
    override public func prepareLayout() {
        cached = [YBSlantedCollectionViewLayoutAttributes]()
        
        var position: CGFloat = 0
                
        for item in 0..<numberOfItems {
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let attributes = YBSlantedCollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            let frame : CGRect
            
            if ( hasVerticalDirection ) {
                frame = CGRect(x: 0, y: position, width: width, height: size)
            }
            else {
                frame = CGRect(x: position, y: 0, width: size, height: height)
            }
            
            attributes.frame = frame
            
            // Important because each cell has to slide over the top of the previous one
            attributes.zIndex = item
            
            attributes.slantedLayerMask = self.maskForItemAtIndexPath(indexPath)
            
            cached.append(attributes)
            
            position += size + lineSpacing - CGFloat(slantingDelta)
        }
    }
    
    /// :nodoc:
    override public func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cached.filter { attributes in
            return CGRectIntersectsRect(attributes.frame, rect)
        }
    }
    
    /// :nodoc:
    override public func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> YBSlantedCollectionViewLayoutAttributes? {
        return cached[indexPath.item]
    }
}

private extension UICollectionViewLayout {
    
    var numberOfItems: Int {
        return collectionView!.numberOfItemsInSection(0)
    }
    
    var width: CGFloat {
        return CGRectGetWidth(collectionView!.frame)-collectionView!.contentInset.left-collectionView!.contentInset.right
    }
    
    var height: CGFloat {
        return CGRectGetHeight(collectionView!.frame)-collectionView!.contentInset.top-collectionView!.contentInset.bottom
    }
}
