//
//  ImageManager.swift
//  iOSLazyImageLoad
//
//  Created by Ignacio Nieto Carvajal on 7/2/16.
//  Copyright © 2016 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

private let _singletonInstance = ImageManager()
private let kLazyLoadMaxCacheImageSize = 20

class ImageManager: NSObject {
    var imageCache = [String: UIImage]()
    
    static var sharedInstance: ImageManager { return _singletonInstance }

    func cacheImage(image: UIImage, forURL url: String) {
        if imageCache.count > kLazyLoadMaxCacheImageSize { // free old images first.
            imageCache.removeAtIndex(imageCache.startIndex)
        }
        imageCache[url] = image
    }
    
    func getImageURLList() -> [String] { return kLazyLoadImages }
    
    func cachedImageForURL(url: String) -> UIImage? { return imageCache[url] }
    
    func clearCache() { imageCache.removeAll() }
    
    func downloadImageFromURL(urlString: String, completion: ((success: Bool, image: UIImage?) -> Void)?) {
        // do we have this cached?
        if let cachedImage = cachedImageForURL(urlString) {
            dispatch_async(dispatch_get_main_queue(), {completion?(success: true, image: cachedImage) })
        } else if let url = NSURL(string: urlString) { // download from URL asynchronously
            let session = NSURLSession.sharedSession()
            let downloadTask = session.downloadTaskWithURL(url, completionHandler: { (retrievedURL, response, error) -> Void in
                var found = false
                if error != nil { print("Error downloading image \(url.absoluteString): \(error!.localizedDescription)") }
                else if retrievedURL != nil {
                    if let data = NSData(contentsOfURL: retrievedURL!) {
                        if let image = UIImage(data: data) {
                            found = true
                            self.cacheImage(image, forURL: url.absoluteString)
                            dispatch_async(dispatch_get_main_queue(), { completion?(success: true, image: image) });
                        }
                    }
                }
                if !found { dispatch_async(dispatch_get_main_queue(), { completion?(success: false, image: nil) }); }
            })
            downloadTask.resume()
        } else { completion?(success: false, image: nil) }
    }
    
}
