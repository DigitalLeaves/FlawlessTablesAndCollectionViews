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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LazyLoadTableViewCell", for: indexPath)
        
        // configure cell
        // 1. text
        let textLabel = cell.viewWithTag(kLazyLoadCollectionCellText) as! UILabel
        textLabel.text = texts[(indexPath as NSIndexPath).row]
        
        // 2. image
        updateImageForCell(cell, inTableView: tableView, withImageURL: images[(indexPath as NSIndexPath).row], atIndexPath: indexPath)
        
        return cell
    }
    
    func updateImageForCell(_ cell: UITableViewCell, inTableView tableView: UITableView, withImageURL: String, atIndexPath indexPath: IndexPath) {
        // clean image first
        let imageView = cell.viewWithTag(kLazyLoadCollectionCellImage) as! UIImageView
        imageView.image = kLazyLoadPlaceholderImage
        // load image.
        let imageURL = images[(indexPath as NSIndexPath).row]
        ImageManager.sharedInstance.downloadImageFromURL(imageURL) { (success, image) -> Void in
            if success && image != nil {
                if (tableView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                    imageView.image = image
                }
            }
        }
    }
    
    func loadImagesForOnscreenRows() {
        if texts.count > 0 {
            let visiblePaths = tableView.indexPathsForVisibleRows ?? [IndexPath]()
            for indexPath in visiblePaths {
                let entry = images[(indexPath as NSIndexPath).row]
                let cell = tableView(self.tableView, cellForRowAt: indexPath)
                updateImageForCell(cell, inTableView: tableView, withImageURL: entry, atIndexPath: indexPath)
            }
        }
    }
    
    // MARK: - When decelerated or ended dragging, we must update visible rows
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { loadImagesForOnscreenRows() }
    }

    // MARK: - Dynamic row height for table view cells.
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
