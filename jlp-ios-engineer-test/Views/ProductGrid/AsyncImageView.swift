//
//  AsyncImageView.swift
//  Top Media
//
//  Created by Matthew Reddin on 10/03/2022.
//

import UIKit

// A subclass of UIImageView that will load an image from a URL asynchronously
class AsyncImageView: UIImageView {
    
    var imageService: ImageService
    var imageSize: ImageSize
    var progressView = UIActivityIndicatorView()
    var imageURL: URL? {
        didSet {
            fetchImage()
        }
    }
    
    func fetchImage() {
        self.image = nil
        if let imageURL = imageURL {
            progressView.startAnimating()
            Task {
                if let image = try? await imageService.fetchImage(url: imageURL), let scaledImage = image.cgImage?.scaleImage(maxSide: CGFloat(imageSize.rawValue)) {
                    self.image = UIImage(cgImage: scaledImage)
                } else {
                    self.image = UIImage(systemName: "slash.circle")
                }
                progressView.stopAnimating()
            }
        }
    }
    
    init(path: String?, imageService: ImageService, imageSize: ImageSize) {
        self.imageService = imageService
        self.imageSize = imageSize
        super.init(frame: .zero)
        let config = UIImage.SymbolConfiguration(paletteColors: [.label])
        preferredSymbolConfiguration = config
        addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        fetchImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
