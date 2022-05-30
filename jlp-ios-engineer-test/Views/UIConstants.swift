//
//  UIConstants.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import Foundation

struct UIConstants {
    static let cornerRadius = 15.0
    static let systemSpacing = 8.0
    static let compactSystemSpacing = 4.0
    static let appCSS = """
        p {
        font-family: -apple-system;
        font-size: 14px;
        }
        p strong {
        font-family: -apple-system;
        font-size: 20px;
        """
    
    struct ProductGrid {
        static let numberOfColumnsProductGridPad = 4
        static let numberOfColumnsProductGridPhonePortrait = 2
        static let numberOfColumnsProductGridPhoneLandscape = 3
    }
    
    struct ProductDetail {
        static let maximumImageViewWidth = 500.0
    }
}
