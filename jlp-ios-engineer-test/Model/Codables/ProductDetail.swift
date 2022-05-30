//
//  ProductDetail.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import Foundation

struct ProductDetail: Codable {
    let returns: String
    let returnsHeadline: String
    let termsAndConditions: String
    let productInformation: String
    let features: [ProductFeaturesResponse]
}

struct ProductFeaturesResponse: Codable {
    let attributes: [ProductFeature]
}

struct ProductFeature: Codable {
    let multivalued: Bool
    let name: String
    let toolTip: String
    let value: String
    let values: [String]
}
