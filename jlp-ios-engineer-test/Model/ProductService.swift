//
//  ProductProvider.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import Foundation

protocol ProductService {
    func fetchProducts() -> [Product]?
    func fetchProductDescription(id: String) -> ProductAdditionalInformation?
}
