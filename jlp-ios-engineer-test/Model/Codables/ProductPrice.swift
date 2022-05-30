//
//  ProductPrice.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import Foundation

struct ProductPrice: Codable {
    let was: String
    let then1: String
    let then2: String
    let now: String
    let uom: String
    let currency: String
    
    var currentPriceString: String {
        // Used code from to https://stackoverflow.com/questions/8712703/how-can-i-get-currency-symbols-from-currency-code-in-iphone to get the curreny symbol
        if let currencySymbol = Locale.availableIdentifiers.lazy.map({ Locale(identifier: $0) }).first(where: { $0.currencyCode == currency })?.currencySymbol {
            return "\(currencySymbol)\(now)"
        } else {
            return "\(currency)\(now)"
        }
    }
    
    var previousPriceString: String? {
        // Used code from to https://stackoverflow.com/questions/8712703/how-can-i-get-currency-symbols-from-currency-code-in-iphone to get the curreny symbol
        let currencySymbol = Locale.availableIdentifiers.lazy.map({ Locale(identifier: $0) }).first(where: { $0.currencyCode == currency })?.currencySymbol ?? currency
        if !then2.isEmpty {
            return "\(currencySymbol)\(then2)"
        } else if !then1.isEmpty {
            return "\(currencySymbol)\(then1)"
        } else if !was.isEmpty {
            return "\(currencySymbol)\(was)"
        } else {
            return nil
        }
    }
}
