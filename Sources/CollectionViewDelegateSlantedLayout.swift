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

/**
 The CollectionViewDelegateSlantedLayout protocol defines methods that let you coordinate with a
 CollectionViewSlantedLayout object to implement a slanted layout.
 The methods of this protocol define the size of items.
 */
@objc public protocol CollectionViewDelegateSlantedLayout: UICollectionViewDelegate {

    // MARK: Getting the Size of Items

    /**
     Asks the delegate for the size of the specified item’s cell.

     If you do not implement this method, the slanted layout uses the values in its itemSize property
     to set the size of items instead. Your implementation of this method can return a fixed set of
     sizes or dynamically adjust the sizes based on the cell’s content.

     - Parameters:
        - collectionView: The collection view object displaying the slanted layout.
        - collectionViewLayout: The layout object requesting the information.
        - indexPath: The index path of the item.
     - Returns: The height of the specified item (or it's width for vertical scrolling direction).
                The value must be greater than 0.
     */
    @objc optional func collectionView(_ collectionView: UICollectionView,
                                       layout collectionViewLayout: CollectionViewSlantedLayout,
                                       sizeForItemAt indexPath: IndexPath) -> CGFloat
}
