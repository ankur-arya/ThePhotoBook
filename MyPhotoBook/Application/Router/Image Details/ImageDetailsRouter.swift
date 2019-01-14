import UIKit

protocol ImageDetailsRouterProtocol {
    func showImageDetails(for model: ImageModel)
}

/// Router class for image details.
class ImageDetailsRouter: ImageDetailsRouterProtocol {
    private var presentingViewController: UIViewController?
    
    /// Initializer
    ///
    /// - Parameter viewController: presenting view controller.
    init(viewController: UIViewController) {
        presentingViewController = viewController
    }
    
    /// Function to show image details view.
    ///
    /// - Parameter model: ImageModel model
    func showImageDetails(for model: ImageModel) {
        guard let navigationController = presentingViewController?.navigationController else {
            assertionFailure("Navigation Controller not found.")
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let imageDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ImageDetailsViewController") as? ImageDetailsViewController {
            imageDetailsViewController.imageDetails = model
            navigationController.pushViewController(imageDetailsViewController, animated: true)
        }
    }
}
