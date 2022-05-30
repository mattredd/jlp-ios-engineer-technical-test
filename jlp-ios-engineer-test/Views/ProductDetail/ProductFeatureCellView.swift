//
//  SwiftUIView.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import SwiftUI

struct ProductFeatureCellView: View {
    
    @State var showTooltip = false
    let productFeature: ProductFeature
    
    var body: some View {
        HStack {
            VStack(spacing: UIConstants.systemSpacing) {
                Text(productFeature.name)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .accessibilityValue(productFeature.multivalued ? productFeature.values.joined(separator: ",") : productFeature.value)
                if showTooltip {
                    Text(productFeature.toolTip)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .transition(.opacity)
                }
                if !productFeature.toolTip.isEmpty {
                    Button {
                        withAnimation(.spring()) {
                            showTooltip.toggle()
                        }
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .accessibilityLabel("Show tooltip")
                }
            }
            .padding(UIConstants.systemSpacing)
            .background(Color(uiColor: .tertiarySystemBackground).cornerRadius(UIConstants.cornerRadius))
            .padding(.leading, UIConstants.systemSpacing)
            if productFeature.multivalued {
                Text(productFeature.values.joined(separator: ","))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, UIConstants.systemSpacing)
                    .accessibilityHidden(true)
            } else {
                Text(productFeature.value)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, UIConstants.systemSpacing)
                    .accessibilityHidden(true)
            }
        }
    }
}
