//
//  MainCoordinator.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import UIKit
import SwiftUI

class MainCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let productService: ProductService
    
    init(navigationController: UINavigationController, productService: ProductService) {
        self.navigationController = navigationController
        self.productService = productService
    }
    
    func start() {
        let homeVC = ProductGridViewController(coordinator: self, viewModel: ProductGridViewModel(productService: productService))
        homeVC.title = "Dishwashers"
        navigationController.pushViewController(homeVC, animated: false)
    }
    
    func selectedProduct(_ product: Product) {
        Task { @MainActor in
            let detailView = UIHostingController(rootView: ProductDetailView(detailViewModel: ProductDetailViewModel(product: product, productService: self.productService)))
            navigationController.pushViewController(detailView, animated: true)
        }
    }
}
