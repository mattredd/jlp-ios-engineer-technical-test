//
//  Promotions.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import Foundation

struct Promotions: Codable {
    
    struct CustomPromotion: Codable {
        let customSpecialOfferId: String?
        let longDescription: String?
        let siteDisplayName: String?
    }
    
    let reducedToClear: Bool
    let priceMatched: String
    let offer: String
    let customPromotionalMessage: String
    let bundleHeadline: String
    let customSpecialOffer: CustomPromotion?
    
    func promotionString() -> String {
        var promotionString = ""
        if reducedToClear {
            promotionString += "Reduced to Clear\n"
        }
        if !priceMatched.isEmpty {
            promotionString += "\(priceMatched)\n"
        }
        if !offer.isEmpty {
            promotionString += "\(offer)\n"
        }
        if !customPromotionalMessage.isEmpty {
            promotionString += "\(customPromotionalMessage)\n"
        }
        if !bundleHeadline.isEmpty {
            promotionString += "\(bundleHeadline)\n"
        }
        if let customSpecialOffer = customSpecialOffer, let specialOfferText = customSpecialOffer.siteDisplayName {
            promotionString += "\(specialOfferText)\n"
        }
        if !promotionString.isEmpty {
            promotionString.removeLast()
        }
        return promotionString
    }
}
