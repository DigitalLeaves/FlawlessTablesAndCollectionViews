//
//  LazyLoadCollectionViewController.swift
//  iOSLazyImageLoad
//
//  Created by Ignacio Nieto Carvajal on 7/2/16.
//  Copyright © 2016 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

private let kLazyLoadScreenSize = UIScreen.main.bounds.width
private let kLazyLoadCellImageViewTag = 1
private let kLazyLoadSpan: CGFloat = 10.0
private let kLazyLoadAspectRatio: CGFloat = 1.0 // width / height aspect ratio for non square cells.
private let kLazyLoadColumnsPerRow: CGFloat = 3.0 // number of columns for every row.

class LazyLoadCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // outlets
    @IBOutlet weak var collectionView: UICollectionView!
    // data
    var cellSize = CGSize.zero
    var entries: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calculateCellWidth()
        self.entries = ImageManager.sharedInstance.getImageURLList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateCellWidth() {
        let width = (kLazyLoadScreenSize - (CGFloat(kLazyLoadColumnsPerRow + 1.0) * kLazyLoadSpan)) / CGFloat(kLazyLoadColumnsPerRow) - 1
        let height = width * kLazyLoadAspectRatio // square factor: 1
        self.cellSize = CGSize(width: width, height: height)
    }
    
    // MARK: - UICollectionViewDelegate/DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LazyLoadCollectionViewCell", for: indexPath)
        updateImageForCell(cell, inCollectionView: collectionView, withEntry: entries[(indexPath as NSIndexPath).row], atIndexPath: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func updateImageForCell(_ cell: UICollectionViewCell, inCollectionView collectionView: UICollectionView, withEntry: String, atIndexPath indexPath: IndexPath) {
        let imageView = cell.viewWithTag(kLazyLoadCellImageViewTag) as! UIImageView
        imageView.image = kLazyLoadPlaceholderImage
        // load image.
        let imageURL = entries[(indexPath as NSIndexPath).row]
        ImageManager.sharedInstance.downloadImageFromURL(imageURL) { (success, image) -> Void in
            if success && image != nil {
                if (collectionView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                    imageView.image = image
                }
            }
        }
    }
    
    // MARK: - Lazy Loading of cells
    
    func loadImagesForOnscreenRows() {
        if entries.count > 0 {
            let visiblePaths = collectionView.indexPathsForVisibleItems
            for indexPath in visiblePaths {
                let entry = entries[(indexPath as NSIndexPath).row]
                let cell = collectionView(self.collectionView, cellForItemAt: indexPath)
                updateImageForCell(cell, inCollectionView: collectionView, withEntry: entry, atIndexPath: indexPath)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { loadImagesForOnscreenRows() }
    }
}
