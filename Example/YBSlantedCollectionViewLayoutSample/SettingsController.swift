//
//  SettingsController.swift
//  YBSlantedCollectionViewLayoutSample
//
//  Created by Yassir Barchi on 28/02/2016.
//  Copyright © 2016 Yassir Barchi. All rights reserved.
//

import Foundation

import UIKit

import YBSlantedCollectionViewLayout

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
        
        self.reverseSlantingDirectionSwitch.isOn = self.collectionViewLayout.reverseSlantingAngle
        self.firstCellSlantingSwitch.isOn = self.collectionViewLayout.firstCellSlantingEnabled
        self.lastCellSlantingSwitch.isOn = self.collectionViewLayout.lastCellSlantingEnabled
        self.scrollDirectionSwitch.isOn = self.collectionViewLayout.scrollDirection == UICollectionViewScrollDirection.horizontal
        self.slantingDeltaSlider.value = Float(self.collectionViewLayout.slantingDelta)
        self.lineSpacingSlider.value = Float(self.collectionViewLayout.lineSpacing)
        
        
        UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.slide)

    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }

    @IBAction func slantingDirectionChanged(_ sender: UISwitch) {
        self.collectionViewLayout.reverseSlantingAngle = sender.isOn
    }
    
    @IBAction func firstCellSlantingSwitchChanged(_ sender: UISwitch) {
        self.collectionViewLayout.firstCellSlantingEnabled = sender.isOn
    }
    
    @IBAction func lastCellSlantingSwitchChanged(_ sender: UISwitch) {
        self.collectionViewLayout.lastCellSlantingEnabled = sender.isOn
    }
    
    @IBAction func scrollDirectionChanged(_ sender: UISwitch) {
        if sender.isOn {
            self.collectionViewLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        }
        else {
            self.collectionViewLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        }
        self.collectionViewLayout.collectionView?.reloadData()
    }
    
    
    @IBAction func slantingDeltaChanged(_ sender: UISlider) {
        self.collectionViewLayout.slantingDelta = UInt(sender.value)
    }
    
    @IBAction func lineSpacingChanged(_ sender: UISlider) {
        self.collectionViewLayout.lineSpacing = CGFloat(sender.value)
    }
    @IBAction func done(_ sender: AnyObject) {
        self.presentingViewController?.dismiss(animated: true, completion: { () -> Void in
            self.collectionViewLayout.collectionView?.scrollRectToVisible(CGRect(x: 0, y: 0, width: 0, height: 0), animated: true);
        })
    }
}
