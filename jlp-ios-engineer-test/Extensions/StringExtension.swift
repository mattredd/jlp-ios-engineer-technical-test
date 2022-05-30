//
//  StringExtension.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import Foundation
import UIKit

extension String {
    
    func attributedStringFromHTML(css: String? = nil) -> AttributedString? {
        var attributedString: AttributedString?
        let htmlString = "\(css != nil ? "<style>\(css!)</style>\(self)" : "\(self)")"
        if let attributesString = try? NSAttributedString(data: Data(htmlString.utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding : String.Encoding.utf8.rawValue], documentAttributes: nil) {
            attributedString = AttributedString(attributesString)
        }
        return attributedString
    }
}
