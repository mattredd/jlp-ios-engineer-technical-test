//
//  Product.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import Foundation

struct Product: Codable {
    let title: String
    let outOfStock: Bool
    let image: String
    let price: ProductPrice
    let promotions: Promotions
    let productId: String
    let code: String
    let alternativeImageUrls: [String]
    
    var imageURL: URL {
        URL(string: "https:" + image)!
    }
    
    var alternativeImageURLs: [URL] {
        alternativeImageUrls.map {
            URL(string: "https:" + $0)!
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case title, outOfStock, image, price, productId, code, alternativeImageUrls
        case promotions = "promoMessages"
    }
}

extension Product: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(productId)
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.productId == rhs.productId
    }
}

struct ProductResponse: Codable {
    let showInStockOnly: Bool
    let products: [Product]
}
