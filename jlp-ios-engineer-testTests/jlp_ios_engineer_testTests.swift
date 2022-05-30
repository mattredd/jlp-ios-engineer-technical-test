//
//  jlp_ios_engineer_testTests.swift
//  jlp-ios-engineer-testTests
//
//  Created by Chris Thomas on 11/05/2022.
//

import XCTest
@testable import jlp_ios_engineer_test

class jlp_ios_engineer_testTests: XCTestCase {
    
    var product: Product!

    override func setUpWithError() throws {
        product = FileProductService().fetchProducts()!.first!
    }

    func testFetchProducts() {
        let viewModel = ProductGridViewModel(productService: FileProductService())
        viewModel.fetchProducts()
        XCTAssertFalse(viewModel.products.isEmpty, "Unable to load products")
        XCTAssertFalse(viewModel.isLoading, "Product view model is still loading even though it is completed.")
    }
    
    func testFetchProductDetails() async {
        Task { @MainActor in
            let product = FileProductService().fetchProducts()!.first!
            let viewModel = ProductDetailViewModel(product: product, productService: FileProductService())
            viewModel.fetchProductDetails()
            XCTAssertTrue(viewModel.productAdditionals != nil, "Unable to load product details")
        }
    }

}
