import UIKit

protocol FullImagesRouterProtocol {
    func showFullImages(for model: [ImageModel], index: IndexPath)
}

/// Router class for full image.
class FullImagesRouter: FullImagesRouterProtocol {
    private var presentingViewController: UIViewController?
    
    /// Initializer
    ///
    /// - Parameter viewController: presenting view controller.
    init(viewController: UIViewController) {
        presentingViewController = viewController
    }
    
    /// Function to show full image view.
    ///
    /// - Parameter model: ImageModel models
    internal func showFullImages(for model: [ImageModel], index: IndexPath) {
        guard let navigationController = presentingViewController?.navigationController else {
            assertionFailure("Navigation Controller not found.")
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let fullImagesViewController = storyboard.instantiateViewController(withIdentifier: "FullImageViewController") as? FullImageViewController {
            fullImagesViewController.images = model
            fullImagesViewController.selectedIndex = index
            navigationController.present(fullImagesViewController, animated: true, completion: nil)
        }
    }
}
