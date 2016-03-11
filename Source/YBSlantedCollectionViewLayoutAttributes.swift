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

import UIKit

public class YBSlantedCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes {
    
    public var slantedLayerMask :CAShapeLayer?
    
    override public func copyWithZone(zone: NSZone) -> AnyObject {
        
        let attributesCopy = super.copyWithZone(zone) as! YBSlantedCollectionViewLayoutAttributes
        attributesCopy.slantedLayerMask = self.slantedLayerMask
        return attributesCopy
    }
    
    override public func isEqual(object: AnyObject?) -> Bool {
        
        if let o = object as? YBSlantedCollectionViewLayoutAttributes {
            if self.slantedLayerMask != o.slantedLayerMask {
                return false
            }
            return super.isEqual(object)
        }
        
        return false
    }
}
