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
    
    internal var images = [UIImage]()
    
    let reuseIdentifier = "customViewCell"
    
    let numberOfItems = 13

    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 1...numberOfItems {
            let image = UIImage(named: "image-\(index).jpg")
            if image != nil {
                images.append(image!)
            }
        }
        
        self.navigationController?.isNavigationBarHidden = true
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
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionCell
            
            cell.image = images[indexPath.row]

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
        return collectionViewLayout.scrollDirection == .vertical ? 225 : 325
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

