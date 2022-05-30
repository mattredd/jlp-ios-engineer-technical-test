//
//  ImageTests.swift
//  jlp-ios-engineer-testTests
//
//  Created by Matthew Reddin on 27/05/2022.
//

import XCTest
@testable import jlp_ios_engineer_test

class ImageTests: XCTestCase {
    
    var product: Product!
    var imageService: ImageService!

    override func setUpWithError() throws {
        product = FileProductService().fetchProducts()!.first!
        imageService = NetworkImageService()
    }

    func testImageService() async {
        do {
            let image = try await imageService.fetchImage(url: product.imageURL)
            XCTAssertTrue(image.size != .zero, "Image size is zero")
            let imageCache = ImageCache.shared
            XCTAssertNotNil(imageCache.fetchImage(path: product.imageURL.absoluteString), "Image is not cached.")
        }
        catch {
            XCTFail("Image service failed.")
        }
    }
    
    func testImageScaling() async {
        do {
            let image = try await imageService.fetchImage(url: product.imageURL)
            let scaleSize = 200.0
            if let scaledImage = image.cgImage?.scaleImage(maxSide: scaleSize) {
                XCTAssertTrue(scaledImage.width == Int(scaleSize) || scaledImage.height == Int(scaleSize), "Image scaled to wrong size")
            } else {
                XCTFail("Unable to scale image")
            }
        }
        catch {
            XCTFail("Image service failed.")
        }
    }

}
