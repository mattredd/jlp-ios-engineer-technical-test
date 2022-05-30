//
//  ProductDetailView.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct ProductDetailView: View {
    
    @StateObject var detailViewModel: ProductDetailViewModel
    @State var productDescription: AttributedString?
    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    
    var body: some View {
        ScrollView {
            VStack {
                if hSizeClass == .regular && vSizeClass == .regular {
                    Text(detailViewModel.product.title)
                        .font(.title.weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack(alignment: .top) {
                    VStack {
                        IStack {
                            if hSizeClass != .regular || vSizeClass != .regular {
                                Text(detailViewModel.product.title)
                                    .font(.title.weight(.semibold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .onLongPressGesture {
                                        UIPasteboard.general.setValue(detailViewModel.product.code, forPasteboardType: UTType.plainText.identifier)
                                    }
                            }
                            ProductImageViewer()
                                .environmentObject(detailViewModel)
                                .aspectRatio(1, contentMode: .fit)
                                .frame(maxWidth: UIConstants.ProductDetail.maximumImageViewWidth)
                                .accessibilityHidden(true)
                        }
                        if hSizeClass != .regular || vSizeClass != .regular {
                            ProductDetailPriceView(product: detailViewModel.product, productFull: detailViewModel.productAdditionals)
                        }
                        Text("Product Information")
                            .font(.title2.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, UIConstants.systemSpacing)
                        Text("Product Code: \(detailViewModel.product.code)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.bottom, UIConstants.compactSystemSpacing)
                        if let productDescription = productDescription {
                            Text(productDescription)
                        } else {
                            Text("Product description is unavailable")
                                .foregroundColor(.secondary)
                        }
                        ProductFeatureView(productFeatures: detailViewModel.productAdditionals?.details.features.first?.attributes)
                    }
                    if hSizeClass == .regular && vSizeClass == .regular {
                        Divider()
                        ProductDetailPriceView(product: detailViewModel.product, productFull: detailViewModel.productAdditionals)
                            .padding(.trailing, UIConstants.systemSpacing)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear(perform: parseProductDescription)
    }
    
    func parseProductDescription() {
        if let productDetails = detailViewModel.productAdditionals?.details.productInformation, var attributedString = productDetails.attributedStringFromHTML(css: UIConstants.appCSS) {
            attributedString.foregroundColor = UIColor.label
            productDescription = attributedString
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ProductDetailViewModel(product: FileProductService().fetchProducts()!.first!, productService: FileProductService())
        ProductDetailView(detailViewModel: vm)
    }
}
