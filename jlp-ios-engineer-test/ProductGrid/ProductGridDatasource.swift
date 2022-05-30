//
//  ProductGridDatasource.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import UIKit
import Combine

class ProductGridDatasource {
    
    let collectionViewDatasource: UICollectionViewDiffableDataSource<Int, Product>
    
    init(collectionView: UICollectionView, homeViewModel: ProductGridViewModel, imageService: ImageService) {
        let cellRegistration = UICollectionView.CellRegistration<ProductViewCell, Product> { cell, indexPath, itemIdentifier in
            cell.contentConfiguration = ProductViewCell.ProductCellConfiguration(product: itemIdentifier, imageService: imageService)
        }
        collectionViewDatasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    func updateCollectionView(items: [Product]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Product>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        collectionViewDatasource.apply(snapshot)
    }
}
