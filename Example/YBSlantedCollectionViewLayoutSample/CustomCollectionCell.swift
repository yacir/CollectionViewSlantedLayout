//
//  CustomCollectionCell.swift
//  YBSlantedCollectionViewLayout
//
//  Created by Yassir Barchi on 28/02/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

import UIKit

import YBSlantedCollectionViewLayout

let yOffsetSpeed: CGFloat = 150.0
let xOffsetSpeed: CGFloat = 100.0

class CustomCollectionCell: YBSlantedCollectionViewCell {
    
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

    
    func offset(_ offset: CGPoint) {
        imageView.frame = self.imageView.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
}
