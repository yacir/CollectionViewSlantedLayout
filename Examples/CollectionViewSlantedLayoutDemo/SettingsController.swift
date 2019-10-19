//
//  SettingsController.swift
//  CollectionViewSlantedLayoutDemo
//
//  Created by Yassir Barchi on 28/02/2016.
//  Copyright © 2016-present Yassir Barchi. All rights reserved.
//

import Foundation

import UIKit

import CollectionViewSlantedLayout

class SettingsController: UITableViewController {

    weak var collectionViewLayout: CollectionViewSlantedLayout!

    @IBOutlet weak var slantingDirectionSegment: UISegmentedControl!
    @IBOutlet weak var scrollDirectionSegment: UISegmentedControl!
    @IBOutlet weak var zIndexOrderSegment: UISegmentedControl!
    @IBOutlet weak var firstCellSlantingSwitch: UISwitch!
    @IBOutlet weak var lastCellSlantingSwitch: UISwitch!
    @IBOutlet weak var slantingSizeSlider: UISlider!
    @IBOutlet weak var lineSpacingSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        slantingDirectionSegment.selectedSegmentIndex = (collectionViewLayout.slantingDirection == .downward) ? 0 : 1
        scrollDirectionSegment.selectedSegmentIndex = (collectionViewLayout.scrollDirection == .horizontal) ? 0 : 1
        zIndexOrderSegment.selectedSegmentIndex = (collectionViewLayout.zIndexOrder == .descending) ? 0 : 1
        firstCellSlantingSwitch.isOn = collectionViewLayout.isFirstCellExcluded
        lastCellSlantingSwitch.isOn = collectionViewLayout.isLastCellExcluded
        slantingSizeSlider.value = Float(collectionViewLayout.slantingSize)
        lineSpacingSlider.value = Float(collectionViewLayout.lineSpacing)
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }

    @IBAction func slantingDirectionChanged(_ sender: UISegmentedControl) {
        collectionViewLayout.slantingDirection = (sender.selectedSegmentIndex == 0 ? .downward : .upward )
    }

    @IBAction func scrollDirectionChanged(_ sender: UISegmentedControl) {
        collectionViewLayout.scrollDirection = (sender.selectedSegmentIndex == 0 ? .horizontal : .vertical)
    }

    @IBAction func zIndexOrderChanged(_ sender: UISegmentedControl) {
        collectionViewLayout.zIndexOrder = (sender.selectedSegmentIndex == 0 ? .descending : .ascending)
    }

    @IBAction func firstCellSlantingSwitchChanged(_ sender: UISwitch) {
        collectionViewLayout.isFirstCellExcluded = sender.isOn
    }

    @IBAction func lastCellSlantingSwitchChanged(_ sender: UISwitch) {
        collectionViewLayout.isLastCellExcluded = sender.isOn
    }

    @IBAction func slantingSizeChanged(_ sender: UISlider) {
        collectionViewLayout.slantingSize = UInt(sender.value)
    }

    @IBAction func lineSpacingChanged(_ sender: UISlider) {
        collectionViewLayout.lineSpacing = CGFloat(sender.value)
    }
    @IBAction func done(_ sender: AnyObject) {
        presentingViewController?.dismiss(animated: true, completion: { [weak self] () -> Void in
            let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
            self?.collectionViewLayout.collectionView?.scrollRectToVisible(rect, animated: true)
        })
    }
}
