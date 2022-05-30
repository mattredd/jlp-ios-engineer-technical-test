//
//  BookService.swift
//  Books
//
//  Created by Matthew Reddin on 27/01/2022.
//

import Foundation
import UIKit

class NetworkImageService: ImageService {
    
    let cache = ImageCache.shared
    
    func fetchImage(url: URL) async throws -> UIImage {
        if let cachedImage = cache.fetchImage(path: url.absoluteString) {
            return cachedImage
        }
        do {
            let (imageData, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            let responseCode = (response as? HTTPURLResponse)?.statusCode
            guard responseCode == 200 else { throw ImageServiceError.invalidResponse(statusCode: responseCode ?? 400) }
            guard let image =  UIImage(data: imageData) else { throw  ImageServiceError.invalidReturnFormat }
            cache.setImage(for: url.absoluteString, img: image)
            return image
        }
        catch {
            if error is ImageServiceError {
                throw error
            } else {
                throw ImageServiceError.networkError
            }
        }
    }
}
