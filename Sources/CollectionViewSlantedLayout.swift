/**
 This file is part of the CollectionViewSlantedLayout package.

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

/**
 CollectionViewSlantedLayout is a subclass of UICollectionViewLayout 
 allowing the display of slanted content on UICollectionView.
 
 By default, this UICollectionViewLayout has initialize a set
 of properties to work as designed.
 */
@objc open class CollectionViewSlantedLayout: UICollectionViewLayout {

    /**
     The slanting size.
     
     The default value of this property is `75`.
     */
    @IBInspectable open var slantingSize: UInt = 75 {
        didSet {
            updateRotationAngle()
            invalidateLayout()
        }
    }
    
    /**
     The slanting direction.
     
     The default value of this property is `upward`.
    */
    @objc open var slantingDirection: SlantingDirection = .upward {
        didSet {
            updateRotationAngle()
            invalidateLayout()
        }
    }
    
    /**
     The angle, in radians, of the slanting.
     
     The value of this property could be used to apply a rotation transform on the cell's contentView in the
     `collectionView(_:cellForItemAt:)` method implementation.
     
     ```
     if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
        cell.contentView.transform = CGAffineTransform(rotationAngle: layout.rotationAngle)
     }
     ```
     */
    @objc open fileprivate(set) var slantingAngle: CGFloat = 0
    
    /**
     The scroll direction of the grid.
     
     The grid layout scrolls along one axis only, either horizontally or vertically.
     The default value of this property is `vertical`.
     */
    @objc open var scrollDirection: UICollectionViewScrollDirection = .vertical{
        didSet {
            updateRotationAngle()
            invalidateLayout()
        }
    }
    
    /**
     Allows to disable the slanting for the first cell.
     
     Set it to `true` to disable the slanting for the first cell. The default value of this property is `false`.
     */
    @IBInspectable open var isFistCellExcluded: Bool = false  {
        didSet {
            invalidateLayout()
        }
    }

    /**
     Allows to disable the slanting for the last cell.
     
     Set it to `true` to disable the slanting for the last cell. The default value of this property is `false`.
     */
    @IBInspectable open var isLastCellExcluded: Bool = false  {
        didSet {
            invalidateLayout()
        }
    }
    
    /**
     The spacing to use between two items.
     
     The default value of this property is 10.0.
     */
    @IBInspectable open var lineSpacing: CGFloat = 10 {
        didSet {
            invalidateLayout()
        }
    }
    
    /**
     The default size to use for cells.
     
     If the delegate does not implement the `collectionView(_:layout:sizeForItemAt:)` method, the slanted layout
     uses the value in this property to set the size of each cell. This results in cells that all have the same size.
     
     The default value of this property is 225.
     */
    @IBInspectable open var itemSize: CGFloat = 225  {
        didSet {
            invalidateLayout()
        }
    }

    /**
     The zIndex order of the items in the layout.
     
     The default value of this property is `ascending`.
     */
    @objc open var zIndexOrder: ZIndexOrder = .ascending {
        didSet {
            invalidateLayout()
        }
    }
    
    //MARK: Private
    // :nodoc:
    internal var cachedAttributes = [CollectionViewSlantedLayoutAttributes]()
    // :nodoc:
    internal var cachedContentSize: CGFloat = 0
    
    // :nodoc:
    fileprivate func itemSize(forItemAt indexPath: IndexPath) -> CGFloat {
        guard let collectionView = collectionView,
                let delegate = collectionView.delegate as? CollectionViewDelegateSlantedLayout else {
            return max(itemSize, 0)
        }
        
        let size = delegate.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath)
        return max(size ?? itemSize, 0)
    }
    
    /// :nodoc:
    fileprivate func maskForItemAtIndexPath(_ indexPath: IndexPath) -> CAShapeLayer {
        let slantedLayerMask = CAShapeLayer()
        let bezierPath = UIBezierPath()
        
        let disableSlantingForTheFirstCell = indexPath.row == 0 && isFistCellExcluded;
        let disableSlantingForTheFirstLastCell = indexPath.row == numberOfItems-1 && isLastCellExcluded;
        let size = itemSize(forItemAt: indexPath)
        
        if ( scrollDirection.isVertical ) {
            switch self.slantingDirection {
            case .downward:
                bezierPath.move(to: CGPoint.init(x: 0, y: 0))
                bezierPath.addLine(to: CGPoint.init(x: width, y: disableSlantingForTheFirstCell ? 0 : CGFloat(slantingSize)))
                bezierPath.addLine(to: CGPoint.init(x: width, y: size))
                bezierPath.addLine(to: CGPoint.init(x: 0, y: disableSlantingForTheFirstLastCell ? size : size-CGFloat(slantingSize)))
                bezierPath.addLine(to: CGPoint.init(x: 0, y: 0))
            default:
                let startPoint = CGPoint.init(x: 0, y: disableSlantingForTheFirstCell ? 0 : CGFloat(self.slantingSize))
                bezierPath.move(to: startPoint)
                bezierPath.addLine(to: CGPoint.init(x: width, y: 0))
                bezierPath.addLine(to: CGPoint.init(x: width, y: disableSlantingForTheFirstLastCell ? size : size-CGFloat(slantingSize)))
                bezierPath.addLine(to: CGPoint.init(x: 0, y: size))
                bezierPath.addLine(to: startPoint)
            }
        }
        else {
            switch self.slantingDirection {
            case .upward:
                let startPoint = CGPoint.init(x: disableSlantingForTheFirstCell ? 0 : CGFloat(slantingSize), y: 0)
                bezierPath.move(to: startPoint)
                bezierPath.addLine(to: CGPoint.init(x: size, y: 0))
                bezierPath.addLine(to: CGPoint.init(x: disableSlantingForTheFirstLastCell ? size : size-CGFloat(slantingSize), y: height))
                bezierPath.addLine(to: CGPoint.init(x: 0, y: height))
                bezierPath.addLine(to: startPoint)
            default:
                bezierPath.move(to: CGPoint.init(x: 0, y: 0))
                bezierPath.addLine(to: CGPoint.init(x: disableSlantingForTheFirstLastCell ? size : size-CGFloat(slantingSize), y: 0))
                bezierPath.addLine(to: CGPoint.init(x: size, y: height))
                bezierPath.addLine(to: CGPoint.init(x: disableSlantingForTheFirstCell ? 0 : CGFloat(slantingSize), y: height))
                bezierPath.addLine(to: CGPoint.init(x: 0, y: 0))
            }
        }

        bezierPath.close()
        slantedLayerMask.path = bezierPath.cgPath
        return slantedLayerMask
    }
    
    /// :nodoc:
    fileprivate func updateRotationAngle() {
        let oppositeSide = CGFloat(slantingSize)
        var factor = slantingDirection == .upward ? -1 : 1
        var adjacentSide = width
        
        if !scrollDirection.isVertical {
            adjacentSide = height
            factor *= -1
        }
        
        let angle = atan(tan(oppositeSide / adjacentSide))
        slantingAngle = angle * CGFloat(factor)
    }
}

//MARK: CollectionViewLayout methods overriding
extension CollectionViewSlantedLayout {
    
    /// :nodoc:
    override open var collectionViewContentSize : CGSize {
        let contentSize = CGFloat(numberOfItems - 1) * (lineSpacing - CGFloat(slantingSize)) + cachedContentSize
        return scrollDirection.isVertical ? CGSize(width: width, height: contentSize) : CGSize(width: contentSize, height: height)
    }
    
    /// :nodoc:
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
    
    /// :nodoc:
    override open func prepare() {
        updateRotationAngle()
        cachedAttributes = [CollectionViewSlantedLayoutAttributes]()
        cachedContentSize = 0
        
        var position: CGFloat = 0
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = CollectionViewSlantedLayoutAttributes(forCellWith: indexPath)
            let size = itemSize(forItemAt: indexPath)
            let frame : CGRect
            
            if ( scrollDirection.isVertical ) {
                frame = CGRect(x: 0, y: position, width: width, height: size)
            }
            else {
                frame = CGRect(x: position, y: 0, width: size, height: height)
            }
            
            attributes.frame = frame
            attributes.size = frame.size

            attributes.zIndex = zIndexOrder.isAscending ? item : (numberOfItems - item)
            
            attributes.slantedLayerMask = self.maskForItemAtIndexPath(indexPath)
            cachedAttributes.append(attributes)
            cachedContentSize += size
            
            position += size + lineSpacing - CGFloat(slantingSize)
        }
    }
    
    /// :nodoc:
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cachedAttributes.filter { attributes in
            return attributes.frame.intersects(rect)
        }
    }
    
    /// :nodoc:
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> CollectionViewSlantedLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
}
