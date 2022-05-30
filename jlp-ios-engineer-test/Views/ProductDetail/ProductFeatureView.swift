//
//  ProductSpecificationView.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import SwiftUI

struct ProductFeatureView: View {
    
    let productFeatures: [ProductFeature]?
    let dividingLineOpacity = 0.4
    
    var body: some View {
        LazyVStack {
            Text("Product Specifications")
                .font(.title3.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            if let productFeatures = productFeatures {
                ForEach(productFeatures, id: \.name) {
                    ProductFeatureCellView(productFeature: $0)
                    Divider()
                        .opacity(dividingLineOpacity)
                        .padding(.horizontal)
                }
            } else {
                Text("Product specifications are unavailable")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.bottom, UIConstants.systemSpacing)
        .background(Color(uiColor: .secondarySystemBackground).cornerRadius(UIConstants.cornerRadius))
    }
}
