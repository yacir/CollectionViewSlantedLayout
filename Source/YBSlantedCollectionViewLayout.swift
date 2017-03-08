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
     The item height if the scroll direction is setted to `Vertical`.
     Default value is `220`
     */
    public var verticalSize: CGFloat
    
    /**
     The item width if the scroll direction is setted to `Horizontal`.
     Default value is `290`
     */
    public var horizontalSize: CGFloat
    
    /**
     Init with default values
     */
    public init() {
        self.verticalSize = 220;
        self.horizontalSize = 290;
    }

    /**
     Initialize with custom values
     
     - Parameter verticalSize:     Cell's height for `Vertical` scroll direction
     - Parameter horizontalSize:   Cell's width for `Horizontal` scroll direction
     */
    public init(verticalSize:CGFloat, horizontalSize:CGFloat) {
        self.verticalSize = verticalSize;
        self.horizontalSize = horizontalSize;
    }
}

/**
 YBSlantedCollectionViewLayout is a subclass of UICollectionViewLayout 
 allowing the display of slanted content on UICollectionView.
 
 By default, this UICollectionViewLayout has initialize a set
 of properties to work as designed.
 */
open class YBSlantedCollectionViewLayout: UICollectionViewLayout {

    /**
     The slanting delta.
     
     By default, this property is set to `50`.
     
     - Parameter slantingDelta:     The slantin delta
     */
    @IBInspectable open var slantingDelta: UInt = 50
    
    /**
     Reverse the slanting angle.
     
     Set it to `true` to reverse the slanting angle. By default, this property is set to `false`.
     
     - Parameter reverseSlantingAngle:     The slanting angle reversing status
     */
    @IBInspectable open var reverseSlantingAngle: Bool = false

    /**
     Allows to disable the slanting for the first cell.
     
     Set it to `false` to disable the slanting for the first cell. By default, this property is set to `true`.
     
     - Parameter firstCellSlantingEnabled:     The first cell slanting status
     */
    @IBInspectable open var firstCellSlantingEnabled: Bool = true

    /**
     Allows to disable the slanting for the last cell.
     
     Set it to `false` to disable the slanting for the last cell. By default, this property is set to `true`.
     
     - Parameter lastCellSlantingEnabled:     The last cell slanting status
     */
    @IBInspectable open var lastCellSlantingEnabled: Bool = true
    
    /**
     The spacing to use between two items.
     
     The spacing to use between two items. The default value of this property is 10.0.
     
     - Parameter lineSpacing:     The spacing to use between two items
     */
    @IBInspectable open var lineSpacing: CGFloat = 10

    /**
     The scroll direction of the grid.
     
     The grid layout scrolls along one axis only, either horizontally or vertically. 
     The default value of this property is `UICollectionViewScrollDirectionVertical`.
     
     - Parameter scrollDirection:     The scroll direction of the grid
     */
    open var scrollDirection: UICollectionViewScrollDirection = UICollectionViewScrollDirection.vertical
    
    
    /**
     The item size options
     
     Allows to set the item's width/height depending on the scroll direction.
     */
    open var itemSizeOptions: YBSlantedCollectionViewLayoutSizeOptions = YBSlantedCollectionViewLayoutSizeOptions()
    
    //MARK: Private
    internal var cached = [YBSlantedCollectionViewLayoutAttributes]()

    internal var size: CGFloat {
        if ( hasVerticalDirection ) {
            return itemSizeOptions.verticalSize
        }
        
        return itemSizeOptions.horizontalSize
    }
    
    internal var hasVerticalDirection: Bool {
        return scrollDirection == UICollectionViewScrollDirection.vertical
    }
    
    /// :nodoc:
    fileprivate func maskForItemAtIndexPath(_ indexPath: IndexPath) -> CAShapeLayer {
        let slantedLayerMask = CAShapeLayer()
        let bezierPath = UIBezierPath()
        
        let disableSlantingForTheFirstCell = indexPath.row == 0 && !firstCellSlantingEnabled;
        
        let disableSlantingForTheFirstLastCell = indexPath.row == numberOfItems-1 && !lastCellSlantingEnabled;
        
        if ( hasVerticalDirection ) {
            if (reverseSlantingAngle) {
                bezierPath.move(to: CGPoint.init(x: 0, y: 0))
                bezierPath.addLine(to: CGPoint.init(x: width, y: disableSlantingForTheFirstCell ? 0 : CGFloat(slantingDelta)))
                bezierPath.addLine(to: CGPoint.init(x: width, y: size))
                bezierPath.addLine(to: CGPoint.init(x: 0, y: disableSlantingForTheFirstLastCell ? size : size-CGFloat(slantingDelta)))
                bezierPath.addLine(to: CGPoint.init(x: 0, y: 0))
            }
            else {
                let startPoint = CGPoint.init(x: 0, y: disableSlantingForTheFirstCell ? 0 : CGFloat(slantingDelta))
                bezierPath.move(to: startPoint)
                bezierPath.addLine(to: CGPoint.init(x: width, y: 0))
                bezierPath.addLine(to: CGPoint.init(x: width, y: disableSlantingForTheFirstLastCell ? size : size-CGFloat(slantingDelta)))
                bezierPath.addLine(to: CGPoint.init(x: 0, y: size))
                bezierPath.addLine(to: startPoint)
            }
        }
        else {
            if (reverseSlantingAngle) {
                let startPoint = CGPoint.init(x: disableSlantingForTheFirstCell ? 0 : CGFloat(slantingDelta), y: 0)
                bezierPath.move(to: startPoint)
                bezierPath.addLine(to: CGPoint.init(x: size, y: 0))
                bezierPath.addLine(to: CGPoint.init(x: disableSlantingForTheFirstLastCell ? size : size-CGFloat(slantingDelta), y: height))
                bezierPath.addLine(to: CGPoint.init(x: 0, y: height))
                bezierPath.addLine(to: startPoint)
            }
            else {
                bezierPath.move(to: CGPoint.init(x: 0, y: 0))
                bezierPath.addLine(to: CGPoint.init(x: disableSlantingForTheFirstLastCell ? size : size-CGFloat(slantingDelta), y: 0))
                bezierPath.addLine(to: CGPoint.init(x: size, y: height))
                bezierPath.addLine(to: CGPoint.init(x: disableSlantingForTheFirstCell ? 0 : CGFloat(slantingDelta), y: height))
                bezierPath.addLine(to: CGPoint.init(x: 0, y: 0))
            }
        }
        
        bezierPath.close()
        
        slantedLayerMask.path = bezierPath.cgPath
        
        return slantedLayerMask
    }
    
    //MARK: CollectionViewLayout methods overriding
    /// :nodoc:
    override open var collectionViewContentSize : CGSize {
        
        let contentSize = CGFloat(numberOfItems) * (size + lineSpacing - CGFloat(slantingDelta)) - lineSpacing + CGFloat(slantingDelta)
        
        if ( hasVerticalDirection ) {
            return CGSize(width: width, height: contentSize)
        }
        
        return CGSize(width: contentSize, height: height)
    }

    /// :nodoc:
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
    
    /// :nodoc:
    override open func prepare() {
        cached = [YBSlantedCollectionViewLayoutAttributes]()
        
        var position: CGFloat = 0
                
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = YBSlantedCollectionViewLayoutAttributes(forCellWith: indexPath)
            
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
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cached.filter { attributes in
            return attributes.frame.intersects(rect)
        }
    }
    
    /// :nodoc:
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> YBSlantedCollectionViewLayoutAttributes? {
        return cached[indexPath.item]
    }
}

private extension UICollectionViewLayout {
    
    var numberOfItems: Int {
        return collectionView!.numberOfItems(inSection: 0)
    }
    
    var width: CGFloat {
        return collectionView!.frame.width-collectionView!.contentInset.left-collectionView!.contentInset.right
    }
    
    var height: CGFloat {
        return collectionView!.frame.height-collectionView!.contentInset.top-collectionView!.contentInset.bottom
    }
}
