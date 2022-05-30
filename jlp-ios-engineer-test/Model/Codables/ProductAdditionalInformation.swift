//
//  ProductAdditionalInformation.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import Foundation

struct ProductAdditionalInformation: Codable {
    let productId: String
    let details: ProductDetail
    let additionalServices: ProductAdditionalService
}

struct ProductFullResponse: Codable {
    let detailsData: [ProductAdditionalInformation]
}

struct ProductAdditionalService: Codable {
    let includedServices: [String]
}
