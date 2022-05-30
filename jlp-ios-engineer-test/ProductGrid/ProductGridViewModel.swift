//
//  ProductGridViewModel.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import SwiftUI

class ProductGridViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    let gridProductService: ProductService
    
    init(productService: ProductService) {
        gridProductService = productService
        fetchProducts()
    }
    
    func fetchProducts() {
        errorMessage = ""
        defer { isLoading = false }
        isLoading = true
        if let fetchedProducts = gridProductService.fetchProducts() {
            products = fetchedProducts
            isLoading = false
            if products.isEmpty {
                errorMessage = "No products found"
            }
        }  else {
            errorMessage = "Unable to load products"
        }
    }
}
