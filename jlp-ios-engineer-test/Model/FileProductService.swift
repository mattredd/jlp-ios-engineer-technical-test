//
//  FileProductProvider.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import Foundation

struct FileProductService: ProductService {
    
    func fetchProducts() -> [Product]? {
        Bundle.main.jsonObject(from: "data", fileExtension: "json", type: ProductResponse.self)?.products
    }
    
    func fetchProductDescription(id: String) -> ProductAdditionalInformation? {
        Bundle.main.jsonObject(from: "data2", fileExtension: "json", type: ProductFullResponse.self)?.detailsData.first { $0.productId == id }
    }
}
