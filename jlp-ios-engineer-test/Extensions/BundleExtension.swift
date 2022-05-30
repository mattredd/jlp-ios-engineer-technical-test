//
//  BundleExtension.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import Foundation

extension Bundle {
    
    func jsonObject<T: Decodable>(from fileName: String, fileExtension: String, type: T.Type) -> T? {
        if let url = self.url(forResource: fileName, withExtension: fileExtension), let data = try? Data(contentsOf: url) {
            return try! JSONDecoder().decode(type, from: data)
        } else {
            return nil
        }
    }
}
