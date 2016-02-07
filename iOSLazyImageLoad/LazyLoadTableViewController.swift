//
//  LazyLoadTableViewController.swift
//  iOSLazyImageLoad
//
//  Created by Ignacio Nieto Carvajal on 7/2/16.
//  Copyright © 2016 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

private let kLazyLoadCollectionCellImage = 1
private let kLazyLoadCollectionCellText = 2

class LazyLoadTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    // data
    var texts: [String] = []
    var images: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.texts = kLazyLoadTexts
        self.images = kLazyLoadImages
        
        // this is important for dynamic row height
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UITableViewDelegate/DataSource methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LazyLoadTableViewCell", forIndexPath: indexPath)
        
        // configure cell
        // 1. text
        let textLabel = cell.viewWithTag(kLazyLoadCollectionCellText) as! UILabel
        textLabel.text = texts[indexPath.row]
        
        // 2. image
        updateImageForCell(cell, inTableView: tableView, withImageURL: images[indexPath.row], atIndexPath: indexPath)
        
        return cell
    }
    
    func updateImageForCell(cell: UITableViewCell, inTableView tableView: UITableView, withImageURL: String, atIndexPath indexPath: NSIndexPath) {
        // clean image first
        let imageView = cell.viewWithTag(kLazyLoadCollectionCellImage) as! UIImageView
        imageView.image = kLazyLoadPlaceholderImage
        // load image.
        let imageURL = images[indexPath.row]
        ImageManager.sharedInstance.downloadImageFromURL(imageURL) { (success, image) -> Void in
            if success && image != nil {
                if tableView.indexPathForCell(cell)?.row == indexPath.row {
                    imageView.image = image
                }
            }
        }
    }
    
    func loadImagesForOnscreenRows() {
        if texts.count > 0 {
            let visiblePaths = tableView.indexPathsForVisibleRows ?? [NSIndexPath]()
            for indexPath in visiblePaths {
                let entry = images[indexPath.row]
                let cell = tableView(self.tableView, cellForRowAtIndexPath: indexPath)
                updateImageForCell(cell, inTableView: tableView, withImageURL: entry, atIndexPath: indexPath)
            }
        }
    }
    
    // MARK: - When decelerated or ended dragging, we must update visible rows
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }

    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { loadImagesForOnscreenRows() }
    }

    // MARK: - Dynamic row height for table view cells.
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
