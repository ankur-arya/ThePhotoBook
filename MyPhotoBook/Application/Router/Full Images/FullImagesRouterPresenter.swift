import UIKit

protocol FullImagesRouterPresenterProtocol {
    func showFullImages(for model: [ImageModel], index: IndexPath)
}

/// Presenter class for image details router.
class FullImagesRouterPresenter: FullImagesRouterPresenterProtocol {
    
    /// Function to show image details view.
    ///
    /// - Parameter model: feed data model
    func showFullImages(for model: [ImageModel], index: IndexPath) {
        self.router?.showFullImages(for: model, index: index)
    }
    
    var router: FullImagesRouterProtocol?
    var index: IndexPath?
    /// Initializer
    ///
    /// - Parameter router: image details router protocol.
    init(router: FullImagesRouterProtocol, index: IndexPath) {
        self.router = router
        self.index = index
    }
}
