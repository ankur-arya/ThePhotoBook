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
            let transition:CATransition = CATransition()
            transition.duration = 0.6
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            navigationController.view.layer.add(transition, forKey: kCATransition)
            navigationController.pushViewController(imageDetailsViewController, animated: false)
        }
    }
}
