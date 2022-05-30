//
//  GridManager.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import UIKit

class GridManager: NSObject, UICollectionViewDelegateFlowLayout {
    
    let tapAction: (Product) -> ()
    private var cacheCellSize: CGSize?
    var products: [Product] = []
    
    init(tapAction: @escaping (Product) -> ()) {
        self.tapAction = tapAction
    }
    
    func invalidateSizeCache() {
        cacheCellSize = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let cacheCellSize = cacheCellSize {
            return cacheCellSize
        }
        let numberOfColumns: Int
        if collectionView.traitCollection.verticalSizeClass == .regular && collectionView.traitCollection.horizontalSizeClass == .regular {
            numberOfColumns = UIConstants.ProductGrid.numberOfColumnsProductGridPad
        } else {
            if collectionView.traitCollection.verticalSizeClass == .compact {
                numberOfColumns = UIConstants.ProductGrid.numberOfColumnsProductGridPhoneLandscape
            } else {
                numberOfColumns = UIConstants.ProductGrid.numberOfColumnsProductGridPhonePortrait
            }
        }
        let horizontalPadding = Double(numberOfColumns + 1) * (UIConstants.systemSpacing)
        let cellWidth = (collectionView.frame.width * 0.99 - horizontalPadding) / Double(numberOfColumns)
        var maxHeight = 0.0
        for product in products {
            let titleHeight = (product.title as NSString).boundingRect(with: CGSize(width: cellWidth - UIConstants.systemSpacing * 2, height: .infinity), options: .usesLineFragmentOrigin, attributes: [.font : UIFont.preferredFont(forTextStyle: .body)], context: nil).height
            let priceHeight = (product.price.currentPriceString as NSString).boundingRect(with: CGSize(width: cellWidth - UIConstants.systemSpacing * 2, height: .infinity), options: [], attributes: [.font : UIFont.preferredFont(forTextStyle: .headline)], context: nil).height
            maxHeight = max(maxHeight, cellWidth + titleHeight + priceHeight + (UIConstants.systemSpacing * 2))
        }
        cacheCellSize = CGSize(width: cellWidth, height: maxHeight)
        return cacheCellSize!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: UIConstants.systemSpacing, left: UIConstants.systemSpacing, bottom: UIConstants.systemSpacing, right: UIConstants.systemSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapAction(products[indexPath.row])
    }
}
