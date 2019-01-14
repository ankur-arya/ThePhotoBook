import UIKit

protocol ImageDetailsRouterPresenterProtocol {
    func showImageDetails(for model: ImageModel)
}

/// Presenter class for image details router.
class ImageDetailsRouterPresenter: ImageDetailsRouterPresenterProtocol {
    
    /// Function to show image details view.
    ///
    /// - Parameter model: feed data model
    func showImageDetails(for model: ImageModel) {
        self.router?.showImageDetails(for: model)
    }
    
    var router: ImageDetailsRouterProtocol?
    
    /// Initializer
    ///
    /// - Parameter router: image details router protocol.
    init(router: ImageDetailsRouterProtocol) {
        self.router = router
    }
}
