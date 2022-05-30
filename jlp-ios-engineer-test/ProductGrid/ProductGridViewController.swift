import UIKit
import Combine

class ProductGridViewController: UIViewController {

    let viewModel: ProductGridViewModel
    let coordinator: MainCoordinator
    let datasource: ProductGridDatasource
    let collectionView: UICollectionView
    let gridLayout = UICollectionViewFlowLayout()
    let gridManager: GridManager
    var cancellables: Set<AnyCancellable> = []
    var loadingView: UIStackView?
    let errorMessageLabel = UILabel()
    
    init(coordinator: MainCoordinator, viewModel: ProductGridViewModel) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: gridLayout)
        datasource = ProductGridDatasource(collectionView: collectionView, homeViewModel: viewModel, imageService: NetworkImageService())
        self.gridManager = GridManager { product in
            coordinator.selectedProduct(product)
        }
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .secondarySystemBackground
        setupCancellables()
        setupCollectionView()
        setupLoadingView()
        setupErrorMessageLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gridManager.invalidateSizeCache()
        gridLayout.invalidateLayout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        gridManager.invalidateSizeCache()
        gridLayout.invalidateLayout()
    }
    
    func setupCancellables() {
        viewModel.$products.sink { [weak self] products in
            self?.gridManager.invalidateSizeCache()
            self?.gridManager.products = products
            self?.datasource.updateCollectionView(items: products)
        }.store(in: &cancellables)
        viewModel.$isLoading.sink { [weak self] loading in
            self?.loadingView?.alpha = loading ? 1 : 0
        }.store(in: &cancellables)
        viewModel.$errorMessage.sink { [weak self] errorMessage in
            self?.errorMessageLabel.text = errorMessage
            self?.errorMessageLabel.alpha = errorMessage.isEmpty ? 0 : 1
        }.store(in: &cancellables)
    }
}

extension ProductGridViewController {
    
    func setupErrorMessageLabel() {
        errorMessageLabel.text = viewModel.errorMessage
        errorMessageLabel.font = .preferredFont(forTextStyle: .title3)
        errorMessageLabel.textColor = .secondaryLabel
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorMessageLabel)
        errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorMessageLabel.alpha = viewModel.errorMessage.isEmpty ? 0 : 1
    }
    
    func setupLoadingView() {
        let loadingLabel = UILabel()
        loadingLabel.text = "Loading"
        loadingLabel.textColor = .secondaryLabel
        loadingLabel.font = .preferredFont(forTextStyle: .title3)
        loadingLabel.textAlignment = .center
        let loadingActivity = UIActivityIndicatorView()
        loadingActivity.startAnimating()
        loadingActivity.color = .secondaryLabel
        loadingView = UIStackView(arrangedSubviews: [loadingActivity, loadingLabel])
        loadingView!.axis = .vertical
        loadingView!.spacing = UIConstants.systemSpacing
        loadingView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView!)
        NSLayoutConstraint.activate([
            loadingView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        loadingView!.alpha = viewModel.isLoading ? 1 : 0
    }
    
    func setupCollectionView() {
        collectionView.delegate = gridManager
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        collectionView.backgroundColor = .secondarySystemBackground
    }
}
