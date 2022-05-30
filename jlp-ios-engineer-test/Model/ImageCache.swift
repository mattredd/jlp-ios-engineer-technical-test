//
//  ImageProvider.swift
//  Books
//
//  Created by Matthew Reddin on 27/01/2022.
//

import Foundation
import UIKit

struct ImageCache {
    
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    func fetchImage(path: String) -> UIImage? {
        cache.object(forKey: path as NSString)
    }
    
    func setImage(for path: String, img: UIImage) {
        cache.setObject(img, forKey: path as NSString)
    }
}
