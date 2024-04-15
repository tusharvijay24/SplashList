//
//  ImageCachingManager.swift
//  SplashList
//
//  Created by Tushar on 13/04/24.
//

import UIKit

class ImageCachingManager {
    static let shared = ImageCachingManager()
    private let cache = NSCache<NSURL, UIImage>()
    private let fileManager = FileManager.default
    private lazy var mainDirectoryUrl: URL = {
        let documentsUrl = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return documentsUrl.appendingPathComponent("ImageCache")
    }()

    func getImage(url: URL) -> UIImage? {
        if let image = cache.object(forKey: url as NSURL) {
            print("Cache hit: \(url.lastPathComponent)")
            return image
        } else if let data = try? Data(contentsOf: mainDirectoryUrl.appendingPathComponent(url.lastPathComponent)), let image = UIImage(data: data) {
            print("Disk hit: \(url.lastPathComponent)")
            cache.setObject(image, forKey: url as NSURL) // Cache the image
            return image
        }
        print("Cache miss: \(url.lastPathComponent)")
        return nil
    }

    func saveImage(url: URL, image: UIImage) {
        let path = mainDirectoryUrl.appendingPathComponent(url.lastPathComponent)
        let data = image.pngData()
        do {
            try data?.write(to: path)
            print("Image saved to cache: \(url.lastPathComponent)")
            cache.setObject(image, forKey: url as NSURL) // Cache the image
        } catch {
            print("Failed to save image: \(error.localizedDescription)")
        }
    }
}
