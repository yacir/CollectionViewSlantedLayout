
//
//  CollectionViewController.swift
//  YBSlantedCollectionViewLayout
//
//  Created by Yassir Barchi on 23/03/2016.
//  Copyright © 2016 Yassir Barchi. All rights reserved.
//

import UIKit

@testable import YBSlantedCollectionViewLayout

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var items = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.registerClass(YBSlantedCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        // Configure the cell
        
        return cell
    }
    
    
}

