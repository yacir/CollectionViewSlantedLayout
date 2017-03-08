
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
        
        self.collectionView!.register(YBSlantedCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
        return cell
    }
    
    
}

