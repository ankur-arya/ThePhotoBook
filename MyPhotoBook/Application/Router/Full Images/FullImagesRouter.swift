import UIKit

protocol FullImagesRouterProtocol {
    func showFullImages(for model: [ImageModel], index: IndexPath)
}

/// Router class for image details.
class FullImagesRouter: FullImagesRouterProtocol {
    private var presentingViewController: UIViewController?
    
    /// Initializer
    ///
    /// - Parameter viewController: presenting view controller.
    init(viewController: UIViewController) {
        presentingViewController = viewController
    }
    
    /// Function to show image details view.
    ///
    /// - Parameter model: ImageModel models
    func showFullImages(for model: [ImageModel], index: IndexPath) {
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
