//
//  ViewController.swift
//  CollectionViewSlantedLayout
//
//  Created by Yassir Barchi on 02/28/2016.
//  Copyright (c) 2016 Yassir Barchi. All rights reserved.
//

import UIKit

import CollectionViewSlantedLayout

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: CollectionViewSlantedLayout!

    internal var covers = [[String:String]]()

    let reuseIdentifier = "customViewCell"
    
    override func loadView() {
        super.loadView()
        if let url = Bundle.main.url(forResource: "covers", withExtension: "plist") {
            covers = (NSArray(contentsOf: url) as! [[String:String]])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        collectionViewLayout.isFistCellExcluded = true
        collectionViewLayout.isLastCellExcluded = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSettings" {
            let settingsController = segue.destination as! SettingsController            
            let layout = collectionView.collectionViewLayout as! CollectionViewSlantedLayout
            settingsController.collectionViewLayout = layout
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return covers.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionCell
        
        cell.image = UIImage(named: covers[indexPath.row]["picture"]!)!

        if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
            cell.contentView.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
        }
        
        return cell
    }
}

extension ViewController: CollectionViewDelegateSlantedLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("Did select item at indexPath: [\(indexPath.section)][\(indexPath.row)]")
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: CollectionViewSlantedLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGFloat {
        return collectionViewLayout.scrollDirection == .vertical ? 275 : 325
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = self.collectionView else {return}
        guard let visibleCells = collectionView.visibleCells as? [CustomCollectionCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = ((collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight) * yOffsetSpeed
            let xOffset = ((collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth) * xOffsetSpeed
            parallaxCell.offset(CGPoint(x: xOffset,y :yOffset))
        }
    }
}

