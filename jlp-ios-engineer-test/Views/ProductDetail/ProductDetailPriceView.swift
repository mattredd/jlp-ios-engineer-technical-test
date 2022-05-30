//
//  ProductDetailPriceView.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import SwiftUI

struct ProductDetailPriceView: View {
    
    let product: Product
    let productFull: ProductAdditionalInformation?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let previousPrice = product.price.previousPriceString {
                Text(previousPrice)
                    .strikethrough()
            }
            Text(product.price.currentPriceString)
                .font(.title3.weight(.semibold))
            if !product.promotions.promotionString().isEmpty {
                Text(product.promotions.promotionString())
                    .foregroundColor(.red)
            }
            if let includedServices = productFull?.additionalServices.includedServices {
                Text(includedServices.joined(separator: "\n"))
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
