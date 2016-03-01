//
//  CustomCollectionCell.swift
//  YBSlantedCollectionViewLayout
//
//  Created by Yassir Barchi on 28/02/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

import UIKit

let yOffsetSpeed: CGFloat = 150.0
let xOffsetSpeed: CGFloat = 100.0

class CustomCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    
    var imageHeight: CGFloat {
        return (imageView?.image?.size.height) ?? 0.0
    }
    
    var imageWidth: CGFloat {
        return (imageView?.image?.size.width) ?? 0.0
    }

    
    func offset(offset: CGPoint) {
        imageView.frame = CGRectOffset(self.imageView.bounds, offset.x, offset.y)
    }
}