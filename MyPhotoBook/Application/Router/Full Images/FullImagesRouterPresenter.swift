import UIKit

protocol FullImagesRouterPresenterProtocol {
    func showFullImages(for model: [ImageModel], index: IndexPath)
}

/// Presenter class for full image router.
class FullImagesRouterPresenter: FullImagesRouterPresenterProtocol {
    
    /// Function to show full image view.
    ///
    /// - Parameter model: ImageModel array
    internal func showFullImages(for model: [ImageModel], index: IndexPath) {
        self.router?.showFullImages(for: model, index: index)
    }
    
    var router: FullImagesRouterProtocol?
    var index: IndexPath?
    /// Initializer
    ///
    /// - Parameter router: full image router protocol.
    init(router: FullImagesRouterProtocol, index: IndexPath) {
        self.router = router
        self.index = index
    }
}
