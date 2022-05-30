//
//  ProductViewCell.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import UIKit

class ProductViewCell: UICollectionViewCell {
    
    class ProductCellContentView: UIView, UIContentView {
        
        let asyncImageView: AsyncImageView
        let titleLabel = UILabel()
        let priceLabel = UILabel()
        
        var configuration: UIContentConfiguration {
            didSet {
                updateViews()
            }
        }
        
        init(configuration: UIContentConfiguration, imageService: ImageService) {
            self.configuration = configuration
            // Have a temporary size for the cell until the collection view calculates the actual size
            asyncImageView = AsyncImageView(path: nil, imageService: imageService, imageSize: .thumbnail)
            super.init(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 400)))
            layer.cornerRadius = UIConstants.cornerRadius
            layer.masksToBounds = true
            backgroundColor = .systemBackground
            accessibilityHint = "Double tap to view more information"
            isAccessibilityElement = true
            setupImageView()
            setupTitleView()
            setupPriceView()
            updateViews()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupImageView() {
            asyncImageView.translatesAutoresizingMaskIntoConstraints = false
            asyncImageView.clipsToBounds = true
            asyncImageView.contentMode = .scaleAspectFit
            asyncImageView.isAccessibilityElement = false
            addSubview(asyncImageView)
            NSLayoutConstraint.activate([
                asyncImageView.topAnchor.constraint(equalTo: topAnchor),
                asyncImageView.heightAnchor.constraint(equalTo: asyncImageView.widthAnchor),
                asyncImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                asyncImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
        
        func setupTitleView() {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .left
            titleLabel.isAccessibilityElement = false
            titleLabel.font = .preferredFont(forTextStyle: .body)
            titleLabel.adjustsFontForContentSizeCategory = true
            addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: asyncImageView.bottomAnchor, constant: UIConstants.systemSpacing),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.systemSpacing),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.systemSpacing)
            ])
        }
        
        func setupPriceView() {
            priceLabel.translatesAutoresizingMaskIntoConstraints = false
            priceLabel.textAlignment = .left
            priceLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            priceLabel.adjustsFontForContentSizeCategory = true
            priceLabel.isAccessibilityElement = false
            addSubview(priceLabel)
            NSLayoutConstraint.activate([
                priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.compactSystemSpacing),
                priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.systemSpacing),
                priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.systemSpacing)
            ])
        }
        
        func updateViews() {
            guard let productConfiguration = configuration as? ProductCellConfiguration else { return }
            asyncImageView.imageURL = productConfiguration.productItem.imageURL
            titleLabel.text = productConfiguration.productItem.title
            priceLabel.text = productConfiguration.productItem.price.currentPriceString
            accessibilityLabel = productConfiguration.productItem.title
        }
    }
    
    class ProductCellConfiguration: UIContentConfiguration {
        
        let productItem: Product
        let imageService: ImageService
        
        init(product: Product, imageService: ImageService) {
            productItem = product
            self.imageService = imageService
        }
        
        func updated(for state: UIConfigurationState) -> Self {
            return self
        }
        
        func makeContentView() -> UIView & UIContentView {
            ProductCellContentView(configuration: self, imageService: imageService)
        }
    }
}
