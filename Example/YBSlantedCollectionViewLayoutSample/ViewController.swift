//
//  ViewController.swift
//  YBSlantedCollectionViewLayout
//
//  Created by Yassir Barchi on 02/28/2016.
//  Copyright (c) 2016 Yassir Barchi. All rights reserved.
//

import UIKit

import YBSlantedCollectionViewLayout

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
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Slide)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Slide
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
            
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSettings" {
            let navigation = segue.destinationViewController as! UINavigationController

            let settingsController = navigation.viewControllers[0] as! SettingsController
            
            let layout = collectionView.collectionViewLayout as! YBSlantedCollectionViewLayout
            settingsController.collectionViewLayout = layout
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionCell
            
            cell.image = images[indexPath.row]

            return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        NSLog("Did select item at indexPath: [\(indexPath.section)][\(indexPath.row)]")
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard let collectionView = self.collectionView else {return}
        guard let visibleCells = collectionView.visibleCells() as? [CustomCollectionCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = ((collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight) * yOffsetSpeed
            let xOffset = ((collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth) * xOffsetSpeed
            parallaxCell.offset(CGPointMake(xOffset, yOffset))
        }
    }
}

