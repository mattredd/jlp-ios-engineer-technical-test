//
//  ProdcutDetailViewModel.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import Foundation
import UIKit

@MainActor
class ProductDetailViewModel: ObservableObject {
    
    @Published var productAdditionals : ProductAdditionalInformation?
    @Published var images: [ImageLoadingState]
    let imageService = NetworkImageService()
    let product: Product
    let imagesURLs: [URL]
    let productDetailService: ProductService
    
    init(product: Product, productService: ProductService) {
        self.product = product
        self.imagesURLs = [product.imageURL] + product.alternativeImageURLs
        images = Array(repeating: .uninitialised, count: imagesURLs.count)
        self.productDetailService = productService
        fetchProductDetails()
    }
    
    func fetchProductDetails() {
        productAdditionals = productDetailService.fetchProductDescription(id: product.productId)
    }
    
    func fetchImage(index: Int) async  {
        switch images[index] {
        case .loading, .loaded(img: _):
            return
        case .uninitialised, .error:
            images[index] = .loading
            if let image = try? await imageService.fetchImage(url: imagesURLs[index]), let scaledImage = image.cgImage?.scaleImage(maxSide: CGFloat(ImageSize.medium.rawValue)) {
                images[index] = .loaded(img: UIImage(cgImage: scaledImage))
            } else {
                images[index] = .error
            }
        }
    }
}
