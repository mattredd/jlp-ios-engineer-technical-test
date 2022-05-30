//
//  ImageService.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import UIKit

protocol ImageService {
    func fetchImage(url: URL) async throws -> UIImage
}

enum ImageServiceError: Error {
    case invalidURL
    case invalidResponse(statusCode: Int)
    case invalidReturnFormat
    case networkError
}
