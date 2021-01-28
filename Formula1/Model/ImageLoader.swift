//
//  ImageLoader.swift
//  Formula1
//
//  Created by Christian Kabouchy on 28/01/2021.
//

import Foundation
import UIKit

protocol ImageLoaderDelegate {
    func imageDidLoad (image : UIImage)
}

class ImageLoader {
    var delegate : ImageLoaderDelegate?
    var image = UIImage(systemName: "photo.fill")!
    var imageCache = ImageCache.getImageCache()
    var imageString : String?
    
    init(imageString:String?) {
        self.imageString = imageString
        load()
    }
    func load() {
        if loadImageFromCache(urlString: imageString) {
            return
        }
        loadImage(urlString: imageString)
    }
    
    func loadImage (urlString:String?) {
        if let safeUrl = urlString {
            guard let url = URL(string: safeUrl) else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data) ?? UIImage(systemName: "photo.fill")!
                    self.delegate?.imageDidLoad(image: self.image)
                    self.imageCache.set(forKey: urlString!, image: self.image)
                    print("load")
                }
            }
            task.resume()
        }
    }
    
    func loadImageFromCache(urlString:String?) -> Bool {
        guard let urlString = urlString else {
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        image = cacheImage
        delegate?.imageDidLoad(image: image)
        return true
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}

