import UIKit

protocol UserDetailsRouterProtocol {
    func showUserDetails(for model: UserModel)
}

/// Router class for image details.
class UserDetailsRouter: UserDetailsRouterProtocol {
    private var presentingViewController: UIViewController?
    
    /// Initializer
    ///
    /// - Parameter viewController: presenting view controller.
    init(viewController: UIViewController) {
        presentingViewController = viewController
    }
    
    /// Function to show image details view.
    ///
    /// - Parameter model: feeddata model
    func showUserDetails(for model: UserModel) {
        guard let navigationController = presentingViewController?.navigationController else {
            assertionFailure("Navigation Controller not found.")
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let userDetailsViewController = storyboard.instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController {
            userDetailsViewController.user = model
            
            let transition:CATransition = CATransition()
            transition.duration = 0.6
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            navigationController.view.layer.add(transition, forKey: kCATransition)
            navigationController.pushViewController(userDetailsViewController, animated: false)
            
        }
    }
}
