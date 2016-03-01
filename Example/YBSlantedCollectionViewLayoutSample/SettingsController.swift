//
//  SettingsController.swift
//  YBSlantedCollectionViewLayoutSample
//
//  Created by Yassir Barchi on 28/02/2016.
//  Copyright © 2016 Yassir Barchi. All rights reserved.
//

import Foundation

import UIKit

class SettingsController: UITableViewController {
    
    weak var collectionViewLayout: YBSlantedCollectionViewLayout!
    
    @IBOutlet weak var reverseSlantingDirectionSwitch: UISwitch!
    @IBOutlet weak var firstCellSlantingSwitch: UISwitch!
    @IBOutlet weak var lastCellSlantingSwitch: UISwitch!
    @IBOutlet weak var scrollDirectionSwitch: UISwitch!
    @IBOutlet weak var slantingDeltaSlider: UISlider!
    @IBOutlet weak var lineSpacingSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reverseSlantingDirectionSwitch.on = self.collectionViewLayout.reverseSlantingAngle
        self.firstCellSlantingSwitch.on = self.collectionViewLayout.firstCellSlantingEnabled
        self.lastCellSlantingSwitch.on = self.collectionViewLayout.lastCellSlantingEnabled
        self.scrollDirectionSwitch.on = self.collectionViewLayout.scrollDirection == UICollectionViewScrollDirection.Horizontal
        self.slantingDeltaSlider.value = Float(self.collectionViewLayout.slantingDelta)
        self.lineSpacingSlider.value = Float(self.collectionViewLayout.lineSpacing)
        
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Slide
    }

    @IBAction func slantingDirectionChanged(sender: UISwitch) {
        self.collectionViewLayout.reverseSlantingAngle = sender.on
    }
    
    @IBAction func firstCellSlantingSwitchChanged(sender: UISwitch) {
        self.collectionViewLayout.firstCellSlantingEnabled = sender.on
    }
    
    @IBAction func lastCellSlantingSwitchChanged(sender: UISwitch) {
        self.collectionViewLayout.lastCellSlantingEnabled = sender.on
    }
    
    @IBAction func scrollDirectionChanged(sender: UISwitch) {
        if sender.on {
            self.collectionViewLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        }
        else {
            self.collectionViewLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        }
        self.collectionViewLayout.collectionView?.reloadData()
    }
    
    
    @IBAction func slantingDeltaChanged(sender: UISlider) {
        self.collectionViewLayout.slantingDelta = UInt(sender.value)
    }
    
    @IBAction func lineSpacingChanged(sender: UISlider) {
        self.collectionViewLayout.lineSpacing = CGFloat(sender.value)
    }
    @IBAction func done(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.collectionViewLayout.collectionView?.scrollRectToVisible(CGRectMake(0, 0, 0, 0), animated: true);
        })
    }
}
